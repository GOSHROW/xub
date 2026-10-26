#ifndef XUB_H
#define XUB_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/* Initialize before use; free exactly once. Fields are owned by the library.
 * Little-endian base-2^32 magnitude; zero has used=0 and negative=0. */
typedef struct {
    uint32_t *limbs;
    size_t used;
    size_t capacity;
    int negative;
} xub_int;

typedef enum {
    XUB_OK = 0,
    XUB_ENOMEM,
    XUB_EINVAL,
    XUB_ERANGE,
    XUB_ECACHE
} xub_status;

typedef enum {
    XUB_SQUARE_AUTO = 0,
    XUB_SQUARE_RECURSIVE,
    XUB_SQUARE_SPARSE,
    XUB_SQUARE_COMPACT
} xub_square_mode;

typedef struct {
    xub_square_mode square_mode;
    size_t leaf_bits;         /* AUTO/RECURSIVE basecase threshold, default 64. */
    size_t sparse_limit;      /* AUTO maximum set bits, default 8; zero disables. */
    size_t block_ratio;       /* Long/short bit-length ratio, default 4; zero disables. */
    int dense_complement;    /* AUTO gated complement rule, default enabled. */
} xub_options;

typedef struct {
    uint64_t products, midpoint_calls, blocked_products, block_chunks;
    uint64_t zero_products, unit_products, equal_products, adjacent_products;
    uint64_t shifted_products, square_calls, table_squares, basecase_squares;
    uint64_t sparse_squares, recursive_squares, complement_squares;
    uint64_t reused_squares, compact_squares, modular_products, cached_products;
} xub_stats;

typedef struct {
    xub_options options;
    xub_stats stats;
    uint16_t squares[256];   /* 512-byte table, initialized with additions. */
} xub_context;

typedef struct {
    xub_int sum;             /* Sum of input MAGNITUDES for this cache. */
    xub_int midpoint_square;
    unsigned parity;
    int ready;
} xub_midpoint_cache;

void xub_init(xub_int *value);
void xub_free(xub_int *value);
xub_status xub_copy(xub_int *out, const xub_int *value);
xub_status xub_set_u64(xub_int *out, uint64_t value);
xub_status xub_set_i64(xub_int *out, int64_t value);
/* Optional sign; decimal, 0x hexadecimal, or 0b binary; no whitespace. */
xub_status xub_parse(xub_int *out, const char *text);
/* Base 2, 10, or 16. Allocated string must be freed with free(). NULL on error.
 * Nondecimal output includes 0b/0x; negative sign precedes that prefix. */
char *xub_format(const xub_int *value, unsigned base);
size_t xub_bit_length(const xub_int *value);
int xub_compare(const xub_int *a, const xub_int *b);
xub_status xub_get_i64(const xub_int *value, int64_t *out);
const char *xub_status_string(xub_status status);

void xub_context_init(xub_context *context);
void xub_stats_reset(xub_context *context);
/* Public arithmetic permits out==x or out==y; errors preserve out's value.
 * Each thread needs its own context (options, table, and counters). */
xub_status xub_square(xub_int *out, const xub_int *x, xub_context *context);
xub_status xub_mul(xub_int *out, const xub_int *x, const xub_int *y,
                   xub_context *context);
/* Canonical nonnegative residue of signed x*y modulo 2^bits; bits=0 gives 0.
 * This computes truncated squares, not a full product followed by masking. */
xub_status xub_mul_mod2(xub_int *out, const xub_int *x, const xub_int *y,
                        size_t bits, xub_context *context);

void xub_cache_init(xub_midpoint_cache *cache);
void xub_cache_free(xub_midpoint_cache *cache);
/* sum must be nonnegative. Prepare is transactional; cached calls verify
 * |x|+|y|==sum and return XUB_ECACHE on mismatch. Cache fields are library-owned;
 * out cannot point to cache->sum or cache->midpoint_square. */
xub_status xub_cache_prepare(xub_midpoint_cache *cache, const xub_int *sum,
                             xub_context *context);
xub_status xub_mul_cached(xub_int *out, const xub_int *x, const xub_int *y,
                          const xub_midpoint_cache *cache, xub_context *context);

#ifdef __cplusplus
}
#endif
#endif
