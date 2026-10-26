# Further improvements after the first measurements

These proposals were recorded after the first [measurements](benchmark-results.md).
Version 1 now implements trailing-zero reduction, local square reuse, gated
dense complements, blocked unequal-length products, independent square selection,
dedicated limbs, repeated-midpoint caching, and truncated modular squares.
See [the current thesis](thesis.md) and [implementation](src/xub_mul.c).
General fused square-difference recursion, larger tables, scratch arenas, and
zero-copy recursive views remain future work. Historical timing files describe
the earlier prototypes; they do not measure these new changes.
The separate [portable v1 report](portable-results.md) now measures the implemented
paths and identifies their remaining overheads. It preserves the historical
datasets and reports both improvements and losses against direct comparisons.

Version 2 subsequently implements retained scratch, read-only recursive views,
scalar square leaves, and allocation-free steady-state byte blocking. It tunes
the existing options on training inputs and checks fresh held-out inputs; see
[the completed optimization report](optimization-results.md). Generic fused
square-difference recursion, larger tables, and a multiplication-limited hardware
target remain future work. Retained scratch requires explicit context cleanup.

## 1. Improve square evaluation for patterns we already measured

### Reuse identical children in the existing recursion

The current square splits z=A*2^r+B and independently evaluates A^2, B^2 and
|A-B|^2. Two inexpensive cases avoid duplicate work:

- B=0: compute U=A^2 once and return U<<(2r).
- A=B: compute U=A^2 once and return
  (U<<(2r))+(U<<(r+1))+U. The difference square is zero.

The existing high/low comparison already identifies equality. This is local
reuse without a global memoization table. Powers of two and repeated halves
can reduce an entire recursive subtree. These improvements may also benefit
the direct comparison implementation and must be applied fairly when comparing.

### Convert dense values into sparse complements

For a nonzero n-bit square argument z, set r=2^n-z. Then

\[
\boxed{z^2=((z-r)\ll n)+r^2.}
\]

Proof: z=2^n-r, so z^2=2^n(2^n-2r)+r^2 and z-r=2^n-2r.

Compute r by inverting the n used bits and adding one. Because z>=2^(n-1),
0<r<=z, so z-r is nonnegative. The shifted term and the final sum fit the
2n-bit result width; no temporary 2^(2n) needs to be materialized.

If z contains only a few zero bits, r has few set bits. For example,
z=(2^n-1)-2^j becomes r=1+2^j, a two-set-bit square argument. This directly
targets the measured almost-all-ones case where the set-bit square was slow.
For an all-ones value:

\[
(2^n-1)^2=2^{2n}-2^{n+1}+1.
\]

Do not always recurse through the complement. For a power of two r=z, which
would loop; handle powers of two first or require r<z. For an unstructured
value the complement may remove only one bit of length, so repeatedly applying
the transformation can be worse than balanced recursion. Select it when r is
substantially shorter or sufficiently sparse.

### Remove trailing zeros

If z=u<<t, then S(z)=S(u)<<(2t). Similarly, preprocess multiplication as

\[
x=2^u x_0,\quad y=2^v y_0,\quad
xy=\operatorname{midpoint}(x_0,y_0)\ll(u+v).
\]

The reduced factors still go through the same core. Power-of-two factors then
reduce to one; this removes an observed pathological case without changing the
identity. Output writing still costs proportional to its length.

## 2. Block the long operand when lengths differ greatly

The literal whole-input midpoint routine turns a short-times-long product into
two long squares. Instead, let the smaller factor a fit k bits and write

\[
b=\sum_i b_i2^{ki},\qquad 0\le b_i<2^k.
\]

Evaluate every a*b_i using the same midpoint routine. Stream its output:

```text
carry = 0
for each k-bit chunk b_i, from least significant upward:
    t = midpoint(a, b_i) + carry
    output_chunk[i] = low_k_bits(t)
    carry = t >> k
append carry
```

If a<2^k and incoming carry<a, then t<a*2^k<2^(2k), and the outgoing carry
remains below a. Thus each partial result fits 2k bits.

This is ordinary blocked multiplication whose elementary products all use the
square-difference kernel. For a fixed eight-bit factor and n-bit long operand,
it needs approximately n/8 table-based products and a linear pass over the
output, using the existing 512-byte square table. More generally its cost is
O(ceil(n/k)*T(k)+n) in a suitable limb implementation, where T(k) is the cost of
the balanced midpoint core. Align chunks with the representation where useful.

This is a high-priority remedy for the measured short-factor losses. It is not
a new asymptotic result, and a direct short-factor baseline is still necessary.
The scratch Python assembly uses large immutable integers and is only a
correctness reference; it does not establish linear-time storage operations.

## 3. Choose the square evaluator separately for h and d

The current native midpoint benchmark passes the same square function to both
arguments. A dispatcher can independently choose table lookup, structural
shortcut, set-bit rows, or recursive square for each argument and at selected
recursive nodes.

Keep classification cheap: use known length and zero information, reuse existing
comparisons, and stop a sparsity count as soon as a threshold is exceeded. An
always-complete classification pass at every node may erase any saving. Do not
assume that sparse original factors produce two sparse square arguments.

The reported retrospective best-of-method timing is not a measured dispatcher.
Benchmark its actual checking overhead as part of the product.

## 4. Reduce representation and memory-traffic costs

The current native prototype uses general BIGNUM API calls. In particular, the
set-bit square calls a bit test for every input position, and the recursive
square copies/masks operands and materializes wide shifts.

A dedicated array-of-words representation can:

- Skip zero words and enumerate their set bits with a trailing-zero operation.
- Split inputs into word-aligned views, avoiding whole-input copies.
- Accumulate results at word offsets, avoiding a temporary for every wide shift.
- Reuse scratch storage and fuse addition/subtraction passes where possible.

The pointer-and-length representation used by GMP's low-level interface supports
subranges of both inputs and outputs, illustrating this implementation approach.
[GMP low-level interface](https://gmplib.org/manual/Low_002dlevel-Functions)

This is the largest engineering task here. It could improve absolute times,
but direct multiplication must receive comparable implementation care before
any algorithm-level advantage is claimed.

## 5. Explore a fused square-difference evaluator

Define D(u,v)=u^2-v^2. The common product becomes D(h,d)+p*a, using the established
integer midpoint quantities. D need not materialize two complete squares.

Useful exact simplifications include

\[
D(t,t)=0,\qquad D(t+1,t)=2t+1,
\]

\[
D(t+2^j,t)=(t\ll(j+1))+2^{2j}.
\]

These remove large square computations when the gap is one or a power of two;
they recover known cheap multiplication cases inside the common evaluator.

For a general recursive construction, choose B=2^r and split
u=A*B+a, v=C*B+c. Calculate

\[
U=D(A,C),\quad V=D(a,c),\quad W=D(|A-a|,|C-c|).
\]

Then

\[
\boxed{D(u,v)=(U\ll2r)+((U+V-W)\ll r)+V.}
\]

The equality follows by subtracting the two ordinary three-square expansions.
This computes three smaller square differences and combines them once. Equal
subarguments can return zero before their individual squares are calculated.
There is no hidden arbitrary multiplication in this recurrence.

Internal values may be negative even when u>=v. A native implementation must
handle signs and magnitudes explicitly; shifting negative signed C integers is
not a portable translation of the mathematical formula. The worst-case
O(n^(log_2 3)) bound remains. Benefits from pruning, combination work, and memory
traffic require measurement; this is an experimental design, not a novelty or
general speedup claim. Merely factoring D=(u-v)(u+v) would recover the original
multiplication problem rather than solve the performance question.

## 6. Tune bounded tables and exploit actual reuse

An ordinary ten-bit square table with uint32 entries takes 4 KiB; a twelve-bit
table takes 16 KiB. Both are useful candidates between the measured 512-byte
and 256 KiB extremes. Table width and native scalar-leaf width are separate
parameters. Tune the split rule with the table: repeatedly halving powers-of-two
bit lengths may still land at eight-bit leaves and barely use a larger table.

For a repeated input sum, the truncated midpoint h and parity p stay constant.
Cache h^2 once; each subsequent product needs one square, subtraction, and the
parity correction. Setup, cache checks, storage, and the reuse distribution
must be included. Generic caching of random wide arguments may cost more than
it saves. Local recursive equality reuse is cheaper and more predictable.

## Proposed experiment order

1. Add zero/equal-half reuse, trailing-zero normalization, and the gated dense
   complement rule to the existing prototype. Measure each separately and in
   combination against unchanged and equivalently improved baselines.
2. Add blocked short-factor multiplication through the common midpoint kernel.
3. Measure a cheap per-argument square dispatcher and intermediate table sizes.
4. Compare the fused D evaluator with two independent squares using the same
   leaf primitives, including signed intermediate cases.
5. Use the evidence to guide a dedicated limb implementation and target-specific
   tuning. Test repeated-midpoint caching when a reuse workload is established.

The first experiment should focus on the existing sparse, dense, power-of-two,
nearby, and short-factor datasets, retaining random cases to expose regressions.
No blanket replacement of a square evaluator should be inferred from a narrow
structured-input gain.

## Identity checks in this iteration

[Scratch verification](.scratchpad/verify_improvement_identities.py) and
[recorded results](.scratchpad/improvement-identity-results.json) cover:

- All 65,536 sixteen-bit values for recursive reuse and the complement identity.
- All 65,536 ordered eight-bit pairs for the fused difference, the corresponding
  midpoint product, and blocked multiplication through the midpoint kernel.
- 49 larger product/difference pairs through 4,096 bits and 49 larger square
  values through 8,192 bits, including repeated halves, shifted values, dense
  values, and power-of-two boundaries.

All checks passed. They verify the implementations of the identities and do
not measure speed. The prior native benchmark results remain unchanged.

## Follow-up from edge-case analysis: bounded square residues

When the exact product magnitude is known to fit L bits, the midpoint formula
can evaluate both squares modulo 2^L and recover the exact product after modular
subtraction and parity correction. This may avoid high square bits that cancel,
especially for unequal inputs. A kernel must actually omit the unused work;
masking an already-computed full square does not accelerate it. See
[edge cases and the residue proof](edge-cases.md) for conditions, signed handling,
and the extra-bit requirement for quarter-square division. Correctness is checked;
native speed and memory savings have not been measured.
