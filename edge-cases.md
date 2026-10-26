# Edge cases and signed inputs

This extends the natural-number core to exact signed integers by separating
sign and magnitude. The arithmetic identity remains unchanged. These are
correctness results and proposed shortcut rules; earlier native performance
measurements are unchanged.

## Common representation and formula

Record whether exactly one original input is negative, then work with

\[
a=\min(|x|,|y|),\quad b=\max(|x|,|y|),\quad
\Delta=b-a,\quad d=\Delta\gg1,\quad h=a+d,\quad p=\Delta\mathbin{\&}1.
\]

The magnitude is h^2-d^2 plus a if p=1. Apply the recorded sign only to a nonzero
magnitude. A zero result has a canonical nonnegative sign. Exact integer inputs
are the current scope; floating-point approximations are unnecessary.

## The requested examples

### 1,000,000,000 times 1

Here a=1, b=1,000,000,000, h=500,000,000, d=499,999,999 and p=1.
The literal formula gives

\[
250{,}000{,}000{,}000{,}000{,}000
-249{,}999{,}999{,}000{,}000{,}001+1
=1{,}000{,}000{,}000.
\]

This is a performance edge case: the magnitude is already the other operand.
It can be simplified inside the common difference evaluator because h=d+1:

\[
D(d+1,d)=(d+1)^2-d^2=2d+1.
\]

The final parity correction gives 2d+2. The new scratch edge-case evaluator
performs no square calls for this example.

Interpreting the unprefixed input as decimal, its result needs 30 magnitude
bits but the literal exact square h^2 needs 58. If `1000000000` was intended
as binary, it represents 512, and the same unit rule gives 512. Both cases are
included in the checks.

### 67 times 68

a=67, b=68, h=67, d=0 and p=1, so

\[
67\cdot68=67^2+67=4489+67=\boxed{4556}.
\]

Only one square is needed. Omitting the parity correction would incorrectly
return 4489. In general consecutive magnitudes a and a+1 give S(a)+a.
Reversing the operands changes nothing.

### -4523 times -3412

Both signs are negative, so the output is nonnegative. Use magnitudes
a=3412 and b=4523. Then delta=1111, h=3967, d=555 and p=1:

\[
3967^2-555^2+3412
=15{,}737{,}089-308{,}025+3412
=\boxed{15{,}432{,}476}.
\]

Exactly one negative input gives -15,432,476. The square evaluator never needs
negative original operands or right shifts of negative input values.

## Edge-case matrix

| Case | Exact behavior or rule | What it exercises |
|---|---|---|
| 0 times anything | 0; normalize the sign | Empty magnitude, zero bit length, zero chunk width, bit-scan guards |
| 1 or -1 times x | x or -x | Avoid two large squares; retain sign and range correctly |
| Equal magnitudes a,a | S(a), with the appropriate sign | d=0, one useful square |
| Consecutive magnitudes a,a+1 | S(a)+a | d=0 and the odd-parity correction |
| Magnitudes a,a+2 | S(a+1)-1 | Small nonzero difference square |
| Both even / both odd | p=0 | Integral midpoint, no correction |
| Exactly one odd | p=1 | Half-integer cancellation and remaining integer correction |
| Reversed magnitude order | Same magnitude result | Unsigned subtraction must follow magnitude ordering |
| All four input sign combinations | Sign XOR; zero stays nonnegative | Separation of sign from magnitude |
| Power-of-two factors | Factor shifts, then use reduced core | Avoid unnecessary square work; large shift counts |
| Short factor times long factor | Exact result; blocked core is a prospective fast path | Length imbalance and disproportionate square temporaries |
| 255/256 and 65535/65536 | Respect each table's exact index limit | First value outside a lookup range |
| (2^w-1)^2 | 2^(2w)-2^(w+1)+1 | Long carry and borrow chains |
| (2^w-1)(2^w+1) | 2^(2w)-1 | Word-boundary growth and dense result |
| Minimum signed input | Keep magnitude in unsigned or arbitrary-width storage | Unrepresentable positive magnitude in the original signed type |
| Minimum signed input times -1 | Exact positive magnitude, possibly wider signed result | A valid integer result need not fit the input's signed type |
| Dense complement at a power of two | r=z; do not recursively repeat unchanged | Termination of the proposed complement shortcut |
| Positive fused D with negative child differences | Preserve signs, or use a proven residue representation | Intermediate signs do not follow the final sign |

The zero test must precede any chunk-width calculation or bit scan that requires
a nonzero input. The existing chunk prototype already returns for a zero smaller
factor; otherwise k=0 would make its chunk-removal loop fail to advance.

For an eight-bit square table, h<=max(a,b)<=255, so its maximum lookup is safe.
For an eight-bit quarter-square table the sum index reaches 510. The input value
256 must take a larger or recursive path, not index the 256-entry square table.

## Signed limits and native representation

Examples for signed 64-bit inputs:

\[
(-2^{63})(-1)=2^{63},\qquad (-2^{63})(-2^{63})=2^{126}.
\]

The first result does not fit signed 64-bit storage; both are valid arbitrary-
precision results. Restoring a sign and narrowing a result are separate actions.

For the C11 port, do not obtain a minimum signed magnitude through signed
negation or `abs`. Convert to the corresponding unsigned type first and use
unsigned subtraction from zero for negative inputs. Guard shift counts against
the promoted operand width, and do not directly left-shift negative signed
intermediates. Small integer types may undergo promotions before arithmetic.
These native-language constraints follow C11 sections 6.3.1.3, 6.5.7 and
7.22.6.1. [WG14 N1570](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf)

The scratch suite models unsigned magnitude conversion and exact integer
results. Native validation is now provided separately by the portable C API
suite and Python-driven CLI oracle; see the follow-through section below.

## Full squares versus deliberately truncated squares

If full exact squares are materialized, allocate for them rather than merely
for the final product. For example, 1 times (2^64-1) has a 64-bit result but
its midpoint square has 127 bits. Generic product-length allocation alone is
insufficient for that full-square implementation.

There is an exact alternative worth recording. Choose L so the product magnitude
is known to be less than 2^L. For nonzero inputs, bits(a)+bits(b) is sufficient.
Then

\[
\boxed{ab=\big((S(h)\bmod2^L)-(S(d)\bmod2^L)+pa\big)\bmod2^L.}
\]

All midpoint preprocessing is performed exactly before this reduction. The
subsequent arithmetic is polynomial in the square results, so reducing modulo
2^L preserves the product residue. The proven result bound makes that residue
the exact product. Signed inputs apply their sign after reconstructing this
exact magnitude.

Thus unsigned intermediate wrap can be intentional and correct. It must not be
confused with signed overflow or with returning an insufficiently wide final
residue. For 10^9 times 1, a deliberately 32-bit modular implementation obtains
square residues 3,923,312,640 and 2,923,312,641; their difference plus one is
exactly 1,000,000,000.

The portable v1 `xub_mul_mod2` now implements a truncated square kernel that omits
high square terms. Merely calculating a full square and then masking it would
not save that work. Its shifted-add primitive ignores contributions beyond the
requested residue width. The API returns a nonnegative signed-product residue;
for an exact signed product use `xub_mul`, which restores the magnitude's sign.

### Quarter-square division needs two extra bits

For Q(t)=floor(t^2/4), compute t^2 modulo 2^(L+2) before shifting right by two,
or evaluate Q modulo 2^L directly. Reducing t^2 to L bits first is insufficient.
For 10 times 10 with an eight-bit result, the incorrect sequence gives
((20^2 mod 256)>>2)=36; retaining ten square bits gives 400>>2=100.

### Signed intermediate differences

For the fused evaluator, D(128,127)=255. With a four-bit split its recursive
parts include U=15, V=-225 and W=0, giving a negative cross term U+V-W=-210.
This is valid despite the positive final result. A native implementation must
use sufficient signed-magnitude storage, or explicitly modular arithmetic.
Residues can be added, subtracted and shifted, but cannot be compared as though
they were the original signed values.

## Verification added in this iteration

Run:

```sh
python3 .scratchpad/verify_edge_cases.py
```

[Executable checks](.scratchpad/verify_edge_cases.py) and
[recorded results](.scratchpad/edge-case-results.json) cover:

- All 65,536 ordered signed eight-bit pairs, including the minimum -128.
- The original magnitude formula, a signed wrapper with zero/unit/power-gap
  difference rules, and exact products from bounded modular squares.
- 1,663 additional distinct signed boundary/random pairs, through 4,097-bit
  operands, including reversed order, both signs, signed minima and table edges.
- 280 unsigned-magnitude conversion-model cases.
- All 65,536 ordered unsigned eight-bit pairs for the quarter-square residue
  rule with its two extra square bits.
- Explicit zero normalization, negative fused intermediates, complement
  termination conditions, and expected square-call counts for the user examples.

All checks passed. The scratch evaluator makes zero square calls for 10^9 times
1, one for 67 times 68, and two for the requested negative-input pair. These are
operation-path observations, not native timing measurements. Previous benchmark
sources and timing data were not changed.

## Portable C version 1 follow-through

The examples now run in the library and CLI, with signed boundary, aliasing,
cache mismatch, truncation, and carry tests in [tests/test_xub.c](tests/test_xub.c)
and [tests/oracle.py](tests/oracle.py). See [README.md](README.md) for the recorded
build and sanitizer results.

`1000000000 * 1` takes the unit branch with no square call; `67 * 68` uses one
table square. For `-4523 * -3412`, the exact dispatcher first strips two zero
bits from 3412, evaluates `4523 * 853` with `h=2688,d=1835,p=0`, then shifts the
answer left by two and applies the positive sign. Internal square reductions
can add nested square-call counts; those counters are not a count of independent
full-size squares. The original `3967^2-555^2+3412` derivation remains correct.
