/* Portable, implementation-level CPU-time comparison; no target-cycle claim.
 * Inputs and independent reference results are prepared outside timed regions.
 */
#include "xub.h"
#include "xub_internal.h"

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define PAIRS 8u
#define SAMPLES 5u
#define MIN_SECONDS 0.020

typedef enum { MULTIPLY, SQUARE, SHIFT_ADD, CACHED, MODULAR, FULL_LOW,
               DIRECT_LOW, PREPARE } operation;

typedef struct {
    xub_int x[PAIRS], y[PAIRS], expected[PAIRS], out, sum;
    xub_context context;
    xub_midpoint_cache cache;
    size_t count, width;
    operation op;
} fixture;

static volatile uint32_t consumed;
static uint32_t random_state = UINT32_C(0x58554217);

static void require(xub_status status) {
    if (status != XUB_OK) {
        fprintf(stderr, "Benchmark failed: %s\n", xub_status_string(status));
        exit(1);
    }
}

static uint32_t random_word(void) {
    uint32_t value = random_state;
    value ^= value << 13;
    value ^= value >> 17;
    value ^= value << 5;
    return random_state = value;
}

static void random_integer(xub_int *out, size_t bits) {
    size_t words = (bits + 31) >> 5;
    require(xi_reserve(out, words));
    for (size_t i = 0; i < words; ++i) out->limbs[i] = random_word();
    out->used = words; out->negative = 0;
    if (bits & 31) out->limbs[words - 1] &= (UINT32_C(1) << (bits & 31)) - 1;
    out->limbs[words - 1] |= UINT32_C(1) << ((bits - 1) & 31);
    out->limbs[0] |= 1;
}

/* Independent ordinary multiplication: one shifted magnitude addition for
 * every set bit of the shorter operand. No operand multiplication instruction
 * or subtraction-of-squares identity is used here. Match the public API's
 * temporary-result allocation and commit behavior. */
static xub_status reference_product(xub_int *out, const xub_int *x, const xub_int *y) {
    const xub_int *a = x, *b = y;
    xub_int result;
    xub_status status = XUB_OK;
    if (xub_bit_length(a) < xub_bit_length(b)) { a = y; b = x; }
    xub_init(&result);
    for (size_t word = 0; word < b->used; ++word) {
        uint32_t active = b->limbs[word];
        while (active) {
            size_t bit = (word << 5) + xi_ctz32(active);
            status = xi_add_shifted(&result, a, bit, SIZE_MAX);
            if (status != XUB_OK) goto done;
            active &= active - 1;
        }
    }
    result.negative = result.used && (x->negative != y->negative);
    xi_swap(out, &result);
done:
    xub_free(&result);
    return status;
}

static xub_status reference_low_product(xub_int *out, const xub_int *x,
                                        const xub_int *y, size_t bits) {
    xub_int low_x, low_y, result;
    const xub_int *a = &low_x, *b = &low_y;
    xub_status status;
    xub_init(&low_x); xub_init(&low_y); xub_init(&result);
    status = xi_low(&low_x, x, bits);
    if (status == XUB_OK) status = xi_low(&low_y, y, bits);
    if (status != XUB_OK) goto done;
    if (xub_bit_length(a) < xub_bit_length(b)) { a = &low_y; b = &low_x; }
    for (size_t word = 0; word < b->used; ++word) {
        uint32_t active = b->limbs[word];
        while (active) {
            size_t bit = (word << 5) + xi_ctz32(active);
            /* Discard out-of-demand columns during every row addition. */
            status = xi_add_shifted(&result, a, bit, bits);
            if (status != XUB_OK) goto done;
            active &= active - 1;
        }
    }
    xi_swap(out, &result);
done:
    xub_free(&low_x); xub_free(&low_y); xub_free(&result);
    return status;
}

static void initialize(fixture *f) {
    for (size_t i = 0; i < PAIRS; ++i) {
        xub_init(&f->x[i]); xub_init(&f->y[i]); xub_init(&f->expected[i]);
    }
    xub_init(&f->out); xub_init(&f->sum);
    xub_context_init(&f->context); xub_cache_init(&f->cache);
    f->count = 1; f->width = 64; f->op = MULTIPLY;
}

static void release(fixture *f) {
    for (size_t i = 0; i < PAIRS; ++i) {
        xub_free(&f->x[i]); xub_free(&f->y[i]); xub_free(&f->expected[i]);
    }
    xub_free(&f->out); xub_free(&f->sum); xub_cache_free(&f->cache);
}

static xub_status step(fixture *f, size_t index) {
    size_t pair = f->count == 1 ? 0 : index & (PAIRS - 1);
    xub_status status;
    switch (f->op) {
        case MULTIPLY:
            status = xub_mul(&f->out, &f->x[pair], &f->y[pair], &f->context); break;
        case SQUARE:
            status = xub_square(&f->out, &f->x[pair], &f->context); break;
        case SHIFT_ADD:
            status = reference_product(&f->out, &f->x[pair], &f->y[pair]); break;
        case CACHED:
            status = xub_mul_cached(&f->out, &f->x[pair], &f->y[pair], &f->cache, &f->context); break;
        case MODULAR:
            status = xub_mul_mod2(&f->out, &f->x[pair], &f->y[pair], f->width, &f->context); break;
        case FULL_LOW:
            status = xub_mul(&f->out, &f->x[pair], &f->y[pair], &f->context);
            if (status == XUB_OK) status = xi_low(&f->out, &f->out, f->width);
            break;
        case DIRECT_LOW:
            status = reference_low_product(&f->out, &f->x[pair], &f->y[pair], f->width);
            break;
        case PREPARE:
            status = xub_cache_prepare(&f->cache, &f->sum, &f->context);
            if (status == XUB_OK && f->cache.midpoint_square.used)
                consumed ^= f->cache.midpoint_square.limbs[0];
            return status;
        default: return XUB_EINVAL;
    }
    if (status == XUB_OK && f->out.used) consumed ^= f->out.limbs[0];
    return status;
}

static double trial(fixture *f, size_t repetitions) {
    clock_t start = clock(), finish;
    if (start == (clock_t)-1) { fputs("clock() unavailable\n", stderr); exit(1); }
    for (size_t i = 0; i < repetitions; ++i) require(step(f, i));
    finish = clock();
    if (finish == (clock_t)-1 || finish < start) {
        fputs("clock() failed or wrapped\n", stderr); exit(1);
    }
    return (double)(finish - start) / (double)CLOCKS_PER_SEC;
}

static void validate(fixture *f) {
    if (f->op == PREPARE) {
        xub_int half, expected;
        xub_init(&half); xub_init(&expected);
        require(xi_rshift(&half, &f->sum, 1));
        require(reference_product(&expected, &half, &half));
        require(step(f, 0));
        if (xub_compare(&expected, &f->cache.midpoint_square)) {
            fputs("Cache preparation disagrees with shift/add reference\n", stderr); exit(1);
        }
        xub_free(&half); xub_free(&expected);
        return;
    }
    for (size_t i = 0; i < f->count; ++i) {
        require(reference_product(&f->expected[i], &f->x[i], &f->y[i]));
        if (f->op == MODULAR || f->op == FULL_LOW || f->op == DIRECT_LOW)
            require(xi_low(&f->expected[i], &f->expected[i], f->width));
        require(step(f, i));
        if (xub_compare(&f->out, &f->expected[i])) {
            fputs("Benchmark output disagrees with shift/add reference\n", stderr); exit(1);
        }
    }
}

static void measure(fixture *f, const char *name, const char *algorithm) {
    size_t repetitions = f->count;
    double values[SAMPLES], minimum_seconds = 1e9;
    xub_stats probe;
    validate(f);
    while (trial(f, repetitions) < MIN_SECONDS) {
        if (repetitions > SIZE_MAX / 2) { fputs("Calibration overflow\n", stderr); exit(1); }
        repetitions <<= 1;
    }
    for (size_t sample = 0; sample < SAMPLES; ++sample) {
        double elapsed;
        do {
            elapsed = trial(f, repetitions);
            if (elapsed < MIN_SECONDS) {
                if (repetitions > SIZE_MAX / 2) {
                    fputs("Calibration overflow\n", stderr); exit(1);
                }
                repetitions <<= 1;
            }
        } while (elapsed < MIN_SECONDS);
        if (elapsed < minimum_seconds) minimum_seconds = elapsed;
        values[sample] = elapsed / (double)repetitions;
    }
    for (size_t i = 1; i < SAMPLES; ++i) {
        double value = values[i];
        size_t j = i;
        while (j && values[j - 1] > value) { values[j] = values[j - 1]; --j; }
        values[j] = value;
    }
    xub_stats_reset(&f->context); require(step(f, 0)); probe = f->context.stats;
    printf("%s,%s,%zu,%zu,%.3f,%.3f,%.3f,%zu,%.3f,%" PRIu64 ",%" PRIu64
           ",%" PRIu64 ",%" PRIu64 ",%" PRIu64 ",%" PRIu64 ",%" PRIu64 "\n",
           name, algorithm, xub_bit_length(&f->x[0]), xub_bit_length(&f->y[0]),
           values[SAMPLES / 2] * 1e9, values[0] * 1e9, values[SAMPLES - 1] * 1e9,
           repetitions, minimum_seconds * 1000.0,
           probe.midpoint_calls, probe.square_calls, probe.recursive_squares,
           probe.sparse_squares, probe.complement_squares,
           probe.blocked_products, probe.cached_products);
    fflush(stdout);
}

static void square_comparison(fixture *f, const char *name) {
    require(xub_copy(&f->y[0], &f->x[0]));
    f->op = SQUARE;
    f->context.options.square_mode = XUB_SQUARE_AUTO; measure(f, name, "auto_square");
    f->context.options.square_mode = XUB_SQUARE_RECURSIVE; measure(f, name, "recursive_square");
    f->context.options.square_mode = XUB_SQUARE_SPARSE; measure(f, name, "sparse_square");
    f->op = SHIFT_ADD; measure(f, name, "shift_add_reference");
    f->context.options.square_mode = XUB_SQUARE_AUTO;
}

int main(void) {
    fixture f;
    static const size_t lengths[] = {8, 32, 256, 1024, 4096};
    initialize(&f);
    puts("# C clock() process CPU time; five samples, every measured trial >=20ms; deterministic xorshift seed 0x58554217");
    puts("# Parsing/reference checks excluded; public API allocations, dispatch, counters and result consumption included");
    puts("# Same-process implementation comparison; no hardware-cycle or multiply-free-target speed claim");
    puts("# Eight deterministic pairs per balanced/long/modular case; eight nearby pairs share one sum; each sparse/dense square is one structured value");
    puts("# Random magnitudes have their top and low bits forced: fixed-width odd draws; modular direct baseline truncates every shifted-add row");
#ifdef __VERSION__
    printf("# compiler=%s; CLOCKS_PER_SEC=%ld\n", __VERSION__, (long)CLOCKS_PER_SEC);
#else
    printf("# compiler=unspecified; CLOCKS_PER_SEC=%ld\n", (long)CLOCKS_PER_SEC);
#endif
    puts("case,algorithm,x_bits,y_bits,median_ns_per_operation,min_ns_per_operation,max_ns_per_operation,last_repetitions,minimum_sample_ms,midpoint_calls,square_calls,recursive_squares,sparse_squares,complement_squares,blocked_products,cached_products");
    f.count = PAIRS;
    for (size_t i = 0; i < sizeof lengths / sizeof *lengths; ++i) {
        char name[40];
        (void)snprintf(name, sizeof name, "balanced_%zu", lengths[i]);
        for (size_t pair = 0; pair < PAIRS; ++pair) {
            random_integer(&f.x[pair], lengths[i]); random_integer(&f.y[pair], lengths[i]);
        }
        f.op = MULTIPLY;
        f.context.options.square_mode = XUB_SQUARE_AUTO; measure(&f, name, "auto_multiply");
        f.context.options.square_mode = XUB_SQUARE_RECURSIVE; measure(&f, name, "recursive_multiply");
        f.op = SHIFT_ADD; measure(&f, name, "shift_add_reference");
    }
    f.context.options.square_mode = XUB_SQUARE_AUTO;
    for (size_t pair = 0; pair < PAIRS; ++pair) {
        random_integer(&f.x[pair], 4096); require(xub_set_u64(&f.y[pair], 67));
    }
    f.op = MULTIPLY; measure(&f, "long_4096_by_67", "auto_blocked");
    f.context.options.block_ratio = 0; measure(&f, "long_4096_by_67", "unblocked_midpoint");
    f.context.options.block_ratio = 4;
    f.op = SHIFT_ADD; measure(&f, "long_4096_by_67", "shift_add_reference");
    f.count = 1;
    require(xub_set_u64(&f.x[0], 1));
    require(xi_set_bit(&f.x[0], 2053)); require(xi_set_bit(&f.x[0], 4095));
    square_comparison(&f, "sparse3_4096");
    require(xub_set_u64(&f.x[0], 0)); require(xi_set_bit(&f.x[0], 4096));
    require(xub_set_u64(&f.y[0], 1)); require(xi_sub(&f.x[0], &f.x[0], &f.y[0]));
    square_comparison(&f, "dense_4096");

    random_integer(&f.sum, 4096);
    f.count = PAIRS;
    for (size_t i = 0; i < PAIRS; ++i) {
        xub_int offset; xub_init(&offset);
        require(xi_rshift(&f.x[i], &f.sum, 1));
        require(xub_set_u64(&offset, 17 + (i << 1)));
        require(xi_sub(&f.x[i], &f.x[i], &offset));
        require(xi_sub(&f.y[i], &f.sum, &f.x[i]));
        xub_free(&offset);
    }
    require(xub_cache_prepare(&f.cache, &f.sum, &f.context));
    f.op = MULTIPLY; measure(&f, "fixed_sum4096_nearby", "ordinary_multiply");
    f.op = CACHED; measure(&f, "fixed_sum4096_nearby", "cached_multiply");
    f.op = PREPARE; measure(&f, "fixed_sum4096_nearby", "cache_prepare");

    f.count = PAIRS;
    for (size_t pair = 0; pair < PAIRS; ++pair) {
        random_integer(&f.x[pair], 4096); random_integer(&f.y[pair], 4096);
    }
    f.op = MODULAR; measure(&f, "low64_of_4096_operands", "truncated_midpoint");
    f.op = DIRECT_LOW; measure(&f, "low64_of_4096_operands", "reduce_then_truncated_shift_add");
    f.op = FULL_LOW; measure(&f, "low64_of_4096_operands", "full_midpoint_then_mask");
    release(&f);
    return 0;
}
