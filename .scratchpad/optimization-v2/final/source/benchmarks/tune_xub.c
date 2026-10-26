/* Reproducible host-only tuning experiment. Selection sees training data only.
 * Held-out workloads use disjoint seeds and different large operand widths.
 * No source defaults are changed by this program.
 */
#include "xub.h"
#include "xub_internal.h"

#include <inttypes.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define PAIRS 4u
#define GROUPS 7u
#define CELLS 30u
#define CANDIDATES 64u
#define IMPROVEMENT 0.97

typedef enum { BALANCED, EQUAL, NEAR, SKEW, SPARSE, DENSE, SMALL_SQUARE } family;
static const char *family_names[GROUPS] = {
    "balanced", "equal", "near", "skew", "sparse_square", "dense_square", "small_square"
};
static const uint32_t corpus_seeds[2][2] = {
    {UINT32_C(0x7193a21d), UINT32_C(0x43b95e67)},
    {UINT32_C(0xc86e91af), UINT32_C(0x5a27d3b9)}
};

typedef struct {
    family group;
    size_t bits;
    uint32_t seed;
    xub_int x[PAIRS], y[PAIRS], expected[PAIRS];
} workload;

typedef struct {
    double median, minimum, maximum;
    size_t repetitions;
} measurement;

typedef struct {
    xub_options options;
    measurement timings[CELLS];
    double score;
} candidate;

static volatile uint32_t consumed;
static candidate candidates[CANDIDATES];
static size_t candidate_count;
static measurement baseline[CELLS];

static void require(xub_status status) {
    if (status != XUB_OK) {
        fprintf(stderr, "Tuner failed: %s\n", xub_status_string(status)); exit(1);
    }
}

static uint32_t random_word(uint32_t *state) {
    uint32_t x = *state;
    x ^= x << 13; x ^= x >> 17; x ^= x << 5;
    return *state = x;
}

static void random_integer(xub_int *x, size_t bits, unsigned low, uint32_t *state) {
    size_t words = (bits + 31) >> 5;
    require(xi_reserve(x, words));
    for (size_t i = 0; i < words; ++i) x->limbs[i] = random_word(state);
    x->used = words; x->negative = 0;
    if (bits & 31) x->limbs[words - 1] &= (UINT32_C(1) << (bits & 31)) - 1;
    x->limbs[words - 1] |= UINT32_C(1) << ((bits - 1) & 31);
    x->limbs[0] = (x->limbs[0] & ~UINT32_C(1)) | low;
}

static void sparse_integer(xub_int *x, size_t bits, size_t weight, uint32_t *state) {
    require(xub_set_u64(x, 1));
    require(xi_set_bit(x, bits - 1));
    while (xi_popcount_limit(x, SIZE_MAX) < weight)
        require(xi_set_bit(x, random_word(state) % bits));
}

static void reference_product(xub_int *out, const xub_int *x, const xub_int *y) {
    const xub_int *a = x, *b = y;
    if (xub_bit_length(a) < xub_bit_length(b)) { a = y; b = x; }
    require(xub_set_u64(out, 0));
    for (size_t w = 0; w < b->used; ++w) {
        uint32_t active = b->limbs[w];
        while (active) {
            require(xi_add_shifted(out, a, (w << 5) + xi_ctz32(active), SIZE_MAX));
            active &= active - 1;
        }
    }
}

static void make_workload(workload *w, family group, size_t bits, uint32_t seed) {
    uint32_t state = seed ^ ((uint32_t)group << 20) ^ (uint32_t)bits;
    xub_int temporary;
    xub_init(&temporary);
    w->group = group; w->bits = bits; w->seed = seed;
    for (size_t i = 0; i < PAIRS; ++i) {
        xub_init(&w->x[i]); xub_init(&w->y[i]); xub_init(&w->expected[i]);
        random_integer(&w->x[i], bits, (unsigned)(i & 1), &state);
        switch (group) {
            case BALANCED:
                random_integer(&w->y[i], bits, (unsigned)((i >> 1) & 1), &state);
                break;
            case EQUAL: case SMALL_SQUARE:
                require(xub_copy(&w->y[i], &w->x[i])); break;
            case NEAR:
                require(xi_add_u32(&w->y[i], &w->x[i], 37 + (random_word(&state) & 1023)));
                break;
            case SKEW:
                if (!i) require(xub_set_u64(&w->y[i], 67));
                else random_integer(&w->y[i], i == 1 ? 8 : bits / (i == 2 ? 8 : 3),
                                    1, &state);
                break;
            case SPARSE: {
                static const size_t weights[PAIRS] = {3, 6, 12, 24};
                sparse_integer(&w->x[i], bits, weights[i], &state);
                require(xub_copy(&w->y[i], &w->x[i])); break;
            }
            case DENSE:
                if (!i) require(xub_set_u64(&temporary, 1));
                else if (i == 2) sparse_integer(&temporary, bits - 3, 3, &state);
                else random_integer(&temporary, bits / (i == 1 ? 4 : 2), 1, &state);
                require(xub_set_u64(&w->x[i], 0));
                require(xi_set_bit(&w->x[i], bits));
                require(xi_sub(&w->x[i], &w->x[i], &temporary));
                require(xub_copy(&w->y[i], &w->x[i])); break;
        }
        reference_product(&w->expected[i], &w->x[i], &w->y[i]);
    }
    xub_free(&temporary);
}

static void make_corpus(workload *corpus, int held_out) {
    static const size_t sizes[2][2] = {{256, 2048}, {512, 4096}};
    static const size_t small[] = {8, 32, 64};
    size_t n = 0;
    for (size_t seed = 0; seed < 2; ++seed) {
        for (unsigned group = 0; group < SMALL_SQUARE; ++group)
            for (size_t size = 0; size < 2; ++size)
                make_workload(&corpus[n++], (family)group, sizes[held_out][size], corpus_seeds[held_out][seed]);
        for (size_t size = 0; size < sizeof small / sizeof *small; ++size)
            make_workload(&corpus[n++], SMALL_SQUARE, small[size], corpus_seeds[held_out][seed]);
    }
    if (n != CELLS) { fputs("Internal corpus size mismatch\n", stderr); exit(1); }
}

static void free_corpus(workload *corpus) {
    for (size_t cell = 0; cell < CELLS; ++cell)
        for (size_t i = 0; i < PAIRS; ++i) {
            xub_free(&corpus[cell].x[i]); xub_free(&corpus[cell].y[i]);
            xub_free(&corpus[cell].expected[i]);
        }
}

static void operate(xub_int *out, const workload *w, size_t pair, xub_context *context) {
    if (w->group >= SPARSE)
        require(xub_square(out, &w->x[pair], context));
    else require(xub_mul(out, &w->x[pair], &w->y[pair], context));
    if (out->used) consumed ^= out->limbs[0];
}

static double trial(const workload *w, size_t count, xub_int *out, xub_context *context) {
    clock_t start = clock(), finish;
    if (start == (clock_t)-1) { fputs("clock() unavailable\n", stderr); exit(1); }
    for (size_t i = 0; i < count; ++i) operate(out, w, i & (PAIRS - 1), context);
    finish = clock();
    if (finish == (clock_t)-1 || finish < start) {
        fputs("clock() failed or wrapped\n", stderr); exit(1);
    }
    return (double)(finish - start) / (double)CLOCKS_PER_SEC;
}

static void double_repetitions(size_t *count) {
    if (*count > SIZE_MAX / 2) { fputs("Calibration overflow\n", stderr); exit(1); }
    *count <<= 1;
}

static measurement measure(const workload *w, xub_options options, unsigned samples,
                           double minimum_seconds, int check_only) {
    xub_int out;
    xub_context context;
    measurement answer = {0, 0, 0, PAIRS};
    double values[5];
    xub_init(&out); xub_context_init(&context); context.options = options;
    /* Validation doubles as workspace warmup; reference computation is untimed. */
    for (size_t i = 0; i < PAIRS; ++i) {
        operate(&out, w, i, &context);
        if (xub_compare(&out, &w->expected[i])) {
            fprintf(stderr, "Incorrect %s output, seed=%" PRIu32 ", bits=%zu\n",
                    family_names[w->group], w->seed, w->bits); exit(1);
        }
    }
    if (check_only) goto done;
    while (trial(w, answer.repetitions, &out, &context) < minimum_seconds)
        double_repetitions(&answer.repetitions);
    for (unsigned sample = 0; sample < samples; ++sample) {
        double elapsed;
        do {
            elapsed = trial(w, answer.repetitions, &out, &context);
            if (elapsed < minimum_seconds) double_repetitions(&answer.repetitions);
        } while (elapsed < minimum_seconds);
        values[sample] = elapsed / (double)answer.repetitions;
    }
    for (unsigned i = 1; i < samples; ++i) {
        double value = values[i];
        unsigned j = i;
        while (j && values[j - 1] > value) { values[j] = values[j - 1]; --j; }
        values[j] = value;
    }
    answer.minimum = values[0]; answer.maximum = values[samples - 1];
    answer.median = values[samples / 2];
done:
    xub_free(&out); xub_context_free(&context);
    return answer;
}

static void row(const char *split, size_t id, const workload *w, xub_options options,
                measurement value, double relative) {
    printf("%s,%zu,%s,%zu,%" PRIu32 ",%zu,%zu,%d,%zu,%.3f,%.3f,%.3f,%zu,%.6f\n",
           split, id, family_names[w->group], w->bits, w->seed,
           options.leaf_bits, options.sparse_limit, options.dense_complement,
           options.block_ratio, value.median * 1e9, value.minimum * 1e9,
           value.maximum * 1e9, value.repetitions, relative);
}

static double score(const workload *corpus, const measurement *values,
                    const measurement *reference, double *group_scores) {
    double sums[GROUPS] = {0}, total = 0;
    size_t counts[GROUPS] = {0};
    for (size_t i = 0; i < CELLS; ++i) {
        sums[corpus[i].group] += log(values[i].median / reference[i].median);
        ++counts[corpus[i].group];
    }
    for (size_t group = 0; group < GROUPS; ++group) {
        double mean = sums[group] / (double)counts[group];
        if (group_scores) group_scores[group] = exp(mean);
        total += mean;
    }
    return exp(total / GROUPS);
}

static int same_options(xub_options a, xub_options b) {
    return a.leaf_bits == b.leaf_bits && a.sparse_limit == b.sparse_limit &&
        a.dense_complement == b.dense_complement && a.block_ratio == b.block_ratio;
}

static size_t evaluate(const workload *training, xub_options options) {
    for (size_t id = 0; id < candidate_count; ++id)
        if (same_options(candidates[id].options, options)) return id;
    if (candidate_count == CANDIDATES) { fputs("Too many candidates\n", stderr); exit(1); }
    size_t id = candidate_count++;
    candidates[id].options = options;
    for (size_t step = 0; step < CELLS; ++step) {
        /* Rotation balances early/late cells without selecting based on timing. */
        size_t cell = (step + id * 7) % CELLS;
        candidates[id].timings[cell] = measure(&training[cell], options, 3, 0.003, 0);
        if (!id) baseline[cell] = candidates[id].timings[cell];
        row("train", id, &training[cell], options, candidates[id].timings[cell],
            candidates[id].timings[cell].median / baseline[cell].median);
    }
    candidates[id].score = score(training, candidates[id].timings, baseline, NULL);
    fprintf(stderr, "Candidate %zu: leaf=%zu sparse=%zu complement=%d block=%zu score=%.4f\n",
            id, options.leaf_bits, options.sparse_limit, options.dense_complement,
            options.block_ratio, candidates[id].score);
    fflush(stdout);
    return id;
}

static void write_summary(const char *path, size_t selected, double held_score,
                          const double *group_scores, double drift) {
    FILE *out = fopen(path, "w");
    xub_options original = candidates[0].options, chosen = candidates[selected].options;
    if (!out) { perror(path); exit(1); }
    fprintf(out, "{\n  \"status\": \"passed\",\n  \"scope\": \"host-only tuning; no target-device claim\",\n"
            "  \"search\": \"two-pass coordinate descent; >=3%% training improvement required\",\n"
            "  \"groups\": %u, \"training_cells\": %u, \"held_out_cells\": %u, \"pairs_per_cell\": %u,\n"
            "  \"training_seeds\": [%" PRIu32 ", %" PRIu32 "],\n"
            "  \"held_out_seeds\": [%" PRIu32 ", %" PRIu32 "],\n"
            "  \"candidates_measured\": %zu, \"selected_candidate\": %zu,\n"
            "  \"baseline\": {\"leaf_bits\": %zu, \"sparse_limit\": %zu, \"dense_complement\": %d, \"block_ratio\": %zu},\n"
            "  \"selected\": {\"leaf_bits\": %zu, \"sparse_limit\": %zu, \"dense_complement\": %d, \"block_ratio\": %zu},\n"
            "  \"training_time_ratio\": %.9f, \"held_out_time_ratio\": %.9f,\n"
            "  \"training_baseline_end_to_start_ratio\": %.9f,\n  \"held_out_group_time_ratios\": {\n",
            GROUPS, CELLS, CELLS, PAIRS,
            corpus_seeds[0][0], corpus_seeds[0][1], corpus_seeds[1][0], corpus_seeds[1][1],
            candidate_count, selected,
            original.leaf_bits, original.sparse_limit, original.dense_complement, original.block_ratio,
            chosen.leaf_bits, chosen.sparse_limit, chosen.dense_complement, chosen.block_ratio,
            candidates[selected].score, held_score, drift);
    for (size_t i = 0; i < GROUPS; ++i)
        fprintf(out, "    \"%s\": %.9f%s\n", family_names[i], group_scores[i], i + 1 < GROUPS ? "," : "");
    fputs("  }\n}\n", out);
    if (fclose(out)) { perror(path); exit(1); }
}

int main(int argc, char **argv) {
    const char *summary_path = "build/tuning-summary.json";
    int check_only = 0;
    workload training[CELLS], held_out[CELLS];
    measurement held_baseline[CELLS], held_selected[CELLS], end_baseline[CELLS];
    xub_context initial;
    xub_options defaults;
    size_t selected;
    static const size_t leaves[] = {16, 32, 64, 128, 256};
    static const size_t sparse[] = {0, 4, 8, 16, 32};
    static const size_t complements[] = {0, 1};
    static const size_t blocks[] = {0, 2, 4, 8, 16};
    const size_t *axes[] = {leaves, sparse, complements, blocks};
    static const size_t counts[] = {5, 5, 2, 5};
    for (int i = 1; i < argc; ++i) {
        if (!strcmp(argv[i], "--check-only")) check_only = 1;
        else if (!strcmp(argv[i], "--summary") && i + 1 < argc) summary_path = argv[++i];
        else { fputs("Usage: tune_xub [--summary PATH] [--check-only]\n", stderr); return 2; }
    }
    xub_context_init(&initial); defaults = initial.options; xub_context_free(&initial);
    /* Keep the experimental control fixed after selected defaults are installed. */
    defaults.square_mode = XUB_SQUARE_AUTO;
    defaults.leaf_bits = 64; defaults.sparse_limit = 8;
    defaults.dense_complement = 1; defaults.block_ratio = 4;
    make_corpus(training, 0); make_corpus(held_out, 1);
    if (check_only) {
        for (size_t i = 0; i < CELLS; ++i) {
            (void)measure(&training[i], defaults, 0, 0, 1);
            (void)measure(&held_out[i], defaults, 0, 0, 1);
        }
        printf("Tuner corpus verified (%u independent products).\n", CELLS * PAIRS * 2);
        goto done;
    }
    puts("# Host CPU clock; fixed corpus, no production defaults changed; warm retained workspace");
    puts("# Baseline parameters fixed at AUTO leaf64/sparse8/complement1/block4, independent of installed library defaults");
    puts("# Training: median-of-3 trials >=3ms; held-out: median-of-5 trials >=10ms; every trial covers all four pairs");
    puts("# Seven groups weighted equally; sizes and seeds equally weighted within group; ratio <1 is faster");
    puts("# Two training and two disjoint held-out seeds; parity varies; top bit forced; sparse/dense sets include multiple structures");
    puts("# Coordinate search is not an exhaustive global optimum; >=3% training improvement required; held-out data never select parameters");
    puts("split,candidate,group,bits,seed,leaf_bits,sparse_limit,complement,block_ratio,median_ns,min_ns,max_ns,last_repetitions,ratio_to_baseline");
    selected = evaluate(training, defaults);
    for (unsigned pass = 0; pass < 2; ++pass) {
        for (unsigned axis = 0; axis < 4; ++axis) {
            size_t best = selected;
            xub_options origin = candidates[selected].options;
            for (size_t value = 0; value < counts[axis]; ++value) {
                xub_options options = origin;
                switch (axis) {
                    case 0: options.leaf_bits = axes[axis][value]; break;
                    case 1: options.sparse_limit = axes[axis][value]; break;
                    case 2: options.dense_complement = (int)axes[axis][value]; break;
                    case 3: options.block_ratio = axes[axis][value]; break;
                }
                size_t id = evaluate(training, options);
                if (candidates[id].score < candidates[best].score) best = id;
            }
            if (candidates[best].score < candidates[selected].score * IMPROVEMENT) selected = best;
            printf("# selection pass=%u axis=%u candidate=%zu score=%.6f\n",
                   pass + 1, axis, selected, candidates[selected].score);
        }
    }
    /* End anchor quantifies drift; it does not alter the chosen candidate. */
    for (size_t i = 0; i < CELLS; ++i) {
        end_baseline[i] = measure(&training[i], defaults, 3, 0.003, 0);
        row("train_end_anchor", 0, &training[i], defaults, end_baseline[i],
            end_baseline[i].median / baseline[i].median);
    }
    for (size_t i = 0; i < CELLS; ++i) {
        if (i & 1) {
            held_selected[i] = measure(&held_out[i], candidates[selected].options, 5, 0.010, 0);
            held_baseline[i] = measure(&held_out[i], defaults, 5, 0.010, 0);
        } else {
            held_baseline[i] = measure(&held_out[i], defaults, 5, 0.010, 0);
            held_selected[i] = measure(&held_out[i], candidates[selected].options, 5, 0.010, 0);
        }
        row("held_out_baseline", 0, &held_out[i], defaults, held_baseline[i], 1);
        row("held_out_selected", selected, &held_out[i], candidates[selected].options,
            held_selected[i], held_selected[i].median / held_baseline[i].median);
    }
    {
        double group_scores[GROUPS];
        double held_score = score(held_out, held_selected, held_baseline, group_scores);
        double drift = score(training, end_baseline, baseline, NULL);
        write_summary(summary_path, selected, held_score, group_scores, drift);
        fprintf(stderr, "Selected candidate %zu; held-out time ratio %.4f; baseline drift %.4f; %s\n",
                selected, held_score, drift, summary_path);
    }
done:
    free_corpus(training); free_corpus(held_out);
    return 0;
}
