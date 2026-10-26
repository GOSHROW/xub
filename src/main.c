#include "xub.h"

#include <ctype.h>
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int batch, stats, modular;
    unsigned base;
    size_t bits;
    const char *cache_sum;
} cli_options;

static void usage(FILE *stream) {
    fputs("Usage: xub [options] X Y\n"
          "       xub [options] --batch < pairs.txt\n\n"
          "Exact signed multiplication through subtraction of squares.\n"
          "Inputs: decimal, 0x hexadecimal, or 0b binary, with optional sign.\n\n"
          "  --mode auto|recursive|sparse|compact  Exact-square evaluator\n"
          "  --mod-bits N     Return the nonnegative residue modulo 2^N\n"
          "  --cache-sum SUM  Reuse a midpoint square; require |X|+|Y|=SUM\n"
          "  --hex            Print hexadecimal instead of decimal\n"
          "  --stats          Print branch counters as JSON to stderr\n"
          "  --batch          Read two whitespace-separated inputs per line\n"
          "  --help           Show this help\n\n"
          "--mod-bits and --cache-sum are mutually exclusive. N=0 returns zero.\n"
          "The modular path uses its own truncated-square evaluator.\n", stream);
}

static int parse_size(const char *text, size_t *out) {
    char *end;
    uintmax_t value;
    if (!text || !*text) return 0;
    for (const char *p = text; *p; ++p)
        if (*p < '0' || *p > '9') return 0;
    errno = 0;
    value = strtoumax(text, &end, 10);
    if (errno == ERANGE || *end || value > SIZE_MAX) return 0;
    *out = (size_t)value;
    return 1;
}

static void print_stats(const xub_stats *s) {
#define FIELD(name) #name "\":%" PRIu64
    fprintf(stderr,
            "{\"" FIELD(products) ",\"" FIELD(midpoint_calls)
            ",\"" FIELD(blocked_products) ",\"" FIELD(block_chunks)
            ",\"" FIELD(zero_products) ",\"" FIELD(unit_products)
            ",\"" FIELD(equal_products) ",\"" FIELD(adjacent_products)
            ",\"" FIELD(shifted_products) ",\"" FIELD(square_calls)
            ",\"" FIELD(table_squares) ",\"" FIELD(basecase_squares)
            ",\"" FIELD(sparse_squares) ",\"" FIELD(recursive_squares)
            ",\"" FIELD(complement_squares) ",\"" FIELD(reused_squares)
            ",\"" FIELD(compact_squares) ",\"" FIELD(modular_products)
            ",\"" FIELD(cached_products) ",\"" FIELD(scratch_frames)
            ",\"" FIELD(scratch_reuses) "}\n",
            s->products, s->midpoint_calls, s->blocked_products, s->block_chunks,
            s->zero_products, s->unit_products, s->equal_products,
            s->adjacent_products, s->shifted_products, s->square_calls,
            s->table_squares, s->basecase_squares, s->sparse_squares,
            s->recursive_squares, s->complement_squares, s->reused_squares,
            s->compact_squares, s->modular_products, s->cached_products,
            s->scratch_frames, s->scratch_reuses);
#undef FIELD
}

static int calculate(const char *left, const char *right, const cli_options *options,
                     xub_context *context, const xub_midpoint_cache *cache) {
    xub_int x, y, product;
    xub_status status;
    char *formatted = NULL;
    xub_init(&x); xub_init(&y); xub_init(&product);
    status = xub_parse(&x, left);
    if (status == XUB_OK) status = xub_parse(&y, right);
    if (status != XUB_OK) {
        fprintf(stderr, "Invalid operand: %s\n", xub_status_string(status));
        goto done;
    }
    xub_stats_reset(context);
    if (options->modular)
        status = xub_mul_mod2(&product, &x, &y, options->bits, context);
    else if (options->cache_sum)
        status = xub_mul_cached(&product, &x, &y, cache, context);
    else
        status = xub_mul(&product, &x, &y, context);
    if (status != XUB_OK) {
        fprintf(stderr, "Multiplication failed: %s\n", xub_status_string(status));
        goto done;
    }
    formatted = xub_format(&product, options->base);
    if (!formatted) {
        status = XUB_ENOMEM;
        fputs("Could not format result.\n", stderr);
        goto done;
    }
    if (puts(formatted) == EOF) {
        status = XUB_EINVAL;
        fputs("Could not write result.\n", stderr);
        goto done;
    }
    if (options->stats) print_stats(&context->stats);
done:
    free(formatted);
    xub_free(&x); xub_free(&y); xub_free(&product);
    return status == XUB_OK;
}

/* C11 line reader; no POSIX getline dependency. */
static int read_line(FILE *stream, char **buffer, size_t *capacity) {
    size_t used = 0;
    int c;
    while ((c = fgetc(stream)) != EOF) {
        if (used + 1 >= *capacity) {
            size_t new_capacity = *capacity ? *capacity : 256;
            char *fresh;
            if (new_capacity > SIZE_MAX / 2) return -1;
            new_capacity <<= 1;
            fresh = realloc(*buffer, new_capacity);
            if (!fresh) return -1;
            *buffer = fresh; *capacity = new_capacity;
        }
        if (c == '\n') break;
        if (c == 0) return -2;
        (*buffer)[used++] = (char)c;
    }
    if (ferror(stream)) return -2;
    if (c == EOF && !used) return 0;
    if (!*buffer) {
        *buffer = malloc(1);
        if (!*buffer) return -1;
        *capacity = 1;
    }
    (*buffer)[used] = 0;
    return 1;
}

static char *next_token(char **cursor) {
    char *begin;
    while (**cursor && isspace((unsigned char)**cursor)) ++*cursor;
    if (!**cursor) return NULL;
    begin = *cursor;
    while (**cursor && !isspace((unsigned char)**cursor)) ++*cursor;
    if (**cursor) *(*cursor)++ = 0;
    return begin;
}

int main(int argc, char **argv) {
    cli_options options = {0, 0, 0, 10, 0, NULL};
    xub_context context;
    xub_midpoint_cache cache;
    const char *operands[2] = {NULL, NULL};
    unsigned operand_count = 0;
    int end_options = 0, exit_status = 0;
    xub_context_init(&context);
    xub_cache_init(&cache);
    for (int i = 1; i < argc; ++i) {
        const char *argument = argv[i];
        if (!end_options && !strcmp(argument, "--")) { end_options = 1; continue; }
        if (!end_options && !strcmp(argument, "--help")) { usage(stdout); goto cleanup; }
        if (!end_options && !strcmp(argument, "--batch")) { options.batch = 1; continue; }
        if (!end_options && !strcmp(argument, "--stats")) { options.stats = 1; continue; }
        if (!end_options && !strcmp(argument, "--hex")) { options.base = 16; continue; }
        if (!end_options && !strcmp(argument, "--mode")) {
            if (++i == argc) goto bad_usage;
            if (!strcmp(argv[i], "auto")) context.options.square_mode = XUB_SQUARE_AUTO;
            else if (!strcmp(argv[i], "recursive")) context.options.square_mode = XUB_SQUARE_RECURSIVE;
            else if (!strcmp(argv[i], "sparse")) context.options.square_mode = XUB_SQUARE_SPARSE;
            else if (!strcmp(argv[i], "compact")) context.options.square_mode = XUB_SQUARE_COMPACT;
            else goto bad_usage;
            continue;
        }
        if (!end_options && !strcmp(argument, "--mod-bits")) {
            if (++i == argc || !parse_size(argv[i], &options.bits)) goto bad_usage;
            options.modular = 1;
            continue;
        }
        if (!end_options && !strcmp(argument, "--cache-sum")) {
            if (++i == argc) goto bad_usage;
            options.cache_sum = argv[i];
            continue;
        }
        if (!end_options && !strncmp(argument, "--", 2)) goto bad_usage;
        if (operand_count == 2) goto bad_usage;
        operands[operand_count++] = argument;
    }
    if ((options.modular && options.cache_sum) ||
        (options.batch ? operand_count != 0 : operand_count != 2)) goto bad_usage;
    if (options.cache_sum) {
        xub_int sum;
        xub_status status;
        xub_init(&sum);
        status = xub_parse(&sum, options.cache_sum);
        if (status == XUB_OK) status = xub_cache_prepare(&cache, &sum, &context);
        xub_free(&sum);
        if (status != XUB_OK) {
            fprintf(stderr, "Cannot prepare midpoint cache: %s\n", xub_status_string(status));
            exit_status = 2; goto cleanup;
        }
    }
    if (options.batch) {
        char *line = NULL;
        size_t capacity = 0, line_number = 0;
        int read_status;
        while ((read_status = read_line(stdin, &line, &capacity)) > 0) {
            char *cursor = line, *left, *right;
            ++line_number;
            left = next_token(&cursor);
            if (!left) continue;
            right = next_token(&cursor);
            if (!right || next_token(&cursor)) {
                fprintf(stderr, "Line %zu must contain exactly two operands.\n", line_number);
                exit_status = 2; break;
            }
            if (!calculate(left, right, &options, &context, &cache)) {
                fprintf(stderr, "Failed on line %zu.\n", line_number);
                exit_status = 2; break;
            }
        }
        if (read_status < 0) {
            fputs("Could not read a valid input line.\n", stderr);
            exit_status = 2;
        }
        free(line);
    } else if (!calculate(operands[0], operands[1], &options, &context, &cache)) {
        exit_status = 2;
    }
    goto cleanup;
bad_usage:
    usage(stderr);
    exit_status = 2;
cleanup:
    xub_cache_free(&cache);
    xub_context_free(&context);
    return exit_status;
}
