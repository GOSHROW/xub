#include "xub_internal.h"
#include <stdlib.h>
#include <string.h>

#define TRY(expr) do { status = (expr); if (status != XUB_OK) goto done; } while (0)
#define INC(c, field) (++(c)->stats.field)

/* Stable frames keep temporary ownership separate from the call stack. Each
 * active function borrows one frame; recursive calls use the next frame. On
 * return capacities remain available for subsequent siblings and products. */
#define SCRATCH_VALUES 10
typedef struct scratch_frame {
    xub_int values[SCRATCH_VALUES];
    struct scratch_frame *next;
} scratch_frame;
struct xub_workspace {
    scratch_frame *head;
    scratch_frame **cursor;
};
typedef struct {
    scratch_frame *frame;
    scratch_frame **mark;
} scratch_scope;

static xub_status scratch_begin(xub_context *c, scratch_scope *scope,
                                xub_int **values, size_t count) {
    if (count > SCRATCH_VALUES || scope->frame) return XUB_EINVAL;
    if (!c->workspace) {
        struct xub_workspace *w = malloc(sizeof(*w));
        if (!w) return XUB_ENOMEM;
        w->head = NULL; w->cursor = &w->head;
        c->workspace = w;
    }
    struct xub_workspace *w = c->workspace;
    scratch_frame **mark = w->cursor;
    if (!*mark) {
        scratch_frame *f = malloc(sizeof(*f));
        if (!f) return XUB_ENOMEM;
        for (size_t i = 0; i < SCRATCH_VALUES; ++i) xub_init(&f->values[i]);
        f->next = NULL; *mark = f;
        INC(c, scratch_frames);
    } else INC(c, scratch_reuses);
    scope->frame = *mark; scope->mark = mark;
    w->cursor = &scope->frame->next;
    for (size_t i = 0; i < count; ++i) {
        xi_swap(values[i], &scope->frame->values[i]);
        values[i]->used = 0; values[i]->negative = 0;
    }
    return XUB_OK;
}

static void scratch_end(xub_context *c, scratch_scope *scope,
                        xub_int **values, size_t count) {
    if (!scope->frame) return;
    for (size_t i = 0; i < count; ++i)
        xi_swap(values[i], &scope->frame->values[i]);
    c->workspace->cursor = scope->mark;
}

#define SCRATCH(...) \
    xub_int *scratch_values[] = { __VA_ARGS__ }; \
    size_t scratch_count = sizeof(scratch_values) / sizeof(*scratch_values); \
    scratch_scope scope = { NULL, NULL }
#define BORROW() TRY(scratch_begin(c, &scope, scratch_values, scratch_count))
#define RETURN_SCRATCH() scratch_end(c, &scope, scratch_values, scratch_count)

static int valid_int(const xub_int *x) {
    return x && x->used <= x->capacity && x->used <= (SIZE_MAX >> 5) &&
        (!x->used || (x->limbs && x->limbs[x->used - 1] != 0)) &&
        (x->negative == 0 || x->negative == 1) && (x->used || !x->negative);
}

static int valid_context(const xub_context *c) {
    return c && c->options.square_mode >= XUB_SQUARE_AUTO &&
        c->options.square_mode <= XUB_SQUARE_COMPACT &&
        c->options.leaf_bits >= 8 &&
        (c->options.block_ratio == 0 || c->options.block_ratio >= 2) &&
        (c->options.dense_complement == 0 || c->options.dense_complement == 1);
}

void xub_context_init(xub_context *c) {
    if (!c) return;
    memset(c, 0, sizeof(*c));
    c->options.square_mode = XUB_SQUARE_AUTO;
    c->options.leaf_bits = 32;
    c->options.sparse_limit = 32;
    c->options.block_ratio = 4;
    c->options.dense_complement = 1;
    uint32_t square = 0, odd = 1;
    for (size_t i = 0; i < 256; ++i) {
        c->squares[i] = (uint16_t)square;
        square += odd;
        odd += 2;
    }
}

void xub_stats_reset(xub_context *c) {
    if (c) memset(&c->stats, 0, sizeof(c->stats));
}

void xub_context_trim(xub_context *c) {
    if (!c || !c->workspace) return;
    scratch_frame *frame = c->workspace->head;
    while (frame) {
        scratch_frame *next = frame->next;
        for (size_t i = 0; i < SCRATCH_VALUES; ++i) xub_free(&frame->values[i]);
        free(frame); frame = next;
    }
    free(c->workspace); c->workspace = NULL;
}

void xub_context_free(xub_context *c) {
    if (!c) return;
    xub_context_trim(c);
    memset(c, 0, sizeof(*c));
}

static xub_status square_mag(xub_int *, const xub_int *, xub_context *);
static xub_status multiply_mag(xub_int *, const xub_int *, const xub_int *, xub_context *);

/* Every elementary digit product uses the same integer midpoint identity. */
static uint32_t multiply_byte(uint32_t x, uint32_t y, const xub_context *c) {
    uint32_t a = x < y ? x : y, b = x < y ? y : x;
    uint32_t delta = b - a, d = delta >> 1, h = a + d;
    return (uint32_t)c->squares[h] - c->squares[d] + ((delta & 1) ? a : 0);
}

static uint32_t get_byte(const xub_int *x, size_t index) {
    return (x->limbs[index >> 2] >> ((index & 3) << 3)) & UINT32_C(255);
}

static xub_status add_word_shifted(xub_int *out, uint32_t word,
                                    size_t shift, size_t limit) {
    xub_int view = { &word, word ? 1u : 0u, 1u, 0 };
    return xi_add_shifted(out, &view, shift, limit);
}

static xub_status square_basecase(xub_int *out, const xub_int *x, xub_context *c) {
    size_t bits = xub_bit_length(x), bytes = (bits + 7) >> 3;
    xub_status status = XUB_OK;
    INC(c, basecase_squares);
    if (bits <= 32) {
        uint64_t sum = 0;
        for (size_t i = 0; i < bytes; ++i) {
            uint32_t a = get_byte(x, i);
            sum += (uint64_t)c->squares[a] << (i << 4);
            for (size_t j = i + 1; j < bytes; ++j)
                sum += (uint64_t)multiply_byte(a, get_byte(x, j), c)
                       << (((i + j) << 3) + 1);
        }
        return xub_set_u64(out, sum);
    }
    out->used = 0; out->negative = 0;
    for (size_t i = 0; i < bytes; ++i) {
        uint32_t a = get_byte(x, i);
        if (!a) continue;
        TRY(add_word_shifted(out, c->squares[a], i << 4, SIZE_MAX));
        for (size_t j = i + 1; j < bytes; ++j) {
            uint32_t b = get_byte(x, j);
            if (b) TRY(add_word_shifted(out, multiply_byte(a, b, c) << 1,
                                      (i + j) << 3, SIZE_MAX));
        }
    }
done:
    return status;
}

/* Sparse rows; limit==SIZE_MAX means exact. The bounded variant stops when
 * every remaining diagonal/cross term is above the requested output bits. */
static xub_status square_sparse(xub_int *out, const xub_int *x,
                                 size_t limit, xub_context *c) {
    xub_status status = XUB_OK;
    xub_int remaining; xub_init(&remaining);
    SCRATCH(&remaining); BORROW();
    INC(c, sparse_squares);
    out->used = 0; out->negative = 0;
    if (limit == SIZE_MAX) TRY(xi_copy_mag(&remaining, x));
    else TRY(xi_low(&remaining, x, limit));
    size_t words = remaining.used;
    size_t stop = limit == SIZE_MAX ? SIZE_MAX : (limit >> 1) + (limit & 1);
    for (size_t w = 0; w < words; ++w) {
        uint32_t active = remaining.limbs[w];
        while (active) {
            size_t bit = (w << 5) + xi_ctz32(active);
            if (bit >= stop) goto done;
            active &= active - 1;
            remaining.limbs[w] = active;
            xi_normalize(&remaining);
            TRY(add_word_shifted(out, 1, bit << 1, limit));
            TRY(xi_add_shifted(out, &remaining, bit + 1, limit));
        }
    }
done:
    RETURN_SCRATCH();
    return status;
}

static xub_status square_compact(xub_int *out, const xub_int *x, xub_context *c) {
    xub_status status = XUB_OK;
    xub_int prefix, shifted; xub_init(&prefix); xub_init(&shifted);
    SCRATCH(&prefix, &shifted); BORROW();
    INC(c, compact_squares);
    out->used = 0; out->negative = 0;
    for (size_t bit = xub_bit_length(x); bit-- > 0;) {
        unsigned one = (x->limbs[bit >> 5] >> (bit & 31)) & 1u;
        TRY(xi_lshift(&shifted, out, 2)); xi_swap(out, &shifted);
        if (one) {
            TRY(xi_add_shifted(out, &prefix, 2, SIZE_MAX));
            TRY(xi_add_u32(out, out, 1));
        }
        TRY(xi_lshift(&shifted, &prefix, 1)); xi_swap(&prefix, &shifted);
        if (one) TRY(xi_add_u32(&prefix, &prefix, 1));
    }
done:
    RETURN_SCRATCH();
    return status;
}

static xub_status complement_distance(xub_int *out, const xub_int *x, size_t bits) {
    xub_status status = xi_reserve(out, x->used);
    if (status != XUB_OK) return status;
    for (size_t i = 0; i < x->used; ++i) out->limbs[i] = ~x->limbs[i];
    if (bits & 31) out->limbs[x->used - 1] &= (UINT32_C(1) << (bits & 31)) - 1;
    out->used = x->used; out->negative = 0;
    xi_normalize(out);
    return xi_add_u32(out, out, 1);
}

/* Called only for odd x. In that case (~x)+1 changes only the low bit, so
 * reject an unhelpful complement without allocating or copying its limbs. */
static int useful_complement(const xub_int *x, size_t bits, size_t limit) {
    size_t count = 0;
    int found = 0;
    for (size_t i = x->used; i-- > 0;) {
        uint32_t word = ~x->limbs[i];
        if (i == x->used - 1 && (bits & 31))
            word &= (UINT32_C(1) << (bits & 31)) - 1;
        if (!i) word |= 1;
        if (!found && word) {
            size_t length = (i << 5) + 32 - xi_clz32(word);
            if (length <= bits / 2) return 1;
            if (!limit) return 0;
            found = 1;
        }
        while (word) {
            word &= word - 1;
            if (++count > limit) return 0;
        }
    }
    return found && count <= limit;
}

static xub_status square_recursive(xub_int *out, const xub_int *x, xub_context *c) {
    xub_status status = XUB_OK;
    xub_int high, low, delta, u, v, w, cross;
    xub_init(&delta); xub_init(&u);
    xub_init(&v); xub_init(&w); xub_init(&cross);
    SCRATCH(&delta, &u, &v, &w, &cross); BORROW();
    INC(c, recursive_squares);
    size_t split = x->used > 1 ? (x->used >> 1) << 5 : xub_bit_length(x) >> 1;
    uint32_t high_word = 0, low_word = 0;
    if (x->used > 1) {
        size_t words = split >> 5;
        high = (xub_int){ x->limbs + words, x->used - words, x->used - words, 0 };
        low = (xub_int){ x->limbs, words, words, 0 };
        xi_normalize(&low);
    } else {
        high_word = x->limbs[0] >> split;
        low_word = x->limbs[0] & ((UINT32_C(1) << split) - 1);
        high = (xub_int){ &high_word, high_word != 0, 1, 0 };
        low = (xub_int){ &low_word, low_word != 0, 1, 0 };
    }
    /* high/low are read-only views; their buffers remain owned by x or this
     * stack frame and are neither reserved nor returned to the scratch pool. */
    TRY(square_mag(&u, &high, c));
    if (!low.used) {
        INC(c, reused_squares);
        TRY(xi_lshift(out, &u, split << 1));
    } else if (xi_cmp(&high, &low) == 0) {
        INC(c, reused_squares);
        TRY(xi_lshift(out, &u, split << 1));
        TRY(xi_add_shifted(out, &u, split + 1, SIZE_MAX));
        TRY(xi_add(out, out, &u));
    } else {
        if (xi_cmp(&high, &low) >= 0) TRY(xi_sub(&delta, &high, &low));
        else TRY(xi_sub(&delta, &low, &high));
        TRY(square_mag(&v, &low, c)); TRY(square_mag(&w, &delta, c));
        TRY(xi_add(&cross, &u, &v)); TRY(xi_sub(&cross, &cross, &w));
        TRY(xi_lshift(out, &u, split << 1));
        TRY(xi_add_shifted(out, &cross, split, SIZE_MAX));
        TRY(xi_add(out, out, &v));
    }
done:
    RETURN_SCRATCH();
    return status;
}

static xub_status square_mag(xub_int *out, const xub_int *x, xub_context *c) {
    xub_status status = XUB_OK;
    xub_int reduced, result, difference;
    xub_init(&reduced); xub_init(&result); xub_init(&difference);
    SCRATCH(&reduced, &result, &difference);
    INC(c, square_calls);
    size_t bits = xub_bit_length(x);
    if (bits > SIZE_MAX / 2) { status = XUB_ERANGE; goto done; }
    if (bits <= 8) {
        INC(c, table_squares);
        TRY(xub_set_u64(out, c->squares[x->used ? x->limbs[0] : 0]));
        goto done;
    }
    size_t zeros = xi_ctz(x);
    if (zeros) {
        BORROW();
        TRY(xi_rshift(&reduced, x, zeros));
        TRY(square_mag(&result, &reduced, c));
        TRY(xi_lshift(out, &result, zeros << 1));
        goto done;
    }
    if (c->options.square_mode == XUB_SQUARE_COMPACT) {
        TRY(square_compact(out, x, c)); goto done;
    }
    if (c->options.square_mode == XUB_SQUARE_SPARSE) {
        TRY(square_sparse(out, x, SIZE_MAX, c)); goto done;
    }
    if (c->options.square_mode == XUB_SQUARE_AUTO && bits > 16 &&
        bits > c->options.leaf_bits) {
        /* Cheap scalar leaves need no classifier. Larger rows must also be
         * sparse in density: a high count threshold alone misclassifies small
         * random values and can cost more than their recursive square. */
        size_t sparse_limit = c->options.sparse_limit;
        if (sparse_limit > (bits >> 4)) sparse_limit = bits >> 4;
        if (sparse_limit && xi_popcount_limit(x, sparse_limit) <= sparse_limit) {
            TRY(square_sparse(out, x, SIZE_MAX, c)); goto done;
        }
        if (c->options.dense_complement &&
            useful_complement(x, bits, sparse_limit)) {
            BORROW();
            TRY(complement_distance(&reduced, x, bits));
            size_t rb = xub_bit_length(&reduced);
            if (xi_cmp(&reduced, x) < 0 &&
                (rb <= bits / 2 || (sparse_limit &&
                 xi_popcount_limit(&reduced, sparse_limit) <= sparse_limit))) {
                INC(c, complement_squares);
                TRY(xi_sub(&difference, x, &reduced));
                TRY(square_mag(&result, &reduced, c));
                TRY(xi_lshift(out, &difference, bits));
                TRY(xi_add(out, out, &result));
                goto done;
            }
        }
    }
    if (bits <= c->options.leaf_bits) TRY(square_basecase(out, x, c));
    else TRY(square_recursive(out, x, c));
done:
    RETURN_SCRATCH();
    return status;
}

/* Cheap reductions are the corresponding D(h,d) identities. They are used
 * both by the top-level dispatcher and each blocked elementary product. */
static xub_status midpoint_exact(xub_int *out, const xub_int *x,
                                  const xub_int *y, xub_context *c) {
    const xub_int *a = x, *b = y;
    if (xi_cmp(a, b) > 0) { a = y; b = x; }
    xub_status status = XUB_OK;
    xub_int delta, d, h, dsq;
    xub_init(&delta); xub_init(&d); xub_init(&h); xub_init(&dsq);
    SCRATCH(&delta, &d, &h, &dsq);
    INC(c, midpoint_calls);
    if (!a->used) {
        INC(c, zero_products); out->used = 0; out->negative = 0; goto done;
    }
    if (a->used == 1 && a->limbs[0] == 1) {
        INC(c, unit_products); TRY(xi_copy_mag(out, b)); goto done;
    }
    if (xi_cmp(a, b) == 0) {
        INC(c, equal_products); TRY(square_mag(out, a, c)); goto done;
    }
    if (b->used == 1 && b->limbs[0] <= 255) {
        unsigned squares = b->limbs[0] - a->limbs[0] == 1 ? 1 : 2;
        if (squares == 1) INC(c, adjacent_products);
        c->stats.square_calls += squares; c->stats.table_squares += squares;
        TRY(xub_set_u64(out, multiply_byte(a->limbs[0], b->limbs[0], c)));
        goto done;
    }
    BORROW();
    TRY(xi_sub(&delta, b, a));
    if (delta.used == 1 && delta.limbs[0] == 1) {
        INC(c, adjacent_products);
        TRY(square_mag(out, a, c)); TRY(xi_add(out, out, a)); goto done;
    }
    unsigned odd = delta.limbs[0] & 1u;
    TRY(xi_rshift(&d, &delta, 1)); TRY(xi_add(&h, a, &d));
    TRY(square_mag(out, &h, c)); TRY(square_mag(&dsq, &d, c));
    TRY(xi_sub(out, out, &dsq));
    if (odd) TRY(xi_add(out, out, a));
done:
    RETURN_SCRATCH();
    return status;
}

static xub_status multiply_blocked(xub_int *out, const xub_int *a,
                                    const xub_int *b, xub_context *c) {
    xub_status status = XUB_OK;
    xub_int digit, product, carry, low;
    xub_init(&digit); xub_init(&product); xub_init(&carry); xub_init(&low);
    SCRATCH(&digit, &product, &carry, &low);
    size_t width = xub_bit_length(a), total = xub_bit_length(b), offset = 0;
    INC(c, blocked_products);
    out->used = 0; out->negative = 0;
    if (a->used == 1 && a->limbs[0] <= 255) {
        /* Stream base-256 products through the same midpoint table without
         * materializing a separate arbitrary-precision integer per chunk. */
        TRY(xi_reserve(out, b->used + 1));
        uint32_t next = 0;
        for (size_t i = 0; i < b->used; ++i) {
            uint32_t assembled = 0;
            for (unsigned shift = 0; shift < 32; shift += 8) {
                uint32_t byte = (b->limbs[i] >> shift) & 255u;
                uint32_t value = multiply_byte(a->limbs[0], byte, c) + next;
                assembled |= (value & 255u) << shift;
                next = value >> 8;
            }
            out->limbs[i] = assembled;
        }
        out->limbs[b->used] = next;
        out->used = b->used + (next != 0);
        size_t chunks = b->used << 2;
        c->stats.block_chunks += chunks; c->stats.midpoint_calls += chunks;
        c->stats.square_calls += chunks << 1; c->stats.table_squares += chunks << 1;
        xi_normalize(out);
        goto done;
    }
    BORROW();
    while (offset < total) {
        TRY(xi_slice(&digit, b, offset, width));
        INC(c, block_chunks);
        TRY(midpoint_exact(&product, a, &digit, c));
        TRY(xi_add(&product, &product, &carry));
        TRY(xi_low(&low, &product, width));
        TRY(xi_add_shifted(out, &low, offset, SIZE_MAX));
        TRY(xi_rshift(&carry, &product, width));
        if (offset > SIZE_MAX - width) { status = XUB_ERANGE; goto done; }
        offset += width;
    }
    TRY(xi_add_shifted(out, &carry, offset, SIZE_MAX));
done:
    RETURN_SCRATCH();
    return status;
}

static xub_status multiply_mag(xub_int *out, const xub_int *x,
                                const xub_int *y, xub_context *c) {
    const xub_int *a = x, *b = y;
    if (xi_cmp(a, b) > 0) { a = y; b = x; }
    xub_status status = XUB_OK;
    xub_int delta, ar, br, product;
    xub_init(&delta); xub_init(&ar); xub_init(&br); xub_init(&product);
    SCRATCH(&delta, &ar, &br, &product);
    if (!a->used || (a->used == 1 && a->limbs[0] == 1) || xi_cmp(a, b) == 0 ||
        (b->used == 1 && b->limbs[0] <= 255)) {
        TRY(midpoint_exact(out, a, b, c)); goto done;
    }
    BORROW();
    TRY(xi_sub(&delta, b, a));
    /* Adjacent inputs are recognized before removing trailing zeros. */
    if (delta.used == 1 && delta.limbs[0] == 1) {
        TRY(midpoint_exact(out, a, b, c)); goto done;
    }
    /* Preserve a short half-distance before independently stripping zeros:
     * unequal shifts can destroy proximity and create two full-size squares. */
    if (xub_bit_length(&delta) <= xub_bit_length(b) / 2) {
        TRY(midpoint_exact(out, a, b, c)); goto done;
    }
    size_t az = xi_ctz(a), bz = xi_ctz(b);
    if (az || bz) {
        if (az > SIZE_MAX - bz) { status = XUB_ERANGE; goto done; }
        INC(c, shifted_products);
        TRY(xi_rshift(&ar, a, az)); TRY(xi_rshift(&br, b, bz));
        TRY(multiply_mag(&product, &ar, &br, c));
        TRY(xi_lshift(out, &product, az + bz)); goto done;
    }
    size_t ab = xub_bit_length(a), bb = xub_bit_length(b);
    if (c->options.block_ratio && bb / ab >= c->options.block_ratio)
        TRY(multiply_blocked(out, a, b, c));
    else TRY(midpoint_exact(out, a, b, c));
done:
    RETURN_SCRATCH();
    return status;
}

xub_status xub_square(xub_int *out, const xub_int *x, xub_context *c) {
    if (!out || !valid_int(x) || !valid_context(c)) return XUB_EINVAL;
    xub_int result; xub_init(&result);
    xub_status status = XUB_OK;
    SCRATCH(&result); BORROW();
    status = square_mag(&result, x, c);
    if (status == XUB_OK) xi_swap(out, &result);
done:
    RETURN_SCRATCH(); return status;
}

xub_status xub_mul(xub_int *out, const xub_int *x, const xub_int *y, xub_context *c) {
    if (!out || !valid_int(x) || !valid_int(y) || !valid_context(c)) return XUB_EINVAL;
    xub_int result; xub_init(&result);
    xub_status status = XUB_OK;
    SCRATCH(&result); BORROW();
    INC(c, products);
    status = multiply_mag(&result, x, y, c);
    if (status == XUB_OK) {
        result.negative = result.used && (x->negative != y->negative);
        xi_swap(out, &result);
    }
done:
    RETURN_SCRATCH(); return status;
}

static xub_status square_low(xub_int *out, const xub_int *x, size_t bits, xub_context *c) {
    INC(c, square_calls);
    if (xub_bit_length(x) <= 8) {
        uint32_t value = c->squares[x->used ? x->limbs[0] : 0];
        if (bits < 16) value &= (UINT32_C(1) << bits) - 1;
        INC(c, table_squares);
        return xub_set_u64(out, value);
    }
    return square_sparse(out, x, bits, c);
}

xub_status xub_mul_mod2(xub_int *out, const xub_int *x, const xub_int *y,
                         size_t bits, xub_context *c) {
    if (!out || !valid_int(x) || !valid_int(y) || !valid_context(c)) return XUB_EINVAL;
    if (bits > SIZE_MAX - 64) return XUB_ERANGE;
    xub_status status = XUB_OK;
    xub_int ax, ay, delta, d, h, hs, ds, power, result, tmp;
    xub_init(&ax); xub_init(&ay); xub_init(&delta); xub_init(&d); xub_init(&h);
    xub_init(&hs); xub_init(&ds); xub_init(&power); xub_init(&result); xub_init(&tmp);
    SCRATCH(&ax, &ay, &delta, &d, &h, &hs, &ds, &power, &result, &tmp); BORROW();
    INC(c, products); INC(c, modular_products);
    if (!bits) goto commit;
    TRY(xi_low(&ax, x, bits)); TRY(xi_low(&ay, y, bits));
    const xub_int *a = &ax, *b = &ay;
    if (xi_cmp(a, b) > 0) { a = &ay; b = &ax; }
    if (!a->used) goto commit;
    INC(c, midpoint_calls);
    TRY(xi_sub(&delta, b, a));
    unsigned odd = delta.used ? delta.limbs[0] & 1u : 0;
    TRY(xi_rshift(&d, &delta, 1)); TRY(xi_add(&h, a, &d));
    TRY(square_low(&hs, &h, bits, c)); TRY(square_low(&ds, &d, bits, c));
    if (xi_cmp(&hs, &ds) >= 0) TRY(xi_sub(&result, &hs, &ds));
    else {
        TRY(xi_sub(&tmp, &ds, &hs)); TRY(xi_set_bit(&power, bits));
        TRY(xi_sub(&result, &power, &tmp));
    }
    if (odd) TRY(xi_add(&result, &result, a));
    TRY(xi_low(&result, &result, bits));
    if (result.used && x->negative != y->negative) {
        if (!power.used) TRY(xi_set_bit(&power, bits));
        TRY(xi_sub(&tmp, &power, &result)); xi_swap(&result, &tmp);
    }
commit:
    result.negative = 0;
    xi_swap(out, &result);
done:
    RETURN_SCRATCH();
    return status;
}

void xub_cache_init(xub_midpoint_cache *cache) {
    if (!cache) return;
    xub_init(&cache->sum); xub_init(&cache->midpoint_square);
    cache->parity = 0; cache->ready = 0;
}

void xub_cache_free(xub_midpoint_cache *cache) {
    if (!cache) return;
    xub_free(&cache->sum); xub_free(&cache->midpoint_square);
    cache->parity = 0; cache->ready = 0;
}

xub_status xub_cache_prepare(xub_midpoint_cache *cache, const xub_int *sum, xub_context *c) {
    if (!cache || !valid_int(sum) || sum->negative || !valid_context(c)) return XUB_EINVAL;
    xub_status status = XUB_OK;
    xub_int saved, h, square; xub_init(&saved); xub_init(&h); xub_init(&square);
    SCRATCH(&saved, &h, &square); BORROW();
    TRY(xi_copy_mag(&saved, sum)); TRY(xi_rshift(&h, sum, 1));
    TRY(square_mag(&square, &h, c));
    cache->parity = saved.used ? saved.limbs[0] & 1u : 0;
    xi_swap(&cache->sum, &saved); xi_swap(&cache->midpoint_square, &square);
    cache->ready = 1;
done:
    RETURN_SCRATCH();
    return status;
}

xub_status xub_mul_cached(xub_int *out, const xub_int *x, const xub_int *y,
                           const xub_midpoint_cache *cache, xub_context *c) {
    if (!out || !cache || !valid_int(x) || !valid_int(y) || !valid_context(c) ||
        out == &cache->sum || out == &cache->midpoint_square) return XUB_EINVAL;
    if (!cache->ready) return XUB_ECACHE;
    xub_status status = XUB_OK;
    xub_int sum, delta, d, dsq, result;
    xub_init(&sum); xub_init(&delta); xub_init(&d); xub_init(&dsq); xub_init(&result);
    SCRATCH(&sum, &delta, &d, &dsq, &result); BORROW();
    INC(c, products); INC(c, cached_products);
    TRY(xi_add(&sum, x, y));
    if (xi_cmp(&sum, &cache->sum) != 0) { status = XUB_ECACHE; goto done; }
    const xub_int *a = x, *b = y;
    if (xi_cmp(a, b) > 0) { a = y; b = x; }
    TRY(xi_sub(&delta, b, a)); TRY(xi_rshift(&d, &delta, 1));
    TRY(square_mag(&dsq, &d, c));
    TRY(xi_sub(&result, &cache->midpoint_square, &dsq));
    if (cache->parity) TRY(xi_add(&result, &result, a));
    result.negative = result.used && x->negative != y->negative;
    xi_swap(out, &result);
done:
    RETURN_SCRATCH();
    return status;
}
