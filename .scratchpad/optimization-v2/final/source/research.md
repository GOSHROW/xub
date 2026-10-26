# Research notebook: multiplication through subtraction of squares

Date: 2026-10-26. Status: portable C version 1 implemented and checked; see
[the thesis](thesis.md) and [build/validation instructions](README.md).
The numbered notes retain the development history and earlier experiment scope.

## Scope and working conclusion

Use exact binary integers of arbitrary finite length, now represented as arrays
of 32-bit words. Arbitrary precision removes a fixed register-size
ceiling; it does not remove finite memory or the need to write the result.

The user's midpoint identity is correct. We can implement its arithmetic with
integers alone and evaluate squares without a multiplication instruction. The
proposed architecture has one multiplication routine and several square
evaluators. Speed has now been measured on the available ARM64 host; see
[measured results](benchmark-results.md). It remains device- and workload-dependent.

Priority: hardware with limited multiplication support. Study small integers,
general large integers, and structured inputs separately, retaining subtraction
of squares as the common multiplication method.

The classical quarter-square method uses the same underlying identity; see
[Glaisher, *The Method of Quarter Squares* (1889)](https://www.nature.com/articles/040573c0).
This historical connection supplies useful prior art, not a performance verdict.

## 1. Exact arithmetic and the half-bit correction

For natural numbers x and y, reorder their magnitudes:

\[
a=\min(x,y),\quad b=\max(x,y),\quad
\Delta=b-a,\quad d=\Delta\gg1,\quad p=\Delta\mathbin{\&}1,\quad h=a+d.
\]

Here p is either zero or one. The exact midpoint and nonnegative half-distance
are h+p/2 and d+p/2. Hence

\[
xy=(h+p/2)^2-(d+p/2)^2
  =h^2-d^2+p(h-d)
  =\boxed{h^2-d^2+pa}.
\]

The last term is a conditional addition, not a multiplication. Both quarter
fractions cancel, but the integer cross terms must also be accounted for.

Pseudocode for the shared routine:

```text
multiply(x, y, square):
    a = min(x, y)
    b = max(x, y)
    delta = b - a
    d = delta >> 1
    h = a + d
    result = square(h) - square(d)
    if delta & 1:
        result += a
    return result
```

Example: x=7, y=12 gives delta=5, d=2, p=1, h=9, so
81-4+7=84. The original half-integers are 9.5 and 2.5.
Reversing the input order produces exactly the same calculation.

Because 0 <= d <= h <= b, preprocessing fits the original unsigned input
width. If both inputs have at most n bits, the squares and result fit 2n bits.
The intermediate difference is nonnegative and no larger than the final result.
In fixed-width C, subtraction must follow the magnitude comparison. A full-square
implementation needs explicit wide storage for exact squares. The separately
proved bounded-residue alternative in section 10 can intentionally omit high bits.

The user's right-shift mean is also correct when its lost low bits are handled:

\[
h=(x\gg1)+(y\gg1)+(x\mathbin{\&}y\mathbin{\&}1),
\qquad p=(x\mathbin{\oplus}y)\mathbin{\&}1.
\]

An equivalent expression is

\[
h=(x\mathbin{\&}y)+((x\mathbin{\oplus}y)\gg1).
\]

The reordered form h=a+d reuses the difference we already need. It also avoids
having to represent a negative half-distance when x>y.

Zero requires no new arithmetic. A later signed wrapper can multiply magnitudes
and restore the sign. Two's-complement negation is inversion plus one, not bit
inversion alone; minimum signed values require unsigned magnitude handling.

## 2. What bit symmetry supplies

Write z as binary digits b_i:

\[
z=\sum_i b_i2^i,\qquad
z^2=\sum_i b_i2^{2i}+\sum_{i<j}b_i b_j2^{i+j+1}.
\]

The diagonal term inserts a zero between consecutive bits. The cross terms are
paired symmetrically, so only one triangle needs evaluating before doubling.
Carries still have to be propagated. For z=3 (binary 11), spreading the bits gives
5 (binary 101); the missing cross term is 4, giving the correct square 9.
Zero insertion alone is not an integer squaring algorithm.

At the word level, L-word schoolbook multiplication has L^2 elementary products.
A specialized square needs L(L+1)/2 distinct products, counting the diagonal.
GMP uses this symmetry in its basecase square and reports a typical speedup of
about 1.5 relative to basecase multiplication, not a universal factor of two.
[GMP basecase documentation](https://gmplib.org/manual/Basecase-Multiplication)

On multiplication-limited hardware those elementary products can themselves be
software operations or table lookups. Sparse-bit algorithms can reduce the
number of nonzero cross terms, but dense inputs retain the quadratic pattern.

### A simple square using only shifts and additions

For e in {0,1},

\[
S(2u+e)=(S(u)\ll2)+
\begin{cases}0,&e=0,\\(u\ll2)+1,&e=1.\end{cases}
\]

Read the bits of z from most significant to least significant, maintaining the
prefix u and its square. This provides a compact low-memory reference and can
extend a small table to larger inputs. There are n bit steps, but the arithmetic
operands grow: the straightforward method has O(n^2) bit work, not O(n).

### Direct set-bit evaluation with grouped cross terms

The second discussion iteration explicitly prioritizes binary representation
where it improves squaring. A new candidate processes only the set bits.

Let the current remaining value t have its lowest set bit at position i. Remove
that bit to obtain r. Then

\[
t=2^i+r,\qquad t^2-r^2=2^{2i}+(r\ll(i+1)).
\]

The diagonal bit is at position 2i. Because r contains only bits above i, the
shifted cross terms start at position 2i+2 or higher. These two parts do not
overlap and can be combined with OR. Repeatedly remove the lowest set bit and
accumulate the resulting rows:

```text
square_set_bits(z):
    remaining = z
    result = 0
    while remaining != 0:
        higher = remaining & (remaining - 1)
        bit = remaining XOR higher
        i = bit_length(bit) - 1
        row = (bit << i) OR (higher << (i + 1))
        result += row
        remaining = higher
    return result
```

The invariant is result + remaining^2 = z^2. Each step adds exactly
remaining^2 - higher^2, so the sum telescopes to z^2. OR is valid within a row;
different rows may overlap, so their accumulation requires addition and carries.
All arithmetic operands remain nonnegative and no multiplication is used.

Example: z=1011 binary (11 decimal) produces rows 21, 36, and 64, whose sum is
121. A more extreme sparse example is

\[
(2^{1000}+1)^2=2^{2000}+2^{1001}+1.
\]

For n input bits and s set bits, there are exactly s iterations and accumulator
additions. Straightforward word-array arithmetic gives O(s*n) bit work and O(n)
live storage, including the output. This does not mean O(s) bit work: each row
can span nearly 2n bits. For general dense inputs, s=Theta(n) and the method
remains quadratic. The three-square recursion remains the candidate for large
general inputs. A fair bit-prefix comparison should also consider skipping runs
of zero bits, rather than comparing only with an unoptimized bit scanner.

Choose based on each square argument h and d individually. For example, sparse
inputs x=1 and y=2^n yield h=2^(n-1) but d=2^(n-1)-1: borrowing makes the
half-difference dense. The truncated mean itself satisfies
popcount(h) <= popcount(x)+popcount(y), since addition/carrying and then truncating
cannot increase that bound. No measured dispatch threshold is selected yet.

### A faster square built recursively from three smaller squares

Split z=A*2^r+B into two approximately equal bit lengths, choosing
r=floor(bits(z)/2) above the table threshold. Calculate

\[
U=S(A),\quad V=S(B),\quad W=S(|A-B|).
\]

Since U+V-W=2AB,

\[
\boxed{S(z)=(U\ll2r)+((U+V-W)\ll r)+V.}
\]

This is Karatsuba squaring. Its worst-case recurrence bound is

\[
S(n)\le3S(\lceil n/2\rceil)+O(n).
\]

With a fixed leaf threshold this gives O(n^(log_2 3)) bit work, where
log_2 3 is approximately 1.585.

It uses only shifts, addition, subtraction, comparison, and smaller squares.
Terminating at a square table or a single-bit case removes multiplication from
the entire candidate arithmetic kernel. The scratch implementation uses an
eight-bit square table. GMP describes the equivalent three-square identity in
its [Karatsuba documentation](https://gmplib.org/manual/Karatsuba-Multiplication).

Intermediate U+V and 2AB may need an extra bit beyond an individual half-square;
the native implementation must reserve carry space. Reusing temporary buffers
and arranging shifts as word offsets can matter as much as formula choice.

Recursion pitfall: computing A^2 and B^2 separately, then obtaining AB by another
two-square midpoint multiplication, generally makes four half-width square
calls. That gives O(n^2) work. The three-square construction shares the needed
information and avoids this extra call.

## 3. Square tables and the proposed half-integer column

The proposed second square column is redundant:

\[
(t+1/2)^2-1/4=t^2+t.
\]

Store S[t]=t^2 and add t when required. The index already supplies the input;
there is no reason to store a separate number column in a dense array.

For all b-bit inputs, a dense square table has 2^b entries. Fixed 2b-bit entries
give the following sizes, excluding alignment and metadata:

| Input bits b | One square column | Both proposed output columns |
|---:|---:|---:|
| 8 | 512 B | 1 KiB |
| 16 | 256 KiB | 512 KiB |
| 32 | 32 GiB | 64 GiB |
| 64 | 256 EiB | 512 EiB |

Thus full-range storage grows as Theta(b*2^b) bits. Compression or sparse
checkpoints trade storage for reconstruction work; they do not provide a small
table with free arbitrary-size random access. Reading a large result also takes
time proportional to its number of words.

Useful small leaf-table choices with conventional native entry storage:

| Leaf input bits | Entries | Entry type | Storage |
|---:|---:|---|---:|
| 4 | 16 | uint8 | 16 B |
| 8 | 256 | uint16 | 512 B |
| 12 | 4096 | uint32 | 16 KiB |
| 16 | 65536 | uint32 | 256 KiB |

A packed 12-bit input table could use three bytes per square (12 KiB), at the
cost of different load/reconstruction behavior. These are table candidates,
not selected performance thresholds.

Build the table using successive odd increments:

\[
S[0]=0,\qquad S[t+1]=S[t]+2t+1.
\]

Maintain the current odd increment and increase it by two. A ROM table can be
generated at build time; a RAM table has a startup cost that must be measured
separately. The Python tuple used for correctness has object overhead and does
not occupy the native table sizes above.

The bit recurrence allows a useful storage tradeoff: for eight-bit inputs,
store only S[0..127] in 256 bytes, then recover the square with shifts and an
optional addition. More recursion shrinks the table further and adds work.

### Quarter-square comparison

Define Q[t]=floor(t^2/4). Then

\[
xy=Q[x+y]-Q[|x-y|].
\]

The indices have the same parity, so the discarded quarter fractions cancel.
For eight-bit inputs Q needs indices 0..510, or 511 uint16 entries: 1,022 bytes,
usually allocated as 1 KiB. The sum needs nine bits. In contrast, the integer
midpoint routine uses the 512-byte square table and one conditional addition.
A full eight-bit multiplication table requires 128 KiB of uint16 entries.

Q is also generated without multiplication:

\[
Q[0]=0,\quad Q[t+1]=Q[t]+((t+1)\gg1).
\]

The midpoint form is the proposed common implementation; the quarter-square
form is a useful independent reference and alternative small-table comparison.

## 4. Cost and limits of the common routine

Let M(n) be the cost of general n-bit multiplication and S(n) that of a chosen
square evaluator. For inputs of at most n bits, the midpoint method costs

\[
T(x,y)=S(\operatorname{bits}(h))+S(\operatorname{bits}(d))+O(n),
\]

with zero handled by a constant base case. Although values are divided by two,
their bit lengths usually shrink by only a constant number of bits. h can have
n bits and d up to n-1 bits. Dividing a number by two is not splitting its digit
array in half.

If both arguments still occupy L words, two triangular schoolbook squares use
L(L+1) elementary products versus L^2 for direct schoolbook multiplication,
before accounting for additional shifts and additions. This particular count
assumes word products, including diagonal products, as the elementary unit.
It is not a gate count or a universal cycle model.

As an illustrative estimate only, if an equal-width square costs 2/3 of a
multiplication, two squares cost about 4/3 before wrapper overhead. Small
differences, square-specific structure, table costs, and platform thresholds
can change the outcome. This is not a measured slowdown for this project.

The reductions relate the problems in a consistent bit-cost model. Any
multiplication algorithm supplies a squarer by using the same input twice.
Conversely, any square evaluator supplies a multiplier with cost at most
2S(n)+O(n). Thus the optimal costs of the two general problems agree up to
constant factors. This is a statement about the problems, not an inequality
between arbitrarily chosen implementations. It does not rule out a faster
square algorithm: such an algorithm would also improve general multiplication
through this reduction.
Using the three-square evaluator gives a multiplication algorithm of
O(n^1.585), improving on quadratic shift-and-add asymptotically but not improving
the exponent over direct Karatsuba multiplication.

Additions, subtractions, and whole-integer shifts on arrays are generally linear
in the word count, including carries or borrows; they are not one instruction
for an arbitrary-size operand. Register-sized operations and arbitrary-size
operations must be kept separate in any cost model.

Established large-integer implementations use size-dependent methods including
Karatsuba, Toom, and FFT, rather than schoolbook multiplication alone.
[GMP algorithm overview](https://gmplib.org/manual/Multiplication-Algorithms)
For context, Harvey and van der Hoeven established an O(n log n) multiplication
algorithm in 2021; this citation is a published asymptotic benchmark, not a claim
that this project has surveyed every subsequent bound or that it is a suitable
small-device implementation.
[Published paper](https://annals.math.princeton.edu/2021/193-2/p04)

## 5. Separate plans sharing the same multiplication routine

### Small operands on multiplication-limited hardware

Use the integer midpoint routine with a compact square table. Compare 4-bit and
8-bit leaf tables, a half-range table, and the bit-prefix recurrence. Measure ROM
and RAM use, code size, cycles, and setup separately. A table load has a real
cost and some devices have slow program-memory reads. A local ARM workstation
cannot by itself establish an advantage on the intended weaker hardware.

### General large integers

Use word arrays and the recursive three-square evaluator, terminating at small
tables or the bit-prefix evaluator. Keep the same midpoint front end. Tune the
base-case threshold and scratch-buffer reuse after measuring; avoid an
exponentially large whole-operand table.

Useful comparison implementations are software shift-and-add, schoolbook
multiplication using the same small table primitives, and direct software
Karatsuba. These are benchmarks for the proposed common path. If a native
multiply instruction exists on the measured machine, report that separately.
Changing to small chunks does not itself improve schoolbook's quadratic scaling.

The compiler can transform arithmetic expressions, so inspect the eventual
assembly if a no-multiply arithmetic kernel is a requirement. Timing the Python
reference cannot establish C/ASM speed or target-device cycles.

### Structured inputs and repeated work

- Equal inputs make d=0: one useful square remains. Nearby inputs make d short.
  This can help the wrapper, but a fair baseline must also exploit nearby inputs.
- Powers of two square by a shift. For z=2^t plus or minus a small r, use
  S(z)=2^(2t) plus or minus (r<<(t+1)) plus S(r). This stays inside the square
  evaluator and helps only if r is genuinely short or otherwise cheap.
- The scratch set-bit evaluator groups cross terms into shifted rows, with one
  accumulator addition per set bit. General dense inputs need a fallback.
  Sparse original inputs can produce a dense half-difference through borrowing.
- Repeated h or d values permit cached squares. Constant-sum input families can
  reuse the midpoint square. Consecutive square queries use successive odd
  differences. Arbitrary random wide queries offer no guaranteed cache reuse.
- Known trailing zero bits can be factored from the inputs, the reduced operands
  sent through the common routine, and the product shifted back.
- A highly unequal pair can be a serious loss: multiplying 1 by an arbitrary
  huge integer is trivial, while the literal wrapper calculates two large
  squares. Zero, one, and power-of-two identities are candidates for cheap
  algebraic simplifications, if later discussion permits a preprocessing path.

The set-bit evaluator has been implemented and checked in the scratch reference.
It has also been measured in native code: sparse standalone squares benefit
relative to the recursive software squarer, while the full midpoint product can
lose the benefit through a dense half-difference. Automatic selection and the
other structural optimizations remain prospective.

## 6. Verification recorded in this iteration

The scratch experiment implements the bit-prefix square, grouped set-bit square,
three-square recursive square, additive square table, additive quarter-square
table, and shared midpoint routine. Native Python multiplication is used only as
a correctness oracle.

All checks passed:

- Each of the three square evaluators: all 65,536 unsigned 16-bit values, plus 333 deterministic
  large and boundary values.
- Midpoint multiplication using cached outputs of each evaluator, and the
  quarter-square method: all 65,536 ordered eight-bit input pairs.
- Midpoint multiplication calling each actual square evaluator: 961 larger and
  boundary pairs per evaluator.
- Mean bounds, reversed inputs, zero, equal inputs, all parity combinations,
  nearby values, and unequal lengths were included.
- Sparse, alternating, and dense bit patterns were included, along with sparse
  original operands producing dense half-differences.
- Random widths reach 4,096 bits; boundary values reach 4,097 bits.

The algebra proves the identity; finite checks check the implementation. They
do not establish performance. See the executable and JSON linked in README.
The pre-existing `.scratchpad/square-decimals` was left unchanged.

## 7. Next discussion and final deliverables

The proposed starting design is the integer midpoint routine with a square
evaluator that uses a small table for leaves and three-square recursion for large
inputs. Keep the bit-prefix evaluator as a simpler space-saving alternative and
the grouped set-bit evaluator as a sparse-value candidate. Select independently
for h and d once thresholds are measured. Add other structural shortcuts only
when their applicability and cost are clear.

Initial native host measurements now cover balanced/unbalanced inputs,
equal/nearby inputs, sparse/dense inputs, several sizes, table construction, and
one recursion-cutoff change. The full findings and methodology are in
[the measurement report](benchmark-results.md). Before target-device conclusions,
settle its ISA and ROM/RAM budget. Cached repeated-midpoint workloads, cold-cache
behavior, dependency-chain latency, energy, and peak working memory remain open.

At the end of the discussion: implement C, select the appropriate ASM target,
check carry and width boundaries with a trusted arbitrary-precision oracle,
measure on the chosen platform, and produce the polished Markdown/LaTeX account.
That stage is now complete for portable C: the library and CLI live in `src/`
and `include/`, with the polished account in `thesis.md` and `thesis.tex`.
Assembly is deferred by user choice. Benchmark-only C prototypes and their
generated assembly remain in `.scratchpad` for reproducibility.

## 8. Measurement findings

The 512-byte square table gave approximately 3.56x the throughput of software
shift-and-add on eight-bit random inputs on the host. A 1 KiB quarter-square
table matched the observed throughput of a 128 KiB full product table, near the
measurement harness floor. The 256 KiB sixteen-bit square table also beat the
tested software algorithms, with a much larger memory requirement.

The general thirty-two-bit midpoint routine was about 1.96x slower than its best
tested direct software comparison on random inputs. The tuned 4,096-bit routine
took about 379 microseconds versus 277 for direct software Karatsuba. Nearby
inputs were essentially tied with a structure-aware comparison. Sparse and
short-factor products exposed larger losses.

The grouped set-bit square itself was about 6.60x faster than the recursive
software square for sampled 4,096-bit values with three set bits. It was about
2.02x slower on random values and 20.4x slower on almost-all-ones values. The
appropriate square evaluator depends on its own argument, not only on x and y.

These findings do not establish target-device cycles. The host has a hardware
multiplier; the measured software arithmetic kernels avoid multiplication, but
host bit-scan instructions, cache, and BIGNUM API overhead still affect the result.
Full data, uncertainty ranges, qualifications, and build commands are recorded
in the measurement report; no universal performance or novelty claim is made.

## 9. Further improvements under discussion

See [further improvements](improvements.md) for the next proposed experiments:
reuse repeated recursive squares, normalize trailing zeros, complement dense
arguments, block highly unequal products through the same midpoint kernel,
select square evaluators independently, reduce BIGNUM API overhead, and explore
a fused square-difference recurrence. The new identities passed scratch
correctness checks; their speed has not yet been measured.

## 10. Edge cases and signed extension

[Edge cases](edge-cases.md) now documents the requested 10^9 times 1, 67 times
68, and -4523 times -3412 examples, as well as zero, sign combinations, fixed-
width boundaries, lookup limits, carry chains, and signed intermediate values.
The signed scratch wrapper passed all signed eight-bit pairs and larger cases.

The width review distinguishes full exact square intermediates from deliberately
modular squares. Given a proven output bound L, the midpoint formula can use
squares modulo 2^L and still recover the exact product magnitude. Quarter-square
evaluation needs two extra bits before its division by four. This is a checked
correctness observation and possible future optimization, not a measured speedup.

## 11. Portable version 1

The design is now implemented in portable C11, with signed magnitudes, all
principal structural paths, fixed-sum caching, and actual low-bit truncation.
The current [thesis](thesis.md) supersedes earlier implementation proposals;
[portable measurements](portable-results.md) evaluate this separate library.
The historical prototype data above remain intact.

The new measurements confirm substantial within-engine gains for blocking,
structured squares, and repeated sums. They also expose costs: the allocated
generic API loses the sampled general products to direct shift/add, and its
low-bit path loses to direct truncated shift/add. Near-input dispatch was
corrected before recording the final dataset. Assembly remains deferred by the
user's choice; target tuning, scratch reuse, and stronger direct baselines remain
engineering work rather than established speed claims.

## 12. Version 2: allocation and measured dispatch tuning

[The optimization report](optimization-results.md) now records the completed
portable engineering pass. Context-owned scratch, read-only recursive halves,
scalar square leaves, and streamed byte products reduce allocator and copying
costs. The common difference-of-squares identity remains intact. The context now
requires `xub_context_free`; `xub_context_trim` releases retained scratch between
operations without discarding its configuration.

The current Mac-tuned policy uses 32-bit leaves and a maximum sparse count of
32, capped by density at one set bit per 16 input bits. Structure classification
occurs above the leaf cutoff. Complement selection and blocking remain enabled.
Training and held-out data, both tuning iterations, and a rebuilt-v1 comparison
are preserved. Improvements are measured on this host; the tested direct
buffer-reusing multiplication still wins on general 4,096-bit products.

