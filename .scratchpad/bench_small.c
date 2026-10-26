/* Native exploratory benchmark; not the final arithmetic implementation.
 * Build: clang -O3 -std=c11 -Wall -Wextra .scratchpad/bench_small.c -o .scratchpad/small-bench
 * Validate: .scratchpad/small-bench --verify-only
 * Measure: .scratchpad/small-bench > .scratchpad/small-results.csv
 * All candidate arithmetic kernels avoid multiplication. Native multiplication
 * is intentionally used by the native baseline and the correctness oracle.
 */
#define _POSIX_C_SOURCE 200809L
#include <assert.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define NOINLINE __attribute__((noinline))
#define PAIRS 4096
#define TRIALS 7
#define TARGET_NS 5000000ULL

static uint16_t table8[256], quarter8[512], products8[256][256];
static uint32_t table16[65536];
static volatile uint64_t observable;
static uint64_t random_state = UINT64_C(0x584255896d);
typedef uint64_t (*kernel)(uint32_t, uint32_t);
typedef struct { uint32_t a, b; } pair;
typedef struct { const char *name; kernel fn; unsigned max_width; } method;

static uint64_t now_ns(void) {
    struct timespec t;
    if (clock_gettime(CLOCK_MONOTONIC, &t)) abort();
    return (uint64_t)t.tv_sec * UINT64_C(1000000000) + (uint64_t)t.tv_nsec;
}

static uint32_t random32(void) {
    random_state ^= random_state << 13;
    random_state ^= random_state >> 7;
    random_state ^= random_state << 17;
    return (uint32_t)random_state;
}

static NOINLINE void initialize_table8(void) {
    uint32_t square = 0, odd = 1;
    for (unsigned i = 0; i < 256; ++i) {
        table8[i] = (uint16_t)square;
        square += odd;
        odd += 2;
    }
}

static NOINLINE void initialize_table16(void) {
    uint32_t square = 0, odd = 1;
    for (unsigned i = 0; i < 65536; ++i) {
        table16[i] = square;
        square += odd;
        odd += 2;
    }
}

static NOINLINE void initialize_quarter8(void) {
    quarter8[0] = 0;
    for (unsigned i = 1; i < 512; ++i)
        quarter8[i] = quarter8[i - 1] + (i >> 1);
}

static NOINLINE void initialize_products8(void) {
    for (unsigned a = 0; a < 256; ++a) {
        uint32_t product = 0;
        for (unsigned b = 0; b < 256; ++b) {
            products8[a][b] = (uint16_t)product;
            product += a;
        }
    }
}

static void initialize_tables(void) {
    initialize_table8();
    initialize_table16();
    initialize_quarter8();
    initialize_products8();
}

static NOINLINE uint64_t call_floor(uint32_t x, uint32_t y) {
    return (uint64_t)x + y;
}

static NOINLINE uint64_t native_mul(uint32_t x, uint32_t y) {
    return (uint64_t)x * y;
}

static NOINLINE uint64_t shift_add(uint32_t x, uint32_t y) {
    if (x < y) { uint32_t t = x; x = y; y = t; }
    uint64_t shifted = x, result = 0;
    while (y) {
        if (y & 1) result += shifted;
        shifted <<= 1;
        y >>= 1;
    }
    return result;
}

static NOINLINE uint64_t sparse_multiply(uint32_t x, uint32_t y) {
    if (__builtin_popcount(x) < __builtin_popcount(y)) {
        uint32_t t = x; x = y; y = t;
    }
    uint64_t result = 0;
    while (y) {
        unsigned i = (unsigned)__builtin_ctz(y);
        result += (uint64_t)x << i;
        y &= y - 1;
    }
    return result;
}

static uint64_t square_prefix(uint32_t x) {
    if (!x) return 0;
    uint64_t prefix = 0, square = 0;
    for (int i = 31 - __builtin_clz(x); i >= 0; --i) {
        unsigned bit = (x >> i) & 1;
        square <<= 2;
        if (bit) square += (prefix << 2) + 1;
        prefix = (prefix << 1) | bit;
    }
    return square;
}

static uint64_t square_set_bits(uint32_t x) {
    uint64_t result = 0;
    while (x) {
        uint32_t higher = x & (x - 1), bit = x ^ higher;
        unsigned i = (unsigned)__builtin_ctz(bit);
        uint64_t row = ((uint64_t)bit << i) | ((uint64_t)higher << (i + 1));
        result += row;
        x = higher;
    }
    return result;
}

static NOINLINE uint64_t square_recursive(uint32_t x) {
    if (x < 256) return table8[x];
    unsigned r = (32 - (unsigned)__builtin_clz(x)) >> 1;
    uint32_t high = x >> r, low = x & ((UINT32_C(1) << r) - 1);
    uint32_t delta = high >= low ? high - low : low - high;
    uint64_t u = square_recursive(high), v = square_recursive(low);
    uint64_t w = square_recursive(delta);
    return (u << (r << 1)) + ((u + v - w) << r) + v;
}

#define MIDPOINT_WRAPPER(name, square_fn) \
static NOINLINE uint64_t name(uint32_t x, uint32_t y) { \
    uint32_t a = x < y ? x : y, b = x < y ? y : x; \
    uint32_t delta = b - a, d = delta >> 1, h = a + d; \
    return square_fn(h) - square_fn(d) + ((delta & 1) ? a : 0); \
}

MIDPOINT_WRAPPER(midpoint_prefix, square_prefix)
MIDPOINT_WRAPPER(midpoint_set_bits, square_set_bits)
MIDPOINT_WRAPPER(midpoint_recursive, square_recursive)

static NOINLINE uint64_t midpoint_table8(uint32_t x, uint32_t y) {
    uint32_t a = x < y ? x : y, b = x < y ? y : x;
    uint32_t delta = b - a, d = delta >> 1, h = a + d;
    return (uint64_t)table8[h] - table8[d] + ((delta & 1) ? a : 0);
}

static NOINLINE uint64_t midpoint_table16(uint32_t x, uint32_t y) {
    uint32_t a = x < y ? x : y, b = x < y ? y : x;
    uint32_t delta = b - a, d = delta >> 1, h = a + d;
    return (uint64_t)table16[h] - table16[d] + ((delta & 1) ? a : 0);
}

static NOINLINE uint64_t quarter_table8(uint32_t x, uint32_t y) {
    uint32_t d = x > y ? x - y : y - x;
    return (uint64_t)quarter8[x + y] - quarter8[d];
}

static NOINLINE uint64_t full_product_table8(uint32_t x, uint32_t y) {
    return products8[x][y];
}

static NOINLINE uint64_t software_karatsuba(uint32_t x, uint32_t y) {
    if (!x || !y) return 0;
    uint32_t largest = x > y ? x : y;
    if (largest < 256) return midpoint_table8(x, y);
    unsigned r = (32 - (unsigned)__builtin_clz(largest)) >> 1;
    uint32_t mask = (UINT32_C(1) << r) - 1;
    uint32_t xh = x >> r, xl = x & mask, yh = y >> r, yl = y & mask;
    uint32_t dx = xh > xl ? xh - xl : xl - xh;
    uint32_t dy = yh > yl ? yh - yl : yl - yh;
    uint64_t u = software_karatsuba(xh, yh), v = software_karatsuba(xl, yl);
    uint64_t w = software_karatsuba(dx, dy);
    uint64_t cross = ((xh < xl) != (yh < yl)) ? u + v + w : u + v - w;
    return (u << (r << 1)) + (cross << r) + v;
}

/* Structured-input comparison: a*b = a^2 + a*(b-a). */
static NOINLINE uint64_t square_plus_delta(uint32_t x, uint32_t y) {
    uint32_t a = x < y ? x : y, b = x < y ? y : x;
    return square_recursive(a) + sparse_multiply(a, b - a);
}

static NOINLINE uint64_t equal_aware_recursive(uint32_t x, uint32_t y) {
    return x == y ? square_recursive(x) : software_karatsuba(x, y);
}

static NOINLINE uint64_t equal_aware_table16(uint32_t x, uint32_t y) {
    return x == y ? table16[x] : midpoint_table16(x, y);
}

static const method methods[] = {
    {"call_floor", call_floor, 32},
    {"native", native_mul, 32},
    {"shift_add", shift_add, 32},
    {"sparse_multiply", sparse_multiply, 32},
    {"software_karatsuba", software_karatsuba, 32},
    {"square_plus_delta", square_plus_delta, 32},
    {"equal_aware_recursive", equal_aware_recursive, 32},
    {"midpoint_prefix", midpoint_prefix, 32},
    {"midpoint_set_bits", midpoint_set_bits, 32},
    {"midpoint_recursive", midpoint_recursive, 32},
    {"midpoint_table8", midpoint_table8, 8},
    {"midpoint_table16", midpoint_table16, 16},
    {"quarter_table8", quarter_table8, 8},
    {"full_product_table8", full_product_table8, 8},
    {"equal_aware_table16", equal_aware_table16, 16},
};
#define METHODS (sizeof(methods) / sizeof(methods[0]))

static void check_pair(uint32_t a, uint32_t b) {
    uint64_t expected = (uint64_t)a * b;
    for (unsigned k = 1; k < METHODS; ++k) {
        if (methods[k].max_width < 32 &&
            ((a >> methods[k].max_width) || (b >> methods[k].max_width))) continue;
        uint64_t actual = methods[k].fn(a, b);
        if (actual != expected) {
            fprintf(stderr, "FAIL %s %" PRIu32 " %" PRIu32 " got %" PRIu64 " expected %" PRIu64 "\n",
                    methods[k].name, a, b, actual, expected);
            exit(2);
        }
    }
}

static void verify(void) {
    for (uint32_t a = 0; a < 256; ++a)
        for (uint32_t b = 0; b < 256; ++b) check_pair(a, b);
    for (unsigned i = 0; i < 100000; ++i) check_pair(random32(), random32());
    const uint32_t cases[] = {0, 1, 2, 3, 127, 128, 255, 256, 257, 65535, 65536,
                             UINT32_C(0x7fffffff), UINT32_C(0x80000000), UINT32_MAX};
    for (unsigned i = 0; i < sizeof(cases) / sizeof(cases[0]); ++i)
        for (unsigned j = 0; j < sizeof(cases) / sizeof(cases[0]); ++j)
            check_pair(cases[i], cases[j]);
    for (uint32_t z = 0; z < 65536; ++z) {
        uint64_t expected = (uint64_t)z * z;
        assert(square_prefix(z) == expected);
        assert(square_set_bits(z) == expected);
        assert(square_recursive(z) == expected);
    }
    fprintf(stderr, "Verification passed: 65536 ordered eight-bit pairs, 100000 random 32-bit pairs, 196 boundary pairs, 65536 inputs per square.\n");
}

static void make_pairs(pair *data, unsigned bits, unsigned pattern) {
    uint32_t high = UINT32_C(1) << (bits - 1);
    uint32_t mask = bits == 32 ? UINT32_MAX : (UINT32_C(1) << bits) - 1;
    for (unsigned i = 0; i < PAIRS; ++i) {
        uint32_t a = (random32() & mask) | high;
        uint32_t b = (random32() & mask) | high;
        switch (pattern) {
        case 1: {
            uint32_t limit = bits == 8 ? 63 : 255;
            a = high | (random32() & ((high >> 1) - 1));
            b = a + 1 + random32() % limit;
            break;
        }
        case 2: b = a; break;
        case 3:
            a = high | (UINT32_C(1) << (random32() % bits)) | (UINT32_C(1) << (random32() % bits));
            b = high | (UINT32_C(1) << (random32() % bits)) | (UINT32_C(1) << (random32() % bits));
            break;
        case 4:
            a = mask ^ ((UINT32_C(1) << (random32() % (bits - 1))) | (UINT32_C(1) << (random32() % (bits - 1))));
            b = mask ^ ((UINT32_C(1) << (random32() % (bits - 1))) | (UINT32_C(1) << (random32() % (bits - 1))));
            break;
        case 5: b = 1; break;
        case 6: b = (random32() & 255) | 1; break;
        case 7: b = high; break;
        }
        data[i] = (pair){a, b};
        check_pair(a, b);
    }
}

static NOINLINE uint64_t sample(kernel fn, const pair *data, unsigned repeats, uint64_t *checksum) {
    uint64_t sum = 0;
    uint64_t begin = now_ns();
    for (unsigned r = 0; r < repeats; ++r)
        for (unsigned i = 0; i < PAIRS; ++i)
            sum += fn(data[i].a, data[i].b);
    uint64_t elapsed = now_ns() - begin;
    observable ^= sum;
    *checksum = sum;
    return elapsed;
}

static int compare_double(const void *a, const void *b) {
    double x = *(const double *)a, y = *(const double *)b;
    return (x > y) - (x < y);
}

static void measure_table_builds(void) {
    const char *names[] = {"square8", "square16", "quarter8", "product8"};
    const unsigned bytes[] = {512, 262144, 1024, 131072};
    void (*builders[])(void) = {initialize_table8, initialize_table16,
                              initialize_quarter8, initialize_products8};
    const unsigned repeats = 128;
    for (unsigned k = 0; k < 4; ++k) {
        double samples[TRIALS];
        for (unsigned trial = 0; trial < TRIALS; ++trial) {
            uint64_t begin = now_ns();
            for (unsigned r = 0; r < repeats; ++r) builders[k]();
            samples[trial] = (double)(now_ns() - begin) / repeats;
            observable ^= table8[255] + table16[65535] + quarter8[510] + products8[255][255];
        }
        qsort(samples, TRIALS, sizeof(double), compare_double);
        fprintf(stderr, "table_build name=%s bytes=%u repeats=%u trials=%u median_ns=%.3f min_ns=%.3f max_ns=%.3f warm_rebuild=true\n",
                names[k], bytes[k], repeats, TRIALS, samples[TRIALS / 2], samples[0], samples[TRIALS - 1]);
    }
}

int main(int argc, char **argv) {
    uint64_t start = now_ns();
    initialize_tables();
    uint64_t setup = now_ns() - start;
    fprintf(stderr, "compiler=%s; pointer_bits=%zu; pairs=%d; trials=%d; target_ns=%llu; seed=0x584255896d; all_tables_first_build_ns=%" PRIu64 "\n",
            __clang_version__, 8 * sizeof(void *), PAIRS, TRIALS,
            (unsigned long long)TARGET_NS, setup);
    verify();
    if (argc == 2 && !strcmp(argv[1], "--verify-only")) return 0;
    if (argc != 1) { fprintf(stderr, "Usage: %s [--verify-only]\n", argv[0]); return 1; }
    measure_table_builds();
    const unsigned widths[] = {8, 16, 32};
    const char *patterns[] = {"random", "near", "equal", "sparse", "dense", "times_one", "times_byte", "times_power2"};
    pair data[PAIRS];
    puts("bits,pattern,method,pairs,repeats,trials,median_ns,min_ns,max_ns,checksum");
    for (unsigned wi = 0; wi < 3; ++wi) {
        unsigned bits = widths[wi];
        for (unsigned p = 0; p < 8; ++p) {
            make_pairs(data, bits, p);
            unsigned active[METHODS], count = 0, repeats[METHODS] = {0};
            double times[METHODS][TRIALS];
            uint64_t checksums[METHODS] = {0};
            for (unsigned k = 0; k < METHODS; ++k) if (bits <= methods[k].max_width) {
                active[count++] = k;
                unsigned reps = 1;
                uint64_t elapsed;
                do {
                    elapsed = sample(methods[k].fn, data, reps, &checksums[k]);
                    if (elapsed < TARGET_NS / 4) reps <<= 1;
                } while (elapsed < TARGET_NS / 4);
                uint64_t scaled = (reps * TARGET_NS + elapsed - 1) / elapsed;
                repeats[k] = scaled > 0 ? (unsigned)scaled : 1;
            }
            for (unsigned trial = 0; trial < TRIALS; ++trial) {
                for (unsigned i = count - 1; i > 0; --i) {
                    unsigned j = random32() % (i + 1), t = active[i];
                    active[i] = active[j]; active[j] = t;
                }
                for (unsigned i = 0; i < count; ++i) {
                    unsigned k = active[i];
                    uint64_t elapsed = sample(methods[k].fn, data, repeats[k], &checksums[k]);
                    times[k][trial] = (double)elapsed / ((double)repeats[k] * PAIRS);
                }
            }
            for (unsigned k = 0; k < METHODS; ++k) if (repeats[k]) {
                qsort(times[k], TRIALS, sizeof(double), compare_double);
                printf("%u,%s,%s,%u,%u,%u,%.6f,%.6f,%.6f,%" PRIu64 "\n",
                       bits, patterns[p], methods[k].name, PAIRS, repeats[k], TRIALS,
                       times[k][TRIALS / 2], times[k][0], times[k][TRIALS - 1], checksums[k]);
            }
            fflush(stdout);
        }
    }
    fprintf(stderr, "observable_checksum=%" PRIu64 "\n", observable);
    return 0;
}
