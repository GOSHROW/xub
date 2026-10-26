#ifndef XUB_ALLOC_PROFILE_H
#define XUB_ALLOC_PROFILE_H

/* Intrusive, single-threaded allocation accounting for a separate test build.
 * Include the real declarations before replacing library allocation calls.
 * Compile only the library with XUB_ALLOC_PROFILE; never the wrapper itself. */
#include <stdlib.h>
#include <stddef.h>
#include <stdint.h>

typedef struct {
    uint64_t malloc_calls, calloc_calls, realloc_calls, free_calls;
    uint64_t allocation_attempts, allocation_failures;
    uint64_t fresh_allocations, growth_reallocations;
    uint64_t shrink_reallocations, unchanged_reallocations;
    uint64_t released_allocations, requested_bytes;
    size_t live_allocations, peak_live_allocations;
    size_t live_bytes, peak_live_bytes;
} xp_stats;

void *xp_malloc(size_t bytes);
void *xp_calloc(size_t count, size_t bytes);
void *xp_realloc(void *pointer, size_t bytes);
void xp_free(void *pointer);

/* Reset interval counters, preserving currently live allocations and bytes.
 * The interval peaks start at those retained live values. */
void xp_reset_stats(void);
xp_stats xp_get_stats(void);

/* Permit this many allocation attempts, then fail all later attempts until
 * disabled. realloc(pointer, 0) frees without consuming an attempt.
 * Existing blocks remain valid when reallocation fails. */
void xp_fail_after(size_t permitted_attempts);
void xp_fail_disable(void);

#ifdef XUB_ALLOC_PROFILE
#define malloc(bytes) xp_malloc(bytes)
#define calloc(count, bytes) xp_calloc((count), (bytes))
#define realloc(pointer, bytes) xp_realloc((pointer), (bytes))
#define free(pointer) xp_free(pointer)
#endif

#endif
