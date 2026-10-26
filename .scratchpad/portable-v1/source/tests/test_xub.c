#include "xub.h"
#include "xub_internal.h"

#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

static unsigned checks;

#define CHECK(condition) do { ++checks; if (!(condition)) { \
    fprintf(stderr, "%s:%d: %s\n", __FILE__, __LINE__, #condition); \
    exit(1); \
} } while (0)
#define OK(expression) CHECK((expression) == XUB_OK)

static void expect(const xub_int *value, const char *text) {
    xub_int wanted;
    xub_init(&wanted);
    OK(xub_parse(&wanted, text));
    if (xub_compare(value, &wanted)) {
        char *actual = xub_format(value, 16);
        fprintf(stderr, "Expected %s; got %s\n", text, actual ? actual : "<format error>");
        free(actual);
        CHECK(0);
    }
    CHECK(value->used <= value->capacity);
    CHECK(value->used ? value->limbs[value->used - 1] != 0 : !value->negative);
    xub_free(&wanted);
}

static void test_values(void) {
    static const char *invalid[] = {
        "", "+", "-", "0x", "-0X", "0b", "0b2", "0xg", "12a",
        " 1", "1 ", "1\n", "1_000", "1.0", "--1", "+-1"
    };
    static const char *values[] = {
        "0", "-0", "+00000", "1", "-1", "0xABCDEF", "-0b1010101",
        "18446744073709551616", "-340282366920938463463374607431768211457"
    };
    static const unsigned bases[] = {2, 10, 16};
    xub_int x, y;
    int64_t narrowed;
    xub_init(&x); xub_init(&y);
    CHECK(!x.used && !x.capacity && !x.limbs && !x.negative);
    OK(xub_set_i64(&x, -97));
    for (size_t i = 0; i < sizeof invalid / sizeof *invalid; ++i) {
        CHECK(xub_parse(&x, invalid[i]) == XUB_EINVAL);
        expect(&x, "-97");
    }
    for (size_t i = 0; i < sizeof values / sizeof *values; ++i) {
        OK(xub_parse(&x, values[i]));
        for (size_t j = 0; j < sizeof bases / sizeof *bases; ++j) {
            char *text = xub_format(&x, bases[j]);
            CHECK(text != NULL);
            OK(xub_parse(&y, text));
            CHECK(xub_compare(&x, &y) == 0);
            free(text);
        }
        OK(xub_copy(&x, &x));
        OK(xub_copy(&y, &x));
        CHECK(xub_compare(&x, &y) == 0);
    }
    CHECK(xub_format(&x, 3) == NULL);
    OK(xub_set_i64(&x, INT64_MIN));
    expect(&x, "-9223372036854775808");
    OK(xub_get_i64(&x, &narrowed)); CHECK(narrowed == INT64_MIN);
    OK(xub_set_i64(&x, INT64_MAX));
    OK(xub_get_i64(&x, &narrowed)); CHECK(narrowed == INT64_MAX);
    OK(xub_parse(&x, "9223372036854775808"));
    narrowed = 77;
    CHECK(xub_get_i64(&x, &narrowed) == XUB_ERANGE); CHECK(narrowed == 77);
    OK(xub_parse(&x, "-9223372036854775809"));
    CHECK(xub_get_i64(&x, &narrowed) == XUB_ERANGE); CHECK(narrowed == 77);
    OK(xub_set_u64(&x, UINT64_MAX)); expect(&x, "0xffffffffffffffff");
    CHECK(xub_bit_length(&x) == 64);
    OK(xub_parse(&x, "-0x000")); expect(&x, "0");
    CHECK(xub_bit_length(&x) == 0);
    xub_free(&x); xub_free(&y);
}

static void test_primitives(void) {
    xub_int x, y, z;
    xub_init(&x); xub_init(&y); xub_init(&z);
    CHECK(xi_clz32(0) == 32 && xi_ctz32(0) == 32);
    CHECK(xi_clz32(UINT32_C(0x80000000)) == 0);
    CHECK(xi_ctz32(UINT32_C(0x80000000)) == 31);
    CHECK(xi_ctz(&x) == 0);
    OK(xub_parse(&x, "0xffffffffffffffff"));
    OK(xub_set_u64(&y, 1));
    OK(xi_add(&x, &x, &y)); expect(&x, "0x10000000000000000");
    CHECK(xi_ctz(&x) == 64);
    OK(xi_sub(&x, &x, &y)); expect(&x, "0xffffffffffffffff");
    CHECK(xi_popcount_limit(&x, SIZE_MAX) == 64);
    CHECK(xi_popcount_limit(&x, 8) > 8);
    OK(xi_add(&y, &x, &y)); expect(&y, "0x10000000000000000");
    OK(xi_sub(&y, &y, &x)); expect(&y, "1");
    OK(xi_add_u32(&x, &x, 1)); expect(&x, "0x10000000000000000");
    for (size_t shift = 0; shift <= 97; ++shift) {
        OK(xub_set_u64(&x, UINT64_C(0xfedcba9876543210)));
        OK(xi_lshift(&z, &x, shift));
        OK(xi_rshift(&z, &z, shift));
        CHECK(xi_cmp(&x, &z) == 0);
    }
    OK(xub_parse(&x, "0xffffffffffffffffffffffff"));
    OK(xi_low(&y, &x, 0)); expect(&y, "0");
    OK(xi_low(&y, &x, 32)); expect(&y, "0xffffffff");
    OK(xi_low(&x, &x, 33)); expect(&x, "0x1ffffffff");
    OK(xub_parse(&x, "0x123456789abcdef012345678"));
    OK(xi_slice(&z, &x, 32, 32)); expect(&z, "0x9abcdef0");
    OK(xi_slice(&z, &x, 4, 64)); expect(&z, "0x89abcdef01234567");
    OK(xi_rshift(&x, &x, SIZE_MAX)); expect(&x, "0");
    OK(xi_set_bit(&x, 64)); expect(&x, "0x10000000000000000");
    OK(xi_set_bit(&x, 64)); expect(&x, "0x10000000000000000");
    OK(xub_set_u64(&x, 1));
    OK(xub_set_u64(&y, UINT32_MAX));
    OK(xi_add_shifted(&y, &x, 0, 32)); expect(&y, "0");
    OK(xi_add_shifted(&y, &x, SIZE_MAX - 1, 32)); expect(&y, "0");
    OK(xi_add_shifted(&y, &x, 64, SIZE_MAX)); expect(&y, "0x10000000000000000");
    CHECK(xi_reserve(&y, SIZE_MAX) == XUB_ERANGE);
    expect(&y, "0x10000000000000000");
    xub_free(&x); xub_free(&y); xub_free(&z);
}

static void test_products(void) {
    static const char *cases[][3] = {
        {"1000000000", "1", "1000000000"},
        {"67", "68", "4556"}, {"68", "67", "4556"},
        {"-4523", "-3412", "15432476"},
        {"-4523", "3412", "-15432476"},
        {"-9223372036854775808", "-1", "9223372036854775808"},
        {"0", "-12345678901234567890", "0"},
        {"0xffffffffffffffff", "0xffffffffffffffff", "0xfffffffffffffffe0000000000000001"},
        {"0x10000000000000001", "0xffffffffffffffff", "0xffffffffffffffffffffffffffffffff"},
        {"0x100000000000000000000000000000001", "3", "0x300000000000000000000000000000003"},
        {"0x10000000000000001", "0x10000000000000003", "0x100000000000000040000000000000003"}
    };
    xub_int x, y, z;
    xub_context context;
    xub_init(&x); xub_init(&y); xub_init(&z); xub_context_init(&context);
    for (unsigned mode = 0; mode <= XUB_SQUARE_COMPACT; ++mode) {
        context.options.square_mode = (xub_square_mode)mode;
        for (size_t i = 0; i < sizeof cases / sizeof *cases; ++i) {
            OK(xub_parse(&x, cases[i][0])); OK(xub_parse(&y, cases[i][1]));
            OK(xub_mul(&z, &x, &y, &context)); expect(&z, cases[i][2]);
            OK(xub_mul(&x, &x, &y, &context)); expect(&x, cases[i][2]);
            OK(xub_parse(&x, cases[i][0]));
            OK(xub_mul(&y, &x, &y, &context)); expect(&y, cases[i][2]);
        }
        OK(xub_parse(&x, "-0xffffffffffffffff"));
        OK(xub_square(&x, &x, &context));
        expect(&x, "0xfffffffffffffffe0000000000000001");
    }
    xub_free(&x); xub_free(&y); xub_free(&z);
}

static void test_modular_cache(void) {
    xub_int x, y, z, sum;
    xub_context context;
    xub_midpoint_cache cache;
    xub_init(&x); xub_init(&y); xub_init(&z); xub_init(&sum);
    xub_context_init(&context); xub_cache_init(&cache);
    OK(xub_set_i64(&x, -3)); OK(xub_set_i64(&y, 5));
    OK(xub_mul_mod2(&z, &x, &y, 8, &context)); expect(&z, "241");
    OK(xub_mul_mod2(&z, &x, &y, 0, &context)); expect(&z, "0");
    OK(xub_mul_mod2(&z, &x, &y, 1, &context)); expect(&z, "1");
    OK(xub_mul_mod2(&x, &x, &y, 32, &context)); expect(&x, "4294967281");
    OK(xub_set_i64(&x, -3));
    OK(xub_mul_mod2(&y, &x, &y, 33, &context)); expect(&y, "8589934577");
    OK(xub_set_i64(&z, 97));
    CHECK(xub_mul_mod2(&z, &x, &y, SIZE_MAX, &context) == XUB_ERANGE);
    expect(&z, "97");
    CHECK(xub_mul_cached(&z, &x, &y, &cache, &context) == XUB_ECACHE);
    expect(&z, "97");
    OK(xub_set_u64(&sum, 135)); OK(xub_cache_prepare(&cache, &sum, &context));
    OK(xub_set_i64(&x, -67)); OK(xub_set_u64(&y, 68));
    CHECK(xub_mul_cached(&cache.sum, &x, &y, &cache, &context) == XUB_EINVAL);
    expect(&cache.sum, "135");
    CHECK(xub_mul_cached(&cache.midpoint_square, &x, &y, &cache, &context) == XUB_EINVAL);
    OK(xub_mul_cached(&z, &x, &y, &cache, &context)); expect(&z, "-4556");
    OK(xub_mul_cached(&x, &x, &y, &cache, &context)); expect(&x, "-4556");
    OK(xub_set_u64(&x, 66));
    CHECK(xub_mul_cached(&z, &x, &y, &cache, &context) == XUB_ECACHE);
    expect(&z, "-4556");
    OK(xub_set_i64(&sum, -135));
    CHECK(xub_cache_prepare(&cache, &sum, &context) == XUB_EINVAL);
    expect(&cache.sum, "135");
    OK(xub_set_u64(&x, 67));
    OK(xub_mul_cached(&y, &x, &y, &cache, &context)); expect(&y, "4556");
    OK(xub_set_u64(&sum, 0)); OK(xub_cache_prepare(&cache, &sum, &context));
    OK(xub_set_u64(&x, 0)); OK(xub_set_u64(&y, 0));
    OK(xub_mul_cached(&z, &x, &y, &cache, &context)); expect(&z, "0");
    xub_cache_free(&cache);
    xub_free(&x); xub_free(&y); xub_free(&z); xub_free(&sum);
}

static void test_configuration(void) {
    xub_int x, y, z;
    xub_context context;
    xub_options defaults;
    xub_midpoint_cache cache;
    xub_init(&x); xub_init(&y); xub_init(&z);
    xub_context_init(&context); xub_cache_init(&cache);
    defaults = context.options;
    OK(xub_set_u64(&x, 3)); OK(xub_set_u64(&y, 5)); OK(xub_set_u64(&z, 97));
    for (unsigned bad = 0; bad < 5; ++bad) {
        context.options = defaults;
        switch (bad) {
            case 0: context.options.square_mode = (xub_square_mode)99; break;
            case 1: context.options.leaf_bits = 0; break;
            case 2: context.options.leaf_bits = 7; break;
            case 3: context.options.block_ratio = 1; break;
            case 4: context.options.dense_complement = 2; break;
        }
        CHECK(xub_mul(&z, &x, &y, &context) == XUB_EINVAL); expect(&z, "97");
        CHECK(xub_square(&z, &x, &context) == XUB_EINVAL); expect(&z, "97");
        CHECK(xub_mul_mod2(&z, &x, &y, 8, &context) == XUB_EINVAL); expect(&z, "97");
        CHECK(xub_cache_prepare(&cache, &x, &context) == XUB_EINVAL);
        CHECK(xub_mul_cached(&z, &x, &y, &cache, &context) == XUB_EINVAL);
        expect(&z, "97");
    }
    context.options = defaults;
    context.options.block_ratio = 0;
    context.options.sparse_limit = SIZE_MAX;
    context.options.leaf_bits = SIZE_MAX;
    OK(xub_mul(&z, &x, &y, &context)); expect(&z, "15");
    context.options.sparse_limit = 0;
    context.options.leaf_bits = 8;
    context.options.dense_complement = 0;
    OK(xub_mul(&z, &x, &y, &context)); expect(&z, "15");
    xub_cache_free(&cache); xub_free(&x); xub_free(&y); xub_free(&z);
}

static void test_routes(void) {
    xub_int x, y, z;
    xub_context context;
    xub_init(&x); xub_init(&y); xub_init(&z); xub_context_init(&context);
    OK(xub_set_u64(&x, 0)); OK(xub_set_u64(&y, 17));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.zero_products > 0);
    xub_stats_reset(&context); CHECK(context.stats.products == 0);
    OK(xub_set_u64(&x, 1));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.unit_products > 0);
    xub_stats_reset(&context);
    OK(xub_set_u64(&x, 17));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.equal_products > 0);
    xub_stats_reset(&context);
    OK(xub_set_u64(&x, 67)); OK(xub_set_u64(&y, 68));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.adjacent_products > 0);
    xub_stats_reset(&context);
    OK(xub_parse(&x, "0x100000000000000000000000000000001"));
    OK(xub_set_u64(&y, 7));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.blocked_products > 0);
    xub_stats_reset(&context);
    OK(xub_set_u64(&x, 77)); OK(xub_set_u64(&y, 91));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.midpoint_calls > 0);
    xub_stats_reset(&context);
    OK(xub_set_u64(&x, 123));
    OK(xub_square(&z, &x, &context)); CHECK(context.stats.table_squares > 0);
    xub_stats_reset(&context);
    OK(xub_parse(&x, "0xabcd"));
    OK(xub_square(&z, &x, &context)); CHECK(context.stats.basecase_squares > 0);
    xub_stats_reset(&context);
    OK(xub_parse(&x, "0x100000000000000010000000000000001"));
    OK(xub_square(&z, &x, &context)); CHECK(context.stats.sparse_squares > 0);
    xub_stats_reset(&context);
    OK(xub_parse(&x, "0xffffffffffffffffffffffffffffffff"));
    OK(xub_square(&z, &x, &context)); CHECK(context.stats.complement_squares > 0);
    xub_stats_reset(&context);
    context.options.square_mode = XUB_SQUARE_RECURSIVE;
    OK(xub_parse(&x, "0x123456789abcdef1123456789abcdef1"));
    OK(xub_square(&z, &x, &context)); CHECK(context.stats.recursive_squares > 0);
    CHECK(context.stats.reused_squares > 0);
    xub_stats_reset(&context);
    context.options.square_mode = XUB_SQUARE_COMPACT;
    OK(xub_square(&z, &x, &context)); CHECK(context.stats.compact_squares > 0);
    xub_stats_reset(&context);
    context.options.square_mode = XUB_SQUARE_AUTO;
    OK(xub_set_u64(&x, 24)); OK(xub_set_u64(&y, 40));
    OK(xub_mul(&z, &x, &y, &context)); CHECK(context.stats.shifted_products > 0);
    xub_stats_reset(&context);
    OK(xub_parse(&x, "0x10000000000000000000000000000000000000000000000000000000000000011"));
    OK(xub_parse(&y, "0x10000000000000000000000000000000000000000000000000000000000000036"));
    OK(xub_mul(&z, &x, &y, &context));
    /* Independent Python-integer reference for (2^256+17)*(2^256+54). */
    expect(&z, "0x100000000000000000000000000000000000000000000000000000000000000470000000000000000000000000000000000000000000000000000000000000396");
    CHECK(context.stats.shifted_products == 0);
    CHECK(context.stats.midpoint_calls > 0);
    xub_free(&x); xub_free(&y); xub_free(&z);
}

int main(void) {
    test_values(); test_primitives(); test_products();
    test_modular_cache(); test_configuration(); test_routes();
    printf("C API tests passed (%u checks).\n", checks);
    return 0;
}
