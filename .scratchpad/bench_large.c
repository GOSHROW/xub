/* Benchmark-only prototype: exact midpoint multiplication on OpenSSL BIGNUM.
 * All software candidates use shifts/additions/subtractions and S[0..255].
 * BN_mul/BN_sqr appear only in named native controls and correctness oracles.
 * Compile instructions and measurement limitations are emitted with --help.
 */
#define _POSIX_C_SOURCE 200809L
#include <openssl/bn.h>
#include <openssl/crypto.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define REQUIRE(x) do { if (!(x)) { fprintf(stderr, "failure line %d: %s\n", __LINE__, #x); abort(); } } while (0)
#define NOINLINE __attribute__((noinline))
#define NSAMPLES 8
#define NTRIALS 5
#ifndef SCALAR_LEAF_BITS
#define SCALAR_LEAF_BITS 8
#endif
#if SCALAR_LEAF_BITS != 8 && SCALAR_LEAF_BITS != 32
#error "SCALAR_LEAF_BITS must be 8 or 32"
#endif
#if SCALAR_LEAF_BITS == 32
_Static_assert(sizeof(BN_ULONG) >= sizeof(uint64_t), "32-bit leaves need 64-bit BN_ULONG");
#endif

typedef void (*square_fn)(BIGNUM *, const BIGNUM *, BN_CTX *);
typedef void (*product_fn)(BIGNUM *, const BIGNUM *, const BIGNUM *, BN_CTX *);
static uint16_t squares[256];
static uint64_t rng_state = UINT64_C(0x8f1bbcde58425531);
static volatile uint64_t sink;

static uint64_t random_u64(void) {
    uint64_t x = rng_state;
    x ^= x << 13; x ^= x >> 7; x ^= x << 17;
    return rng_state = x;
}
static uint64_t now_ns(void) {
    struct timespec t;
    REQUIRE(clock_gettime(CLOCK_MONOTONIC, &t) == 0);
    return (uint64_t)t.tv_sec * UINT64_C(1000000000) + (uint64_t)t.tv_nsec;
}
static void init_table(void) {
    unsigned value = 0, odd = 1;
    for (unsigned i = 0; i < 256; ++i) {
        squares[i] = (uint16_t)value;
        value += odd; odd += 2;
    }
}
static BIGNUM *temp(BN_CTX *ctx) {
    BIGNUM *v = BN_CTX_get(ctx); REQUIRE(v != NULL); return v;
}
static void low_bits(BIGNUM *out, const BIGNUM *x, int n) {
    REQUIRE(BN_copy(out, x));
    if (BN_num_bits(out) > n) REQUIRE(BN_mask_bits(out, n));
}
static int abs_difference(BIGNUM *out, const BIGNUM *x, const BIGNUM *y) {
    int sign = BN_cmp(x, y);
    REQUIRE(sign >= 0 ? BN_sub(out, x, y) : BN_sub(out, y, x));
    return sign < 0;
}

#if SCALAR_LEAF_BITS == 32
static NOINLINE uint64_t scalar_square32(uint32_t x) {
    if (x < 256) return squares[x];
    unsigned r = (32u - (unsigned)__builtin_clz(x)) >> 1;
    uint32_t hi = x >> r, lo = x & ((UINT32_C(1) << r) - 1);
    uint32_t diff = hi >= lo ? hi - lo : lo - hi;
    uint64_t u = scalar_square32(hi), v = scalar_square32(lo), w = scalar_square32(diff);
    return (u << (r+r)) + ((u+v-w) << r) + v;
}
static NOINLINE uint64_t scalar_product32(uint32_t x, uint32_t y) {
    /* Scan the smaller magnitude's set bits; every shift fits in uint64_t. */
    if (x < y) { uint32_t t=x; x=y; y=t; }
    uint64_t out=0;
    while (y) {
        unsigned i=(unsigned)__builtin_ctz(y);
        out += (uint64_t)x << i;
        y &= y-1;
    }
    return out;
}
#endif

static NOINLINE void square_prefix(BIGNUM *out, const BIGNUM *x, BN_CTX *ctx) {
    BN_CTX_start(ctx);
    BIGNUM *prefix = temp(ctx), *row = temp(ctx);
    REQUIRE(BN_set_word(prefix, 0)); REQUIRE(BN_set_word(out, 0));
    for (int i = BN_num_bits(x) - 1; i >= 0; --i) {
        int bit = BN_is_bit_set(x, i);
        REQUIRE(BN_lshift(out, out, 2));
        if (bit) {
            REQUIRE(BN_lshift(row, prefix, 2));
            REQUIRE(BN_add_word(row, 1)); REQUIRE(BN_add(out, out, row));
        }
        REQUIRE(BN_lshift1(prefix, prefix));
        if (bit) REQUIRE(BN_add_word(prefix, 1));
    }
    BN_CTX_end(ctx);
}

static NOINLINE void square_set_bits(BIGNUM *out, const BIGNUM *x, BN_CTX *ctx) {
    BN_CTX_start(ctx);
    BIGNUM *remaining = temp(ctx), *row = temp(ctx);
    REQUIRE(BN_copy(remaining, x)); REQUIRE(BN_set_word(out, 0));
    /* Public BIGNUM has no ctz iterator: scan n bit positions, add s rows. */
    for (int i = 0, n = BN_num_bits(x); i < n; ++i) {
        if (!BN_is_bit_set(x, i)) continue;
        REQUIRE(BN_clear_bit(remaining, i));
        REQUIRE(BN_lshift(row, remaining, i + 1));
        REQUIRE(BN_set_bit(row, i + i)); /* diagonal is disjoint from tail */
        REQUIRE(BN_add(out, out, row));
    }
    BN_CTX_end(ctx);
}

static NOINLINE void square_recursive(BIGNUM *out, const BIGNUM *x, BN_CTX *ctx) {
    int n = BN_num_bits(x);
    if (n <= 8) { REQUIRE(BN_set_word(out, squares[BN_get_word(x)])); return; }
#if SCALAR_LEAF_BITS == 32
    if (n <= 32) { REQUIRE(BN_set_word(out, scalar_square32((uint32_t)BN_get_word(x)))); return; }
#endif
    int r = n >> 1;
    BN_CTX_start(ctx);
    BIGNUM *hi = temp(ctx), *lo = temp(ctx), *diff = temp(ctx);
    BIGNUM *u = temp(ctx), *v = temp(ctx), *w = temp(ctx), *cross = temp(ctx);
    REQUIRE(BN_rshift(hi, x, r)); low_bits(lo, x, r);
    abs_difference(diff, hi, lo);
    square_recursive(u, hi, ctx); square_recursive(v, lo, ctx);
    square_recursive(w, diff, ctx);
    REQUIRE(BN_add(cross, u, v)); REQUIRE(BN_sub(cross, cross, w));
    REQUIRE(BN_lshift(out, u, r + r)); REQUIRE(BN_lshift(cross, cross, r));
    REQUIRE(BN_add(out, out, cross)); REQUIRE(BN_add(out, out, v));
    BN_CTX_end(ctx);
}

static void square_native(BIGNUM *out, const BIGNUM *x, BN_CTX *ctx) {
    REQUIRE(BN_sqr(out, x, ctx));
}

static NOINLINE void midpoint(BIGNUM *out, const BIGNUM *x, const BIGNUM *y,
                              BN_CTX *ctx, square_fn square) {
    const BIGNUM *a = x, *b = y;
    if (BN_cmp(a, b) > 0) { a = y; b = x; }
    BN_CTX_start(ctx);
    BIGNUM *delta = temp(ctx), *d = temp(ctx), *h = temp(ctx), *dsq = temp(ctx);
    REQUIRE(BN_sub(delta, b, a));
    int odd = BN_is_odd(delta);
    REQUIRE(BN_rshift1(d, delta)); REQUIRE(BN_add(h, a, d));
    square(out, h, ctx); square(dsq, d, ctx);
    REQUIRE(BN_sub(out, out, dsq));
    if (odd) REQUIRE(BN_add(out, out, a));
    BN_CTX_end(ctx);
}
#define MIDPOINT_WRAPPER(name, sq) \
static NOINLINE void name(BIGNUM *o, const BIGNUM *x, const BIGNUM *y, BN_CTX *c) { midpoint(o,x,y,c,sq); }
MIDPOINT_WRAPPER(mid_prefix, square_prefix)
MIDPOINT_WRAPPER(mid_set_bits, square_set_bits)
MIDPOINT_WRAPPER(mid_recursive, square_recursive)
MIDPOINT_WRAPPER(mid_native_square, square_native)

static unsigned count_bits(const BIGNUM *x) {
    unsigned count = 0;
    for (int i = 0, n = BN_num_bits(x); i < n; ++i) count += BN_is_bit_set(x, i);
    return count;
}
static void shift_add_selected(BIGNUM *out, const BIGNUM *value,
                               const BIGNUM *bits, BN_CTX *ctx) {
    BN_CTX_start(ctx); BIGNUM *row = temp(ctx);
    REQUIRE(BN_set_word(out, 0));
    for (int i = 0, n = BN_num_bits(bits); i < n; ++i) {
        if (!BN_is_bit_set(bits, i)) continue;
        REQUIRE(BN_lshift(row, value, i)); REQUIRE(BN_add(out, out, row));
    }
    BN_CTX_end(ctx);
}
static NOINLINE void shift_add_short(BIGNUM *out, const BIGNUM *x,
                                    const BIGNUM *y, BN_CTX *ctx) {
    if (BN_num_bits(x) < BN_num_bits(y)) shift_add_selected(out, y, x, ctx);
    else shift_add_selected(out, x, y, ctx);
}
static NOINLINE void shift_add_sparse(BIGNUM *out, const BIGNUM *x,
                                     const BIGNUM *y, BN_CTX *ctx) {
    if (count_bits(x) < count_bits(y)) shift_add_selected(out, y, x, ctx);
    else shift_add_selected(out, x, y, ctx);
}

static NOINLINE void direct_karatsuba(BIGNUM *out, const BIGNUM *x,
                                     const BIGNUM *y, BN_CTX *ctx) {
    int nx = BN_num_bits(x), ny = BN_num_bits(y);
    if (!nx || !ny) { REQUIRE(BN_set_word(out, 0)); return; }
    if (nx <= 8 && ny <= 8) {
        unsigned a = (unsigned)BN_get_word(x), b = (unsigned)BN_get_word(y);
        if (a > b) { unsigned t = a; a = b; b = t; }
        unsigned delta = b-a, d = delta >> 1, h = a+d;
        REQUIRE(BN_set_word(out, squares[h]-squares[d]+((delta&1) ? a : 0)));
        return;
    }
#if SCALAR_LEAF_BITS == 32
    if (nx <= 32 && ny <= 32) {
        REQUIRE(BN_set_word(out, scalar_product32((uint32_t)BN_get_word(x),(uint32_t)BN_get_word(y))));
        return;
    }
#endif
    if (nx <= 8 || ny <= 8) { shift_add_short(out, x, y, ctx); return; }
    int r = (nx > ny ? nx : ny) >> 1;
    BN_CTX_start(ctx);
    BIGNUM *xh = temp(ctx), *xl = temp(ctx), *yh = temp(ctx), *yl = temp(ctx);
    BIGNUM *xd = temp(ctx), *yd = temp(ctx), *u = temp(ctx), *v = temp(ctx);
    BIGNUM *w = temp(ctx), *cross = temp(ctx);
    REQUIRE(BN_rshift(xh, x, r)); low_bits(xl, x, r);
    REQUIRE(BN_rshift(yh, y, r)); low_bits(yl, y, r);
    int sign = abs_difference(xd, xh, xl) ^ abs_difference(yd, yh, yl);
    direct_karatsuba(u, xh, yh, ctx); direct_karatsuba(v, xl, yl, ctx);
    direct_karatsuba(w, xd, yd, ctx);
    REQUIRE(BN_add(cross, u, v));
    REQUIRE(sign ? BN_add(cross, cross, w) : BN_sub(cross, cross, w));
    REQUIRE(BN_lshift(out, u, r+r)); REQUIRE(BN_lshift(cross, cross, r));
    REQUIRE(BN_add(out, out, cross)); REQUIRE(BN_add(out, out, v));
    BN_CTX_end(ctx);
}
static NOINLINE void native_mul(BIGNUM *out, const BIGNUM *x,
                               const BIGNUM *y, BN_CTX *ctx) {
    REQUIRE(BN_mul(out, x, y, ctx));
}
static NOINLINE void native_equal_aware(BIGNUM *out, const BIGNUM *x,
                                       const BIGNUM *y, BN_CTX *ctx) {
    if (BN_cmp(x,y) == 0) REQUIRE(BN_sqr(out,x,ctx));
    else REQUIRE(BN_mul(out,x,y,ctx));
}
static NOINLINE void recursive_equal_aware(BIGNUM *out, const BIGNUM *x,
                                          const BIGNUM *y, BN_CTX *ctx) {
    if (BN_cmp(x,y) == 0) square_recursive(out,x,ctx);
    else direct_karatsuba(out,x,y,ctx);
}
static void near_identity(BIGNUM *out, const BIGNUM *x, const BIGNUM *y,
                          BN_CTX *ctx, int native) {
    const BIGNUM *a = x, *b = y;
    if (BN_cmp(a,b) > 0) { a=y; b=x; }
    BN_CTX_start(ctx); BIGNUM *delta=temp(ctx), *cross=temp(ctx);
    REQUIRE(BN_sub(delta,b,a));
    if (native) {
        REQUIRE(BN_sqr(out,a,ctx)); REQUIRE(BN_mul(cross,a,delta,ctx));
    } else {
        square_recursive(out,a,ctx); shift_add_short(cross,a,delta,ctx);
    }
    REQUIRE(BN_add(out,out,cross)); BN_CTX_end(ctx);
}
static NOINLINE void near_native(BIGNUM *o,const BIGNUM *x,const BIGNUM *y,BN_CTX *c) { near_identity(o,x,y,c,1); }
static NOINLINE void near_recursive(BIGNUM *o,const BIGNUM *x,const BIGNUM *y,BN_CTX *c) { near_identity(o,x,y,c,0); }
static NOINLINE void copy_control(BIGNUM *out,const BIGNUM *x,const BIGNUM *y,BN_CTX *ctx) {
    (void)y; (void)ctx; REQUIRE(BN_copy(out,x));
}

struct algorithm { const char *name; product_fn fn; int near_only; int control; };
static const struct algorithm algorithms[] = {
    {"copy_control",copy_control,0,1},
    {"native_mul",native_mul,0,0},
    {"native_equal_aware",native_equal_aware,0,0},
    {"mid_native_square",mid_native_square,0,0},
    {"shift_add_short",shift_add_short,0,0},
    {"shift_add_sparse",shift_add_sparse,0,0},
    {"direct_karatsuba",direct_karatsuba,0,0},
    {"recursive_equal_aware",recursive_equal_aware,0,0},
    {"mid_recursive",mid_recursive,0,0},
    {"mid_set_bits",mid_set_bits,0,0},
    {"mid_prefix",mid_prefix,0,0},
    {"near_native",near_native,1,0},
    {"near_recursive",near_recursive,1,0}
};
#define NALG (sizeof(algorithms)/sizeof(algorithms[0]))
static const char *patterns[] = {"random","near","equal","sparse","dense","short8","one","power2"};
#define NPAT (sizeof(patterns)/sizeof(patterns[0]))
struct pair { BIGNUM *x; BIGNUM *y; };
static void random_bits(BIGNUM *x, int bits) {
    int n = (bits+7)>>3;
    unsigned char *buf = malloc((size_t)n); REQUIRE(buf);
    for (int i=0;i<n;++i) buf[i]=(unsigned char)random_u64();
    buf[0] &= (unsigned char)(255u >> ((8-(bits&7))&7));
    buf[0] |= (unsigned char)(1u << ((bits-1)&7));
    REQUIRE(BN_bin2bn(buf,n,x)); free(buf);
}
static void make_pair(struct pair *p,int bits,unsigned pattern) {
    p->x=BN_new(); p->y=BN_new(); REQUIRE(p->x && p->y);
    random_bits(p->x,bits); random_bits(p->y,bits);
    switch(pattern) {
    case 1: /* keep +delta within width */
        REQUIRE(BN_clear_bit(p->x,8)); REQUIRE(BN_copy(p->y,p->x));
        REQUIRE(BN_add_word(p->y,1+(random_u64()%255))); break;
    case 2: REQUIRE(BN_copy(p->y,p->x)); break;
    case 3:
        REQUIRE(BN_set_word(p->x,1)); REQUIRE(BN_set_word(p->y,1));
        REQUIRE(BN_set_bit(p->x,bits-1)); REQUIRE(BN_set_bit(p->y,bits-1));
        REQUIRE(BN_set_bit(p->x,(int)(random_u64()%(unsigned)(bits-2))+1));
        REQUIRE(BN_set_bit(p->y,(int)(random_u64()%(unsigned)(bits-2))+1)); break;
    case 4:
        REQUIRE(BN_set_word(p->x,0)); REQUIRE(BN_set_bit(p->x,bits));
        REQUIRE(BN_sub_word(p->x,1)); REQUIRE(BN_copy(p->y,p->x));
        REQUIRE(BN_clear_bit(p->x,(int)(random_u64()%(unsigned)(bits-1))));
        REQUIRE(BN_clear_bit(p->y,(int)(random_u64()%(unsigned)(bits-1)))); break;
    case 5: REQUIRE(BN_set_word(p->y,128+(random_u64()&127))); break;
    case 6: REQUIRE(BN_set_word(p->y,1)); break;
    case 7:
        REQUIRE(BN_set_word(p->x,0)); REQUIRE(BN_set_bit(p->x,bits-1));
        REQUIRE(BN_set_word(p->y,0)); REQUIRE(BN_set_bit(p->y,bits/2)); break;
    default: break;
    }
}
static int eligible(unsigned a,unsigned pattern,int bits) {
    if (algorithms[a].near_only && pattern != 1 && pattern != 2) return 0;
    /* Keep optional 16K run bounded: native and subquadratic candidates only. */
    if (bits>4096 && (a==4 || a==5 || a==9 || a==10)) return 0;
    return 1;
}
static void verify_pair(const struct pair *p,BN_CTX *ctx) {
    BIGNUM *expected=BN_new(),*out=BN_new(); REQUIRE(expected && out);
    REQUIRE(BN_mul(expected,p->x,p->y,ctx));
    for(unsigned a=0;a<NALG;++a) {
        if(algorithms[a].control) continue;
        algorithms[a].fn(out,p->x,p->y,ctx);
        if(BN_cmp(out,expected)!=0) {
            char *x=BN_bn2hex(p->x),*y=BN_bn2hex(p->y),*got=BN_bn2hex(out),*want=BN_bn2hex(expected);
            fprintf(stderr,"mismatch %s x=%s y=%s got=%s expected=%s\n",algorithms[a].name,x,y,got,want); abort();
        }
    }
    BN_free(expected); BN_free(out);
}
static void verify_all(int maxbits) {
    BN_CTX *ctx=BN_CTX_new(); REQUIRE(ctx);
    struct pair p={BN_new(),BN_new()}; REQUIRE(p.x && p.y);
    unsigned count=0;
#if SCALAR_LEAF_BITS == 32
    /* Restore the generator so both leaf widths benchmark identical datasets. */
    uint64_t saved_rng=rng_state;
    for (uint32_t v=0;v<65536;++v) REQUIRE(scalar_square32(v)==(uint64_t)v*v);
    for (unsigned i=0;i<10000;++i) {
        uint32_t x=(uint32_t)random_u64(), y=(uint32_t)random_u64();
        REQUIRE(scalar_square32(x)==(uint64_t)x*x);
        REQUIRE(scalar_product32(x,y)==(uint64_t)x*y);
    }
    REQUIRE(scalar_square32(UINT32_MAX)==(uint64_t)UINT32_MAX*UINT32_MAX);
    REQUIRE(scalar_product32(UINT32_MAX,UINT32_MAX)==(uint64_t)UINT32_MAX*UINT32_MAX);
    rng_state=saved_rng;
    fprintf(stderr,"verified scalar leaves: 65536 small squares, 10000 random32 squares/products, UINT32_MAX boundaries\n");
#endif
    /* Exhaustive 8-bit leaf rule, and selected 8-bit values through all APIs. */
    for(unsigned x=0;x<256;++x) for(unsigned y=0;y<256;++y) {
        unsigned a=x<y?x:y,b=x<y?y:x,d=(b-a)>>1,h=a+d;
        REQUIRE((unsigned)(squares[h]-squares[d]+(((b-a)&1)?a:0)) == x*y);
    }
    const unsigned edge[]={0,1,2,3,7,8,15,16,127,128,255,256,257,65535,65536};
    for(unsigned i=0;i<sizeof(edge)/sizeof(edge[0]);++i) for(unsigned j=0;j<sizeof(edge)/sizeof(edge[0]);++j) {
        REQUIRE(BN_set_word(p.x,edge[i])); REQUIRE(BN_set_word(p.y,edge[j]));
        verify_pair(&p,ctx); ++count;
    }
    BN_free(p.x); BN_free(p.y);
    const int widths[]={31,32,33,63,64,65,127,128,129,256,511,1024,4096};
    for(unsigned w=0;w<sizeof(widths)/sizeof(widths[0]);++w) {
        if(widths[w]>maxbits) continue;
        for(unsigned pattern=0;pattern<NPAT;++pattern) for(unsigned j=0;j<2;++j) {
            make_pair(&p,widths[w],pattern); verify_pair(&p,ctx); ++count;
            BN_free(p.x); BN_free(p.y);
        }
    }
    BN_CTX_free(ctx);
    fprintf(stderr,"verified 65536 table products and %u BIGNUM pairs across all %zu product algorithms\n",count,NALG-1);
}

static double run_batch(product_fn fn,struct pair *pairs,unsigned repetitions,
                         BN_CTX *ctx,BIGNUM *out) {
    uint64_t check=0,begin=now_ns();
    for(unsigned rep=0;rep<repetitions;++rep) for(unsigned i=0;i<NSAMPLES;++i) {
        fn(out,pairs[i].x,pairs[i].y,ctx);
        check += (uint64_t)BN_num_bits(out);
    }
    uint64_t end=now_ns(); sink ^= check;
    return (double)(end-begin);
}
static int cmp_double(const void *a,const void *b) {
    double x=*(const double *)a,y=*(const double *)b; return (x>y)-(x<y);
}
static void measure(FILE *file,int maxbits,double target_ms) {
    const int widths[]={64,256,1024,4096,16384};
    BN_CTX *ctx=BN_CTX_new(); BIGNUM *out=BN_new(); REQUIRE(ctx && out);
    fprintf(file,"bits,pattern,algorithm,samples,repetitions,trials,median_ns,min_ns,max_ns\n");
    for(unsigned w=0;w<sizeof(widths)/sizeof(widths[0]);++w) {
        int bits=widths[w]; if(bits>maxbits) continue;
        for(unsigned pattern=0;pattern<NPAT;++pattern) {
            struct pair pairs[NSAMPLES];
            for(unsigned i=0;i<NSAMPLES;++i) {
                make_pair(&pairs[i],bits,pattern);
                /* Native oracle validates all measured methods, outside timing. */
                BIGNUM *expected=BN_new(); REQUIRE(expected);
                REQUIRE(BN_mul(expected,pairs[i].x,pairs[i].y,ctx));
                for(unsigned a=0;a<NALG;++a) if(eligible(a,pattern,bits)) {
                    algorithms[a].fn(out,pairs[i].x,pairs[i].y,ctx);
                    if(!algorithms[a].control) REQUIRE(BN_cmp(out,expected)==0);
                }
                BN_free(expected);
            }
            unsigned reps[NALG]; double times[NALG][NTRIALS];
            for(unsigned a=0;a<NALG;++a) {
                reps[a]=1; if(!eligible(a,pattern,bits)) continue;
                double elapsed;
                do {
                    elapsed=run_batch(algorithms[a].fn,pairs,reps[a],ctx,out);
                    if(elapsed>=1000000.0 || reps[a]>=524288) break;
                    reps[a]<<=1;
                } while(1);
                double desired=(double)reps[a]*target_ms*1000000.0/(elapsed>0?elapsed:1);
                reps[a]=desired>1 ? (unsigned)(desired+1) : 1;
                if(reps[a]>1000000) reps[a]=1000000;
            }
            for(unsigned trial=0;trial<NTRIALS;++trial) {
                unsigned order[NALG]; for(unsigned a=0;a<NALG;++a) order[a]=a;
                for(unsigned a=NALG-1;a>0;--a) { unsigned j=(unsigned)(random_u64()%(a+1)); unsigned t=order[a];order[a]=order[j];order[j]=t; }
                for(unsigned j=0;j<NALG;++j) {
                    unsigned a=order[j]; if(!eligible(a,pattern,bits)) continue;
                    double elapsed=run_batch(algorithms[a].fn,pairs,reps[a],ctx,out);
                    times[a][trial]=elapsed/((double)reps[a]*NSAMPLES);
                }
            }
            for(unsigned a=0;a<NALG;++a) {
                if(!eligible(a,pattern,bits)) continue;
                qsort(times[a],NTRIALS,sizeof(double),cmp_double);
                fprintf(file,"%d,%s,%s,%d,%u,%d,%.3f,%.3f,%.3f\n",bits,patterns[pattern],algorithms[a].name,NSAMPLES,reps[a],NTRIALS,times[a][NTRIALS/2],times[a][0],times[a][NTRIALS-1]);
            }
            fflush(file);
            for(unsigned i=0;i<NSAMPLES;++i) { BN_free(pairs[i].x);BN_free(pairs[i].y); }
            fprintf(stderr,"finished bits=%d pattern=%s\n",bits,patterns[pattern]);
        }
    }
    BN_free(out); BN_CTX_free(ctx);
    fprintf(stderr,"observable checksum=%llu\n",(unsigned long long)sink);
}
int main(int argc,char **argv) {
    int verify_only=0,maxbits=4096; double target_ms=5.0; const char *output=NULL;
    for(int i=1;i<argc;++i) {
        if(!strcmp(argv[i],"--verify-only")) verify_only=1;
        else if(!strcmp(argv[i],"--max-bits") && i+1<argc) maxbits=atoi(argv[++i]);
        else if(!strcmp(argv[i],"--target-ms") && i+1<argc) target_ms=atof(argv[++i]);
        else if(!strcmp(argv[i],"--output") && i+1<argc) output=argv[++i];
        else {
            fprintf(stderr,"Usage: %s [--verify-only] [--max-bits 4096|16384] [--target-ms 5] [--output results.csv]\n",argv[0]);
            return !strcmp(argv[i],"--help")?0:2;
        }
    }
    REQUIRE(maxbits>=64 && maxbits<=16384 && target_ms>=1 && target_ms<=100);
    fprintf(stderr,"%s\ncompiler=%s\nseed=0x8f1bbcde58425531, trials=%d, samples=%d, target_ms=%.3f\n",OpenSSL_version(OPENSSL_VERSION),__VERSION__,NTRIALS,NSAMPLES,target_ms);
    fprintf(stderr,"scalar_leaf_bits=%d; square_table_entries=256; table_bytes=%zu\n",SCALAR_LEAF_BITS,sizeof(squares));
    fprintf(stderr,"Prototype uses shared OpenSSL BIGNUM primitives and reusable BN_CTX; API overhead is included. Warm tables/allocations. CPU frequency and core affinity are uncontrolled.\n");
    init_table(); verify_all(maxbits);
    if(verify_only) return 0;
    FILE *file=output?fopen(output,"w"):stdout; REQUIRE(file);
    measure(file,maxbits,target_ms);
    if(output) REQUIRE(fclose(file)==0);
    return 0;
}
