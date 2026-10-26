/* Standalone square measurements; exploratory, not the final implementation.
 * Reuses exactly the square kernels, tables, and BN primitives of bench_large.c.
 * Compile with -DSCALAR_LEAF_BITS=32 and the same OpenSSL include/link flags.
 * Run with --verify-only before scheduling an otherwise-idle timing run.
 */
#define main product_benchmark_main
#include "bench_large.c"
#undef main

static NOINLINE void square_copy_control(BIGNUM *out, const BIGNUM *x, BN_CTX *ctx) {
    (void)ctx;
    REQUIRE(BN_copy(out, x));
}

struct square_method { const char *name; square_fn fn; int control; };
static const struct square_method square_methods[] = {
    {"copy_control", square_copy_control, 1},
    {"native_square", square_native, 0},
    {"recursive_square", square_recursive, 0},
    {"set_bit_square", square_set_bits, 0},
    {"prefix_square", square_prefix, 0},
};
#define NSQUARE_METHODS (sizeof(square_methods) / sizeof(square_methods[0]))

static const char *square_patterns[] = {
    "random", "sparse3", "dense", "power2", "near_power2_plus_byte"
};
#define NSQUARE_PATTERNS (sizeof(square_patterns) / sizeof(square_patterns[0]))

static BIGNUM *make_square_input(int bits, unsigned pattern) {
    BIGNUM *x = BN_new(); REQUIRE(x);
    random_bits(x, bits);
    switch (pattern) {
    case 1:
        REQUIRE(BN_set_word(x, 1));
        REQUIRE(BN_set_bit(x, bits - 1));
        REQUIRE(BN_set_bit(x, 1 + (int)(random_u64() % (unsigned)(bits - 2))));
        break;
    case 2:
        REQUIRE(BN_set_word(x, 0)); REQUIRE(BN_set_bit(x, bits));
        REQUIRE(BN_sub_word(x, 1));
        REQUIRE(BN_clear_bit(x, (int)(random_u64() % (unsigned)(bits - 1))));
        break;
    case 3:
        REQUIRE(BN_set_word(x, 0)); REQUIRE(BN_set_bit(x, bits - 1));
        break;
    case 4:
        REQUIRE(BN_set_word(x, 1 + (random_u64() % 255)));
        REQUIRE(BN_set_bit(x, bits - 1));
        break;
    default: break;
    }
    REQUIRE(BN_num_bits(x) == bits);
    return x;
}

static double square_batch(square_fn fn, BIGNUM *const *inputs, unsigned repetitions,
                           BN_CTX *ctx, BIGNUM *out) {
    uint64_t check = 0, begin = now_ns();
    for (unsigned rep = 0; rep < repetitions; ++rep)
        for (unsigned i = 0; i < NSAMPLES; ++i) {
            fn(out, inputs[i], ctx);
            check += (uint64_t)BN_num_bits(out);
        }
    uint64_t end = now_ns();
    sink ^= check;
    return (double)(end - begin);
}

static void verify_square_input(const BIGNUM *x, BN_CTX *ctx, BIGNUM *out,
                                BIGNUM *expected) {
    REQUIRE(BN_sqr(expected, x, ctx));
    for (unsigned a = 0; a < NSQUARE_METHODS; ++a) {
        square_methods[a].fn(out, x, ctx);
        if (square_methods[a].control) REQUIRE(BN_cmp(out, x) == 0);
        else REQUIRE(BN_cmp(out, expected) == 0);
    }
}

static void measure_squares(FILE *file, int verify_only, double target_ms) {
    const int widths[] = {64, 256, 1024, 4096};
    BN_CTX *ctx = BN_CTX_new();
    BIGNUM *out = BN_new(), *expected = BN_new();
    REQUIRE(ctx && out && expected);
    unsigned verified = 0;
    if (!verify_only)
        fprintf(file, "bits,pattern,algorithm,samples,distinct_inputs,mean_set_bits,repetitions,trials,median_ns,min_ns,max_ns\n");
    for (unsigned w = 0; w < sizeof(widths) / sizeof(widths[0]); ++w) {
        int bits = widths[w];
        for (unsigned pattern = 0; pattern < NSQUARE_PATTERNS; ++pattern) {
            BIGNUM *inputs[NSAMPLES];
            unsigned distinct = 0, set_bits = 0;
            for (unsigned i = 0; i < NSAMPLES; ++i) {
                inputs[i] = make_square_input(bits, pattern);
                verify_square_input(inputs[i], ctx, out, expected);
                ++verified;
                set_bits += count_bits(inputs[i]);
                unsigned earlier = 0;
                for (unsigned j = 0; j < i; ++j)
                    if (BN_cmp(inputs[i], inputs[j]) == 0) { earlier = 1; break; }
                distinct += !earlier;
            }
            if (!verify_only) {
                unsigned reps[NSQUARE_METHODS];
                double times[NSQUARE_METHODS][NTRIALS];
                for (unsigned a = 0; a < NSQUARE_METHODS; ++a) {
                    reps[a] = 1;
                    double elapsed;
                    do {
                        elapsed = square_batch(square_methods[a].fn, inputs, reps[a], ctx, out);
                        if (elapsed >= 1000000.0 || reps[a] >= 524288) break;
                        reps[a] <<= 1;
                    } while (1);
                    double desired = (double)reps[a] * target_ms * 1000000.0 / (elapsed > 0 ? elapsed : 1);
                    reps[a] = desired > 1 ? (unsigned)(desired + 1) : 1;
                    if (reps[a] > 1000000) reps[a] = 1000000;
                }
                for (unsigned trial = 0; trial < NTRIALS; ++trial) {
                    unsigned order[NSQUARE_METHODS];
                    for (unsigned a = 0; a < NSQUARE_METHODS; ++a) order[a] = a;
                    for (unsigned a = NSQUARE_METHODS - 1; a > 0; --a) {
                        unsigned j = (unsigned)(random_u64() % (a + 1));
                        unsigned t = order[a]; order[a] = order[j]; order[j] = t;
                    }
                    for (unsigned j = 0; j < NSQUARE_METHODS; ++j) {
                        unsigned a = order[j];
                        double elapsed = square_batch(square_methods[a].fn, inputs, reps[a], ctx, out);
                        times[a][trial] = elapsed / ((double)reps[a] * NSAMPLES);
                    }
                }
                for (unsigned a = 0; a < NSQUARE_METHODS; ++a) {
                    qsort(times[a], NTRIALS, sizeof(double), cmp_double);
                    fprintf(file, "%d,%s,%s,%d,%u,%.3f,%u,%d,%.3f,%.3f,%.3f\n",
                            bits, square_patterns[pattern], square_methods[a].name,
                            NSAMPLES, distinct, (double)set_bits / NSAMPLES,
                            reps[a], NTRIALS, times[a][NTRIALS / 2], times[a][0], times[a][NTRIALS - 1]);
                }
                fflush(file);
            }
            for (unsigned i = 0; i < NSAMPLES; ++i) BN_free(inputs[i]);
        }
    }
    fprintf(stderr, "verified_square_inputs=%u; oracle=BN_sqr; all_candidate_checks=passed\n", verified);
    fprintf(stderr, "observable_checksum=%llu\n", (unsigned long long)sink);
    BN_free(out); BN_free(expected); BN_CTX_free(ctx);
}

int main(int argc, char **argv) {
    int verify_only = 0;
    double target_ms = 5.0;
    const char *output = NULL;
    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--verify-only")) verify_only = 1;
        else if (!strcmp(argv[i], "--target-ms") && i + 1 < argc) target_ms = atof(argv[++i]);
        else if (!strcmp(argv[i], "--output") && i + 1 < argc) output = argv[++i];
        else {
            fprintf(stderr, "Usage: %s [--verify-only] [--target-ms 5] [--output square-results.csv]\n", argv[0]);
            return 2;
        }
    }
    REQUIRE(target_ms >= 1 && target_ms <= 100);
    fprintf(stderr, "%s\ncompiler=%s\nscalar_leaf_bits=%d; table_bytes=%zu; samples=%d; trials=%d; target_ms=%.3f; seed=0x8f1bbcde58425531\n",
            OpenSSL_version(OPENSSL_VERSION), __VERSION__, SCALAR_LEAF_BITS,
            sizeof(squares), NSAMPLES, NTRIALS, target_ms);
    fprintf(stderr, "Warm BIGNUM square throughput, including API and result-width checksum overhead. Power-of-two inputs are identical at each exact width; CSV records distinct counts. BN bitwise implementation scans every bit position. No cold-cache or weak-device cycle claim.\n");
    init_table();
    FILE *file = output ? fopen(output, "w") : stdout; REQUIRE(file);
    measure_squares(file, verify_only, target_ms);
    if (output) REQUIRE(fclose(file) == 0);
    return 0;
}
