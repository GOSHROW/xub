#include "alloc_profile.h"

#ifdef XUB_ALLOC_PROFILE
#error "Compile the allocation wrapper without XUB_ALLOC_PROFILE"
#endif

#include <errno.h>
#include <stdio.h>
#include <string.h>

#define XP_MAGIC UINT64_C(0x585542616c6c6f63)

/* malloc supplies max_align_t alignment, and the union size is a multiple of
 * that alignment. Advancing by one header preserves alignment of its payload. */
typedef union {
    struct { size_t bytes; uint64_t magic; } record;
    max_align_t alignment;
} xp_header;

static xp_stats stats;
static size_t remaining_attempts;
static int fail_enabled;

static xp_header *checked_header(void *pointer) {
    xp_header *header = (xp_header *)pointer - 1;
    if (header->record.magic != XP_MAGIC) {
        fputs("Allocation profiler received an untracked pointer\n", stderr);
        abort();
    }
    return header;
}

static void update_peaks(void) {
    if (stats.live_bytes > stats.peak_live_bytes)
        stats.peak_live_bytes = stats.live_bytes;
    if (stats.live_allocations > stats.peak_live_allocations)
        stats.peak_live_allocations = stats.live_allocations;
}

static void *failure(void) {
    ++stats.allocation_failures;
    errno = ENOMEM;
    return NULL;
}

static int permit(size_t bytes) {
    ++stats.allocation_attempts;
    /* Saturation keeps an unusually long profiling session well-defined. */
    if (bytes > UINT64_MAX - stats.requested_bytes)
        stats.requested_bytes = UINT64_MAX;
    else
        stats.requested_bytes += (uint64_t)bytes;
    if (fail_enabled) {
        if (!remaining_attempts) return 0;
        --remaining_attempts;
    }
    return 1;
}

static void *fresh(size_t bytes, int zero) {
    xp_header *header;
    if (!permit(bytes) || bytes > SIZE_MAX - sizeof(*header) ||
        bytes > SIZE_MAX - stats.live_bytes) return failure();
    header = malloc(sizeof(*header) + bytes);
    if (!header) return failure();
    header->record.bytes = bytes;
    header->record.magic = XP_MAGIC;
    if (zero && bytes) memset(header + 1, 0, bytes);
    ++stats.fresh_allocations;
    ++stats.live_allocations;
    stats.live_bytes += bytes;
    update_peaks();
    return header + 1;
}

void *xp_malloc(size_t bytes) {
    ++stats.malloc_calls;
    return fresh(bytes, 0);
}

void *xp_calloc(size_t count, size_t bytes) {
    ++stats.calloc_calls;
    if (bytes && count > SIZE_MAX / bytes) {
        ++stats.allocation_attempts;
        return failure();
    }
    return fresh(count * bytes, 1);
}

static void release(void *pointer) {
    xp_header *header = checked_header(pointer);
    stats.live_bytes -= header->record.bytes;
    --stats.live_allocations;
    ++stats.released_allocations;
    header->record.magic = 0;
    free(header);
}

void *xp_realloc(void *pointer, size_t bytes) {
    xp_header *old_header, *new_header;
    size_t old_bytes;
    ++stats.realloc_calls;
    if (!pointer) return fresh(bytes, 0);
    if (!bytes) { release(pointer); return NULL; }
    old_header = checked_header(pointer);
    old_bytes = old_header->record.bytes;
    if (!permit(bytes) || bytes > SIZE_MAX - sizeof(*new_header) ||
        bytes > SIZE_MAX - (stats.live_bytes - old_bytes)) return failure();
    new_header = realloc(old_header, sizeof(*new_header) + bytes);
    if (!new_header) return failure();
    new_header->record.bytes = bytes;
    new_header->record.magic = XP_MAGIC;
    stats.live_bytes = stats.live_bytes - old_bytes + bytes;
    if (bytes > old_bytes) ++stats.growth_reallocations;
    else if (bytes < old_bytes) ++stats.shrink_reallocations;
    else ++stats.unchanged_reallocations;
    update_peaks();
    return new_header + 1;
}

void xp_free(void *pointer) {
    ++stats.free_calls;
    if (pointer) release(pointer);
}

void xp_reset_stats(void) {
    size_t live_bytes = stats.live_bytes;
    size_t live_allocations = stats.live_allocations;
    memset(&stats, 0, sizeof stats);
    stats.live_bytes = stats.peak_live_bytes = live_bytes;
    stats.live_allocations = stats.peak_live_allocations = live_allocations;
}

xp_stats xp_get_stats(void) { return stats; }

void xp_fail_after(size_t permitted_attempts) {
    remaining_attempts = permitted_attempts;
    fail_enabled = 1;
}

void xp_fail_disable(void) {
    remaining_attempts = 0;
    fail_enabled = 0;
}
