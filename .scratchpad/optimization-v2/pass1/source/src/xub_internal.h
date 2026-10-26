#ifndef XUB_INTERNAL_H
#define XUB_INTERNAL_H
#include "xub.h"
#include <limits.h>

/* Magnitude primitives ignore input signs and produce nonnegative results.
 * xi_add/xi_sub/xi_copy_mag/xi_rshift/xi_low allow aliases. xi_lshift,
 * xi_slice and xi_add_shifted require separate source and destination. */
xub_status xi_reserve(xub_int *x, size_t limbs);
void xi_normalize(xub_int *x);
void xi_swap(xub_int *a, xub_int *b);
xub_status xi_copy_mag(xub_int *out, const xub_int *x);
int xi_cmp(const xub_int *a, const xub_int *b);
unsigned xi_clz32(uint32_t x); /* zero returns 32 */
unsigned xi_ctz32(uint32_t x); /* zero returns 32 */
size_t xi_ctz(const xub_int *x); /* zero returns 0 */
size_t xi_popcount_limit(const xub_int *x, size_t limit); /* stops above limit */
xub_status xi_add(xub_int *out, const xub_int *a, const xub_int *b);
xub_status xi_add_u32(xub_int *out, const xub_int *a, uint32_t b);
xub_status xi_sub(xub_int *out, const xub_int *a, const xub_int *b); /* a>=b */
xub_status xi_lshift(xub_int *out, const xub_int *x, size_t bits);
xub_status xi_rshift(xub_int *out, const xub_int *x, size_t bits);
xub_status xi_low(xub_int *out, const xub_int *x, size_t bits);
xub_status xi_slice(xub_int *out, const xub_int *x, size_t offset, size_t bits);
xub_status xi_set_bit(xub_int *out, size_t bit); /* OR one bit into magnitude */
/* Add src<<shift to out. SIZE_MAX means exact; otherwise modulo 2^limit.
 * src/out must differ. The limited path must not allocate the full shifted size. */
xub_status xi_add_shifted(xub_int *out, const xub_int *src, size_t shift,
                         size_t limit);
#endif
