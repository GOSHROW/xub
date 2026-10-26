#include "xub_internal.h"

#include <stdlib.h>
#include <string.h>

/* Keeping limb counts below this bound also makes bit lengths fit size_t. */
#define XI_MAX_LIMBS (SIZE_MAX / 32u)

void xub_init(xub_int *x) {
    if (x) { x->limbs = NULL; x->used = x->capacity = 0; x->negative = 0; }
}

void xub_free(xub_int *x) {
    if (x) { free(x->limbs); xub_init(x); }
}

void xi_swap(xub_int *a, xub_int *b) {
    xub_int t = *a; *a = *b; *b = t;
}

xub_status xi_reserve(xub_int *x, size_t n) {
    size_t capacity;
    uint32_t *p;
    if (n > XI_MAX_LIMBS || n > SIZE_MAX / sizeof(*p)) return XUB_ERANGE;
    if (n <= x->capacity) return XUB_OK;
    capacity = x->capacity ? x->capacity : 2;
    while (capacity < n) {
        if (capacity > XI_MAX_LIMBS / 2) { capacity = n; break; }
        capacity <<= 1;
    }
    if (capacity > XI_MAX_LIMBS) capacity = n;
    p = realloc(x->limbs, capacity * sizeof(*p));
    if (!p) return XUB_ENOMEM;
    memset(p + x->capacity, 0, (capacity - x->capacity) * sizeof(*p));
    x->limbs = p; x->capacity = capacity;
    return XUB_OK;
}

void xi_normalize(xub_int *x) {
    while (x->used && x->limbs[x->used - 1] == 0) --x->used;
    if (!x->used) x->negative = 0;
}

unsigned xi_clz32(uint32_t x) {
    unsigned n = 0;
    if (!x) return 32;
    while (!(x & UINT32_C(0x80000000))) { x <<= 1; ++n; }
    return n;
}

unsigned xi_ctz32(uint32_t x) {
    unsigned n = 0;
    if (!x) return 32;
    while (!(x & 1u)) { x >>= 1; ++n; }
    return n;
}

size_t xub_bit_length(const xub_int *x) {
    if (!x || !x->used) return 0;
    return ((x->used - 1) << 5) + (32u - xi_clz32(x->limbs[x->used - 1]));
}

size_t xi_ctz(const xub_int *x) {
    size_t i = 0;
    if (!x->used) return 0;
    while (i < x->used && x->limbs[i] == 0) ++i;
    return i < x->used ? (i << 5) + xi_ctz32(x->limbs[i]) : 0;
}

size_t xi_popcount_limit(const xub_int *x, size_t limit) {
    size_t count = 0;
    for (size_t i = 0; i < x->used; ++i) {
        uint32_t word = x->limbs[i];
        while (word) {
            word &= word - 1u;
            ++count;
            if (count > limit) return count;
        }
    }
    return count;
}

int xi_cmp(const xub_int *a, const xub_int *b) {
    if (a->used != b->used) return a->used > b->used ? 1 : -1;
    for (size_t i = a->used; i; --i)
        if (a->limbs[i - 1] != b->limbs[i - 1])
            return a->limbs[i - 1] > b->limbs[i - 1] ? 1 : -1;
    return 0;
}

int xub_compare(const xub_int *a, const xub_int *b) {
    int an = a->used && a->negative, bn = b->used && b->negative;
    int c;
    if (an != bn) return an ? -1 : 1;
    c = xi_cmp(a, b);
    return an ? -c : c;
}

xub_status xi_copy_mag(xub_int *out, const xub_int *x) {
    xub_status status;
    if (out == x) { out->negative = 0; return XUB_OK; }
    status = xi_reserve(out, x->used);
    if (status != XUB_OK) return status;
    if (x->used) memcpy(out->limbs, x->limbs, x->used * sizeof(*x->limbs));
    out->used = x->used; out->negative = 0;
    return XUB_OK;
}

xub_status xub_copy(xub_int *out, const xub_int *x) {
    xub_int t;
    xub_status status;
    if (!out || !x) return XUB_EINVAL;
    if (out == x) return XUB_OK;
    xub_init(&t);
    status = xi_copy_mag(&t, x);
    if (status == XUB_OK) { t.negative = x->used && x->negative; xi_swap(out, &t); }
    xub_free(&t);
    return status;
}

xub_status xub_set_u64(xub_int *out, uint64_t value) {
    xub_int t;
    xub_status status = XUB_OK;
    if (!out) return XUB_EINVAL;
    xub_init(&t);
    if (value) {
        t.used = (value >> 32) ? 2 : 1;
        status = xi_reserve(&t, t.used);
        if (status != XUB_OK) { xub_free(&t); return status; }
        t.limbs[0] = (uint32_t)value;
        if (t.used == 2) t.limbs[1] = (uint32_t)(value >> 32);
    }
    xi_swap(out, &t); xub_free(&t);
    return status;
}

xub_status xub_set_i64(xub_int *out, int64_t value) {
    uint64_t magnitude = (uint64_t)value;
    xub_status status;
    if (value < 0) magnitude = UINT64_C(0) - magnitude;
    status = xub_set_u64(out, magnitude);
    if (status == XUB_OK) out->negative = magnitude && value < 0;
    return status;
}

xub_status xub_get_i64(const xub_int *x, int64_t *out) {
    uint64_t magnitude = 0;
    if (!x || !out) return XUB_EINVAL;
    if (x->used > 2) return XUB_ERANGE;
    if (x->used) magnitude = x->limbs[0];
    if (x->used == 2) magnitude |= (uint64_t)x->limbs[1] << 32;
    if (x->negative) {
        if (magnitude > (UINT64_C(1) << 63)) return XUB_ERANGE;
        *out = magnitude == (UINT64_C(1) << 63) ? INT64_MIN : -(int64_t)magnitude;
    } else {
        if (magnitude > INT64_MAX) return XUB_ERANGE;
        *out = (int64_t)magnitude;
    }
    return XUB_OK;
}

xub_status xi_add(xub_int *out, const xub_int *a, const xub_int *b) {
    size_t na = a->used, nb = b->used, n = na > nb ? na : nb;
    uint64_t carry = 0;
    xub_status status;
    if (n >= XI_MAX_LIMBS) return XUB_ERANGE;
    status = xi_reserve(out, n + 1);
    if (status != XUB_OK) return status;
    for (size_t i = 0; i < n; ++i) {
        uint64_t v = carry;
        if (i < na) v += a->limbs[i];
        if (i < nb) v += b->limbs[i];
        out->limbs[i] = (uint32_t)v; carry = v >> 32;
    }
    out->limbs[n] = (uint32_t)carry;
    out->used = n + (carry != 0); out->negative = 0;
    xi_normalize(out);
    return XUB_OK;
}

xub_status xi_add_u32(xub_int *out, const xub_int *a, uint32_t b) {
    xub_int small;
    small.limbs = &b; small.used = b ? 1 : 0; small.capacity = 1; small.negative = 0;
    return xi_add(out, a, &small);
}

xub_status xi_sub(xub_int *out, const xub_int *a, const xub_int *b) {
    size_t na = a->used, nb = b->used;
    uint64_t borrow = 0;
    xub_status status;
    if (xi_cmp(a, b) < 0) return XUB_EINVAL;
    status = xi_reserve(out, na);
    if (status != XUB_OK) return status;
    for (size_t i = 0; i < na; ++i) {
        uint64_t av = a->limbs[i];
        uint64_t bv = (i < nb ? b->limbs[i] : 0) + borrow;
        out->limbs[i] = (uint32_t)(av - bv);
        borrow = av < bv;
    }
    out->used = na; out->negative = 0; xi_normalize(out);
    return XUB_OK;
}

xub_status xi_lshift(xub_int *out, const xub_int *x, size_t bits) {
    size_t offset = bits >> 5, n;
    unsigned part = (unsigned)(bits & 31u);
    uint64_t carry = 0;
    xub_status status;
    if (out == x) return XUB_EINVAL;
    if (!x->used) { out->used = 0; out->negative = 0; return XUB_OK; }
    if (offset > XI_MAX_LIMBS - x->used) return XUB_ERANGE;
    n = offset + x->used;
    if (part) { if (n >= XI_MAX_LIMBS) return XUB_ERANGE; ++n; }
    status = xi_reserve(out, n);
    if (status != XUB_OK) return status;
    if (offset) memset(out->limbs, 0, offset * sizeof(*out->limbs));
    for (size_t i = 0; i < x->used; ++i) {
        uint64_t v = ((uint64_t)x->limbs[i] << part) | carry;
        out->limbs[offset + i] = (uint32_t)v; carry = v >> 32;
    }
    if (part) out->limbs[n - 1] = (uint32_t)carry;
    out->used = n; out->negative = 0; xi_normalize(out);
    return XUB_OK;
}

xub_status xi_rshift(xub_int *out, const xub_int *x, size_t bits) {
    size_t offset = bits >> 5, nx = x->used, n;
    unsigned part = (unsigned)(bits & 31u);
    xub_status status;
    if (offset >= nx) { out->used = 0; out->negative = 0; return XUB_OK; }
    n = nx - offset;
    status = xi_reserve(out, n);
    if (status != XUB_OK) return status;
    for (size_t i = 0; i < n; ++i) {
        uint32_t v = x->limbs[offset + i] >> part;
        if (part && offset + i + 1 < nx)
            v |= x->limbs[offset + i + 1] << (32u - part);
        out->limbs[i] = v;
    }
    out->used = n; out->negative = 0; xi_normalize(out);
    return XUB_OK;
}

xub_status xi_low(xub_int *out, const xub_int *x, size_t bits) {
    size_t n;
    unsigned part;
    xub_status status;
    if (bits >= xub_bit_length(x)) return xi_copy_mag(out, x);
    n = (bits >> 5) + ((bits & 31u) != 0);
    part = (unsigned)(bits & 31u);
    status = xi_reserve(out, n);
    if (status != XUB_OK) return status;
    if (n && out != x) memcpy(out->limbs, x->limbs, n * sizeof(*out->limbs));
    if (part) out->limbs[n - 1] &= UINT32_MAX >> (32u - part);
    out->used = n; out->negative = 0; xi_normalize(out);
    return XUB_OK;
}

xub_status xi_slice(xub_int *out, const xub_int *x, size_t offset, size_t bits) {
    size_t total = xub_bit_length(x), first, n;
    unsigned part;
    xub_status status;
    if (out == x) return XUB_EINVAL;
    if (offset >= total || !bits) { out->used = 0; out->negative = 0; return XUB_OK; }
    if (bits > total - offset) bits = total - offset;
    first = offset >> 5; part = (unsigned)(offset & 31u);
    n = (bits >> 5) + ((bits & 31u) != 0);
    status = xi_reserve(out, n);
    if (status != XUB_OK) return status;
    for (size_t i = 0; i < n; ++i) {
        uint32_t v = x->limbs[first + i] >> part;
        if (part && first + i + 1 < x->used)
            v |= x->limbs[first + i + 1] << (32u - part);
        out->limbs[i] = v;
    }
    if (bits & 31u) out->limbs[n - 1] &= UINT32_MAX >> (32u - (unsigned)(bits & 31u));
    out->used = n; out->negative = 0; xi_normalize(out);
    return XUB_OK;
}

xub_status xi_set_bit(xub_int *out, size_t bit) {
    size_t word = bit >> 5, n;
    xub_status status;
    if (word >= XI_MAX_LIMBS) return XUB_ERANGE;
    n = word + 1;
    status = xi_reserve(out, n);
    if (status != XUB_OK) return status;
    if (n > out->used) {
        memset(out->limbs + out->used, 0, (n - out->used) * sizeof(*out->limbs));
        out->used = n;
    }
    out->limbs[word] |= UINT32_C(1) << (unsigned)(bit & 31u);
    out->negative = 0;
    return XUB_OK;
}

xub_status xi_add_shifted(xub_int *out, const xub_int *src, size_t shift, size_t limit) {
    size_t offset, count, end, wanted, cap, old = out->used;
    unsigned part = (unsigned)(shift & 31u);
    uint64_t carry = 0;
    xub_status status;
    int limited = limit != SIZE_MAX;
    if (out == src) return XUB_EINVAL;
    if (limited) {
        status = xi_low(out, out, limit);
        if (status != XUB_OK) return status;
        old = out->used;
        if (!src->used || shift >= limit) return XUB_OK;
        cap = (limit >> 5) + ((limit & 31u) != 0);
    } else {
        if (!src->used) { out->negative = 0; return XUB_OK; }
        cap = XI_MAX_LIMBS;
    }
    offset = shift >> 5;
    if (offset >= cap) return limited ? XUB_OK : XUB_ERANGE;
    count = src->used;
    if (count > cap - offset) {
        if (!limited) return XUB_ERANGE;
        count = cap - offset;
    }
    end = offset + count;
    wanted = old > end ? old : end;
    if (wanted < cap) ++wanted;
    else if (!limited) return XUB_ERANGE;
    status = xi_reserve(out, wanted);
    if (status != XUB_OK) return status;
    if (wanted > old) memset(out->limbs + old, 0, (wanted - old) * sizeof(*out->limbs));
    for (size_t i = 0; i < count; ++i) {
        uint64_t v = ((uint64_t)src->limbs[i] << part) + out->limbs[offset + i] + carry;
        out->limbs[offset + i] = (uint32_t)v; carry = v >> 32;
    }
    if (count == src->used) {
        size_t i = end;
        while (carry && i < wanted) {
            uint64_t v = out->limbs[i] + carry;
            out->limbs[i++] = (uint32_t)v; carry = v >> 32;
        }
    }
    out->used = wanted; out->negative = 0; xi_normalize(out);
    if (limited) return xi_low(out, out, limit);
    return XUB_OK;
}

static unsigned digit_value(unsigned char c) {
    if (c >= '0' && c <= '9') return (unsigned)(c - '0');
    if (c >= 'a' && c <= 'f') return (unsigned)(c - 'a') + 10u;
    if (c >= 'A' && c <= 'F') return (unsigned)(c - 'A') + 10u;
    return 255u;
}

/* Input conversion is repeated shift/add, including decimal scaling by ten. */
static xub_status append_digit(xub_int *x, unsigned base, unsigned digit) {
    size_t n = x->used;
    uint64_t carry = digit;
    xub_status status;
    if (!n && !digit) return XUB_OK;
    if (n >= XI_MAX_LIMBS) return XUB_ERANGE;
    status = xi_reserve(x, n + 1);
    if (status != XUB_OK) return status;
    for (size_t i = 0; i < n; ++i) {
        uint64_t word = x->limbs[i];
        uint64_t v = base == 10 ? (word << 3) + (word << 1) + carry
                               : (word << (base == 16 ? 4 : 1)) + carry;
        x->limbs[i] = (uint32_t)v; carry = v >> 32;
    }
    x->limbs[n] = (uint32_t)carry;
    x->used = n + (carry != 0);
    return XUB_OK;
}

xub_status xub_parse(xub_int *out, const char *text) {
    xub_int t;
    xub_status status = XUB_OK;
    unsigned base = 10;
    int negative = 0;
    const unsigned char *p;
    if (!out || !text || !*text) return XUB_EINVAL;
    p = (const unsigned char *)text;
    if (*p == '+' || *p == '-') { negative = *p == '-'; ++p; }
    if (p[0] == '0' && (p[1] == 'x' || p[1] == 'X' || p[1] == 'b' || p[1] == 'B')) {
        base = (p[1] == 'x' || p[1] == 'X') ? 16u : 2u; p += 2;
    }
    if (!*p) return XUB_EINVAL;
    xub_init(&t);
    while (*p) {
        unsigned digit = digit_value(*p++);
        if (digit >= base) { status = XUB_EINVAL; break; }
        status = append_digit(&t, base, digit);
        if (status != XUB_OK) break;
    }
    if (status == XUB_OK) { t.negative = t.used && negative; xi_swap(out, &t); }
    xub_free(&t);
    return status;
}

/* Presentation only: division by ten is deliberately outside multiplication
 * and square kernels. A compiler may lower this to hardware arithmetic. */
static unsigned divide10(xub_int *x) {
    uint64_t remainder = 0;
    for (size_t i = x->used; i; --i) {
        uint64_t v = (remainder << 32) | x->limbs[i - 1];
        x->limbs[i - 1] = (uint32_t)(v / 10u);
        remainder = v % 10u;
    }
    xi_normalize(x);
    return (unsigned)remainder;
}

char *xub_format(const xub_int *x, unsigned base) {
    static const char digits[] = "0123456789abcdef";
    size_t bits, count, prefix, pos = 0;
    char *result;
    int negative;
    if (!x || (base != 2 && base != 10 && base != 16)) return NULL;
    bits = xub_bit_length(x); negative = bits && x->negative;
    if (base == 10) {
        xub_int t;
        xub_status status;
        count = bits ? bits : 1; /* Conservative decimal digit bound. */
        if (count > SIZE_MAX - 2) return NULL;
        result = malloc(count + 2);
        if (!result) return NULL;
        xub_init(&t); status = xi_copy_mag(&t, x);
        if (status != XUB_OK) { free(result); xub_free(&t); return NULL; }
        if (!t.used) result[pos++] = '0';
        while (t.used) result[pos++] = digits[divide10(&t)];
        if (negative) result[pos++] = '-';
        for (size_t i = 0; i < pos / 2; ++i) {
            char c = result[i]; result[i] = result[pos - 1 - i]; result[pos - 1 - i] = c;
        }
        result[pos] = '\0'; xub_free(&t); return result;
    }
    count = base == 2 ? bits : (bits >> 2) + ((bits & 3u) != 0);
    if (!count) count = 1;
    prefix = 2 + (negative != 0);
    if (count > SIZE_MAX - prefix - 1) return NULL;
    result = malloc(count + prefix + 1);
    if (!result) return NULL;
    if (negative) result[pos++] = '-';
    result[pos++] = '0'; result[pos++] = base == 2 ? 'b' : 'x';
    for (size_t i = count; i; --i) {
        size_t digit = i - 1;
        unsigned value = 0;
        if (x->used) {
            if (base == 2) value = (x->limbs[digit >> 5] >> (unsigned)(digit & 31u)) & 1u;
            else value = (x->limbs[digit >> 3] >> (unsigned)((digit & 7u) << 2)) & 15u;
        }
        result[pos++] = digits[value];
    }
    result[pos] = '\0';
    return result;
}

const char *xub_status_string(xub_status status) {
    switch (status) {
    case XUB_OK: return "success";
    case XUB_ENOMEM: return "allocation failed";
    case XUB_EINVAL: return "invalid argument";
    case XUB_ERANGE: return "range or size overflow";
    case XUB_ECACHE: return "midpoint cache does not match input magnitudes";
    default: return "unknown error";
    }
}
