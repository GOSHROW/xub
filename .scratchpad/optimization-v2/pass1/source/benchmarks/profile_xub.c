/* Allocation and failure-path experiment, deliberately separate from timing.
 * Only the core library is macro-instrumented. This harness and its wrapper
 * use ordinary libc allocation unless an xp_* function is called explicitly. */
#include "alloc_profile.h"
#include "xub.h"
#include "xub_internal.h"

#ifdef XUB_ALLOC_PROFILE
#error "Compile the profiling harness without XUB_ALLOC_PROFILE"
#endif

#include <inttypes.h>
#include <stdio.h>
#include <string.h>

#ifdef XUB_PROFILE_V1
/* The archived v1 context owns no heap storage. Compile this harness against
 * its own headers and objects to compare allocations with identical fixtures. */
static void profile_context_trim(xub_context *context) { (void)context; }
static void profile_context_free(xub_context *context) {
    memset(context, 0, sizeof *context);
}
#else
#define profile_context_trim xub_context_trim
#define profile_context_free xub_context_free
#endif

typedef enum { PRODUCT, MODULAR, CACHED } operation;
typedef enum { BALANCED_CASE, LONG_CASE, MODULAR_CASE, CACHE_CASE } case_kind;

typedef struct {
    xub_int x, y, out, expected, sum;
    xub_context context;
    xub_midpoint_cache cache;
    operation op;
    size_t x_bits, y_bits;
    int context_live;
} fixture;

static size_t checks;

static void check(int condition, const char *expression, int line) {
    ++checks;
    if (!condition) {
        fprintf(stderr, "Allocation profile check failed at line %d: %s\n",
                line, expression);
        exit(1);
    }
}
#define CHECK(condition) check(!!(condition), #condition, __LINE__)

static void require(xub_status status) {
    if (status != XUB_OK) {
        fprintf(stderr, "Allocation profile operation failed: %s\n",
                xub_status_string(status));
        exit(1);
    }
}

static uint32_t random_word(uint32_t *state) {
    uint32_t value = *state;
    value ^= value << 13;
    value ^= value >> 17;
    value ^= value << 5;
    *state = value;
    return value;
}

static void random_integer(xub_int *out, size_t bits, uint32_t *state) {
    size_t words = (bits + 31) >> 5;
    require(xi_reserve(out, words));
    for (size_t i = 0; i < words; ++i) out->limbs[i] = random_word(state);
    if (bits & 31) out->limbs[words - 1] &= (UINT32_C(1) << (bits & 31)) - 1;
    out->limbs[words - 1] |= UINT32_C(1) << ((bits - 1) & 31);
    out->limbs[0] |= 1;
    out->used = words;
    out->negative = 0;
}

/* Independent product formula, sharing the library's primitive additions.
 * All reference preparation happens outside the reported allocation interval. */
static void reference_product(xub_int *out, const xub_int *x, const xub_int *y) {
    const xub_int *longer = x, *shorter = y;
    xub_int result;
    xub_init(&result);
    if (xub_bit_length(longer) < xub_bit_length(shorter)) {
        longer = y;
        shorter = x;
    }
    for (size_t word = 0; word < shorter->used; ++word) {
        uint32_t active = shorter->limbs[word];
        while (active) {
            size_t bit = (word << 5) + xi_ctz32(active);
            require(xi_add_shifted(&result, longer, bit, SIZE_MAX));
            active &= active - 1;
        }
    }
    result.negative = result.used && (x->negative != y->negative);
    xi_swap(out, &result);
    xub_free(&result);
}

static void fixture_init(fixture *f, case_kind kind, size_t bits) {
    uint32_t state = UINT32_C(0x58554271);
    xub_int offset;
    xub_init(&f->x); xub_init(&f->y); xub_init(&f->out);
    xub_init(&f->expected); xub_init(&f->sum); xub_init(&offset);
    xub_context_init(&f->context); xub_cache_init(&f->cache);
    /* Hold policy constant across archived/current builds. Production tuning
     * must not silently change the allocation before/after experiment. */
    f->context.options.square_mode = XUB_SQUARE_AUTO;
    f->context.options.leaf_bits = 64;
    f->context.options.sparse_limit = 8;
    f->context.options.block_ratio = 4;
    f->context.options.dense_complement = 1;
    f->context_live = 1;
    f->op = PRODUCT;
    if (kind == CACHE_CASE) {
        random_integer(&f->sum, bits, &state);
        require(xi_rshift(&f->x, &f->sum, 1));
        require(xub_set_u64(&offset, 17));
        require(xi_sub(&f->x, &f->x, &offset));
        require(xi_sub(&f->y, &f->sum, &f->x));
        f->op = CACHED;
    } else {
        random_integer(&f->x, bits, &state);
        if (kind == LONG_CASE) require(xub_set_u64(&f->y, 67));
        else random_integer(&f->y, bits, &state);
        if (kind == MODULAR_CASE) f->op = MODULAR;
    }
    reference_product(&f->expected, &f->x, &f->y);
    if (f->op == MODULAR) require(xi_low(&f->expected, &f->expected, 64));
    f->x_bits = xub_bit_length(&f->x);
    f->y_bits = xub_bit_length(&f->y);
    xub_free(&offset);
}

static void fixture_free(fixture *f) {
    if (f->context_live) {
        profile_context_free(&f->context);
        f->context_live = 0;
    }
    xub_cache_free(&f->cache);
    xub_free(&f->x); xub_free(&f->y); xub_free(&f->out);
    xub_free(&f->expected); xub_free(&f->sum);
}

static xub_status invoke(fixture *f) {
    switch (f->op) {
        case PRODUCT:
            return xub_mul(&f->out, &f->x, &f->y, &f->context);
        case MODULAR:
            return xub_mul_mod2(&f->out, &f->x, &f->y, 64, &f->context);
        case CACHED:
            return xub_mul_cached(&f->out, &f->x, &f->y,
                                  &f->cache, &f->context);
    }
    return XUB_EINVAL;
}

static void print_row(const fixture *f, const char *name, const char *phase,
                      xp_stats before, xp_stats after) {
    printf("%s,%s,%zu,%zu,%zu,%zu,%" PRIu64 ",%" PRIu64 ",%" PRIu64
           ",%" PRIu64 ",%" PRIu64 ",%" PRIu64 ",%" PRIu64 ",%" PRIu64
           ",%" PRIu64 ",%" PRIu64 ",%" PRIu64 ",%" PRIu64
           ",%zu,%zu,%zu,%zu,%zu\n",
           name, phase, f->x_bits, f->y_bits,
           before.live_bytes, before.live_allocations,
           after.malloc_calls, after.calloc_calls, after.realloc_calls,
           after.free_calls, after.allocation_attempts, after.allocation_failures,
           after.fresh_allocations, after.growth_reallocations,
           after.shrink_reallocations, after.unchanged_reallocations,
           after.released_allocations, after.requested_bytes,
           after.live_bytes, after.peak_live_bytes,
           after.peak_live_bytes - before.live_bytes,
           after.live_allocations, after.peak_live_allocations);
}

static void product_row(fixture *f, const char *name, const char *phase) {
    xp_stats before, after;
    xp_reset_stats(); before = xp_get_stats();
    require(invoke(f));
    after = xp_get_stats();
    CHECK(xub_compare(&f->out, &f->expected) == 0);
    print_row(f, name, phase, before, after);
}

static void prepare_row(fixture *f, const char *name, const char *phase) {
    xp_stats before, after;
    xp_reset_stats(); before = xp_get_stats();
    require(xub_cache_prepare(&f->cache, &f->sum, &f->context));
    after = xp_get_stats();
    CHECK(f->cache.ready);
    print_row(f, name, phase, before, after);
}

static void trim_row(fixture *f, const char *name, const char *phase) {
    xp_stats before, after;
    unsigned char options[sizeof f->context.options];
    unsigned char stats_before[sizeof f->context.stats];
    unsigned char table[sizeof f->context.squares];
    memcpy(options, &f->context.options, sizeof options);
    memcpy(stats_before, &f->context.stats, sizeof stats_before);
    memcpy(table, f->context.squares, sizeof table);
    xp_reset_stats(); before = xp_get_stats();
    profile_context_trim(&f->context);
    after = xp_get_stats();
    CHECK(memcmp(options, &f->context.options, sizeof options) == 0);
    CHECK(memcmp(stats_before, &f->context.stats, sizeof stats_before) == 0);
    CHECK(memcmp(table, f->context.squares, sizeof table) == 0);
    print_row(f, name, phase, before, after);
}

static void profile_case(const char *name, case_kind kind, size_t bits) {
    fixture f;
    xp_stats before, after;
    CHECK(xp_get_stats().live_allocations == 0);
    fixture_init(&f, kind, bits);
    xp_reset_stats(); before = xp_get_stats();
    print_row(&f, name, "fixture_baseline", before, before);
    if (kind == CACHE_CASE) {
        prepare_row(&f, name, "cache_prepare_cold");
        prepare_row(&f, name, "cache_prepare_repeat");
        trim_row(&f, name, "prepare_context_trim");
    }
    product_row(&f, name, "cold_call");
    product_row(&f, name, "first_repeat");
    for (unsigned i = 0; i < 3; ++i) require(invoke(&f));
    product_row(&f, name, "steady_repeat_after_five_calls");
    trim_row(&f, name, "context_trim");
    CHECK(xub_compare(&f.out, &f.expected) == 0);
    xp_reset_stats(); before = xp_get_stats();
    profile_context_free(&f.context); f.context_live = 0;
    after = xp_get_stats();
    CHECK(xub_compare(&f.out, &f.expected) == 0);
    print_row(&f, name, "context_free_after_trim", before, after);
    xp_reset_stats(); before = xp_get_stats();
    fixture_free(&f);
    after = xp_get_stats();
    print_row(&f, name, "fixture_cleanup", before, after);
    CHECK(after.live_bytes == 0 && after.live_allocations == 0);
}

static void wrapper_checks(void) {
    unsigned char *pointer, *grown;
    xp_stats saved;
    const size_t initial = sizeof(max_align_t) + 17;
    pointer = xp_malloc(initial);
    CHECK(pointer != NULL);
    CHECK((uintptr_t)pointer % _Alignof(max_align_t) == 0);
    memset(pointer, 0xa5, initial);
    xp_fail_after(0);
    CHECK(xp_realloc(pointer, initial + 64) == NULL);
    for (size_t i = 0; i < initial; ++i) CHECK(pointer[i] == 0xa5);
    xp_fail_disable();
    grown = xp_realloc(pointer, initial + 64);
    CHECK(grown != NULL); pointer = grown;
    for (size_t i = 0; i < initial; ++i) CHECK(pointer[i] == 0xa5);
    saved = xp_get_stats(); xp_reset_stats();
    CHECK(xp_get_stats().live_bytes == saved.live_bytes);
    CHECK(xp_get_stats().live_allocations == saved.live_allocations);
    grown = xp_realloc(pointer, initial);
    CHECK(grown != NULL); pointer = grown;
    CHECK(xp_get_stats().shrink_reallocations == 1);
    xp_free(pointer);
    pointer = xp_calloc(3, 17);
    CHECK(pointer != NULL);
    for (size_t i = 0; i < 51; ++i) CHECK(pointer[i] == 0);
    xp_free(pointer);
    CHECK(xp_calloc(SIZE_MAX, 2) == NULL);
    CHECK(xp_malloc(SIZE_MAX) == NULL);
    CHECK(xp_get_stats().live_bytes == 0);
    CHECK(xp_get_stats().live_allocations == 0);
}

static void failure_fixture(fixture *f, int warmed) {
    fixture_init(f, BALANCED_CASE, 128);
    if (warmed) {
        xub_int a, b;
        xub_init(&a); xub_init(&b);
        require(xub_set_u64(&a, UINT64_C(0xa731c05d2a7e19b1)));
        require(xub_set_u64(&b, UINT64_C(0xd10325b79d3f4817)));
        require(xub_mul(&f->out, &a, &b, &f->context));
        xub_free(&a); xub_free(&b);
    }
    require(xub_set_i64(&f->out, -12345));
}

static void failure_sweep(int warmed) {
    fixture f;
    uint64_t attempts;
    xp_stats after;
    failure_fixture(&f, warmed);
    xp_reset_stats();
    require(invoke(&f));
    CHECK(xub_compare(&f.out, &f.expected) == 0);
    attempts = xp_get_stats().allocation_attempts;
    fixture_free(&f);
    CHECK(xp_get_stats().live_allocations == 0);
    CHECK(attempts <= SIZE_MAX);
    for (size_t allowed = 0; allowed < (size_t)attempts; ++allowed) {
        int64_t unchanged = 0;
        failure_fixture(&f, warmed);
        xp_reset_stats();
        xp_fail_after(allowed);
        xub_status status = invoke(&f);
        after = xp_get_stats();
        xp_fail_disable();
        CHECK(status == XUB_ENOMEM);
        CHECK(after.allocation_failures > 0);
        CHECK(xub_get_i64(&f.out, &unchanged) == XUB_OK && unchanged == -12345);
        /* A failed operation must also leave its retained workspace reusable. */
        require(invoke(&f));
        CHECK(xub_compare(&f.out, &f.expected) == 0);
        fixture_free(&f);
        CHECK(xp_get_stats().live_allocations == 0);
        CHECK(xp_get_stats().live_bytes == 0);
    }
    fprintf(stderr, "Failure sweep %s: %" PRIu64 " allocation positions passed\n",
            warmed ? "128-bit after 64-bit warmup" : "128-bit cold", attempts);
}

int main(void) {
    wrapper_checks();
    puts("# Intrusive allocation profile; no timing or RSS measurements.");
#ifdef XUB_PROFILE_V1
    puts("# Build: archived v1; context trim/free compatibility has no owned workspace to release.");
#else
    puts("# Build: current library with context trim/free lifecycle.");
#endif
    puts("# Only core library allocation calls are intercepted; inputs and independent reference preparation are outside each interval.");
    puts("# Bytes are requested live payload, excluding profiler headers, allocator overhead and allocator-internal transient copies.");
    puts("# Baseline includes retained inputs, expected results, output and cache; peaks include that baseline. free_calls includes free(NULL).");
    puts("# One deterministic fixed-width odd pair per case; steady row follows cold, first repeat and three additional calls.");
    puts("# Policy pinned in both builds: AUTO, leaf_bits=64, sparse_limit=8, block_ratio=4, dense_complement=1.");
    puts("case,phase,x_bits,y_bits,baseline_live_bytes,baseline_live_blocks,"
         "malloc_calls,calloc_calls,realloc_calls,free_calls,allocation_attempts,"
         "allocation_failures,fresh_allocations,growth_reallocations,"
         "shrink_reallocations,unchanged_reallocations,released_allocations,"
         "requested_bytes,live_bytes,peak_live_bytes,peak_increment_bytes,"
         "live_blocks,peak_live_blocks");
    profile_case("balanced_4096", BALANCED_CASE, 4096);
    profile_case("balanced_8", BALANCED_CASE, 8);
    profile_case("long_4096_by_67", LONG_CASE, 4096);
    profile_case("fixed_sum4096_nearby", CACHE_CASE, 4096);
    profile_case("low64_of_4096", MODULAR_CASE, 4096);
    failure_sweep(0);
    failure_sweep(1);
    fprintf(stderr, "Allocation profiler: %zu checks passed; final live payload=0, blocks=0\n", checks);
    return 0;
}
