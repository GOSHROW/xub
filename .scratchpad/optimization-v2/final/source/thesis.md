# Exact Multiplication Through Differences of Squares

## Scope and conclusion

Version 2, 26 October 2026. Portable C implementation with retained scratch storage. Measurements remain on the current Mac by request; assembly remains a later, target-specific task.

This project investigates exact integer multiplication on machines with limited multiplication support. The common arithmetic kernel is a difference of squares, with separate execution paths for bounded inputs, general large inputs, structured operands, unequal operand lengths, repeated magnitude sums, and products needed only modulo a power of two.

The underlying identity is correct, including odd sums and signed inputs. It does not by itself make general multiplication faster: computing the squares is the main cost. Historical experiments demonstrate useful small-table tradeoffs. Portable-library experiments distinguish structural shortcuts, repeated-work savings, allocator traffic, and the cost of retaining memory. The implementation's engineering thresholds are defaults selected for a measured workload, not proved optima.

“Arbitrary precision” means that operand length is determined at runtime and bounded by available memory and addressable sizes. It does not mean infinite integers can be represented or processed. The implementation produces exact integers, without floating-point arithmetic or approximation.

The mathematical idea belongs to the established difference-of-squares and quarter-square family. No novelty claim is made for that identity; a historical reference is [Glaisher, The Method of Quarter Squares (1889)](https://www.nature.com/articles/040573c0).

## An integer-only midpoint identity

For arbitrary signed inputs, first sort their magnitudes:

$$
a=\min(|x|,|y|),\qquad b=\max(|x|,|y|).
$$

Define

$$
\Delta=b-a,\quad d=\lfloor\Delta/2\rfloor,\quad p=\Delta\bmod 2,\quad h=a+d.
$$

Then the exact magnitude product is

$$
\boxed{ab=h^2-d^2+pa.}
$$

Here $pa$ means “add $a$ if $p=1$”; it requires no multiplier. The implementation needs a subtraction, a right shift, one parity bit, and additions around two square evaluations.

To prove the formula, the true midpoint and half-distance are $m=h+p/2$ and $k=d+p/2$. Therefore

$$
ab=m^2-k^2=h^2-d^2+p(h-d)=h^2-d^2+pa.
$$

For odd parity the two quarter terms cancel exactly. No floating-point value or half-integer table entry is needed. For even parity the correction disappears. Sorting the magnitudes also makes $d$ nonnegative; the sign of the original half-distance is irrelevant after squaring.

All preprocessing values fit the original larger magnitude width: $0\le d\le h\le b$. Computing $a+d$ avoids first forming an overflowing $a+b$ in a fixed-width register. An equivalent floor midpoint is

$$
h=(a\mathbin{\&}b)+((a\mathbin{\oplus}b)\gg1).
$$

The final sign is negative exactly when one input is negative and the magnitude result is nonzero. Zero has one canonical representation. Two's-complement bit flipping alone is not a complete sign conversion: its negation rule includes adding one, and the most negative signed machine integer has no positive counterpart in that same signed type.

## Squaring from binary structure

### Symmetry and carries

For $z=\sum_i b_i2^i$, with $b_i\in\{0,1\}$,

$$
z^2=\sum_i b_i2^{2i}+\sum_{i<j}b_ib_j2^{i+j+1}.
$$

The diagonal terms and one triangular set of doubled cross terms suffice. Inserting a zero between every input bit gives only the diagonal. For example, $3=11_2$ gives diagonal value $5$ and a cross term $4$, yielding $9$. Contributions overlap, so ordinary integer carries remain necessary. This symmetry also underlies conventional optimized squaring; see the [GMP basecase description](https://gmplib.org/manual/Basecase-Multiplication).

### Small tables

Store $S[t]=t^2$ for $0\le t<256$. Each entry fits in 16 bits, so the table takes 512 bytes. It can be initialized without multiplication:

$$
S[0]=0,\qquad S[t+1]=S[t]+2t+1.
$$

The proposed extra column for half-integers is redundant because

$$
(t+\tfrac12)^2-\tfrac14=t^2+t.
$$

A whole-input table grows exponentially. A 16-bit square table with 32-bit entries takes 256 KiB; a 32-bit table with 64-bit entries takes 32 GiB. The library keeps the 512-byte table and evaluates larger squares algorithmically. Larger bounded tables may be appropriate on a particular device, but are not included as default alternatives.

The related quarter-square table $Q[t]=\lfloor t^2/4\rfloor$ gives

$$
ab=Q[a+b]-Q[|a-b|].
$$

The two indices have the same parity, so their discarded fractions cancel. Eight-bit factors require indices through 510: 511 16-bit entries occupy 1,022 bytes, conventionally allocated as 1 KiB. This alternative was measured in the prototypes; the portable library uses the ordinary-square midpoint formula.

### Sparse squares

Remove the lowest set bit from a remaining value, writing it as $t=2^i+r$. The square contribution removed is

$$
t^2-r^2=2^{2i}+(r\ll(i+1)).
$$

Accumulate that contribution and continue with $r$. Since $r$ has no bit at or below position $i$, the two terms within this contribution do not overlap. Contributions from different iterations must still be added with carries.

For an $n$-bit input with $s$ set bits, a straightforward limb implementation takes $O(sn)$ bit work and $O(n)$ live magnitude storage. It is attractive for sparse square arguments and quadratic for dense ones. Sparsity must be tested separately for $h$ and $d$: sparse factors can produce a dense half-distance. For instance, factors $1$ and $2^n$ produce $d=2^{n-1}-1$.

### Recursive squares

Split $z=A2^r+B$ and compute

$$
U=A^2,\qquad V=B^2,\qquad W=|A-B|^2.
$$

Then

$$
z^2=(U\ll2r)+((U+V-W)\ll r)+V.
$$

The middle coefficient is $2AB$, obtained using three smaller squares. Balanced splits give $T(n)=3T(\lceil n/2\rceil)+O(n)$ and therefore $O(n^{\log_2 3})$, approximately $O(n^{1.585})$, above a fixed leaf threshold. This is the same three-subproblem principle described in [GMP's Karatsuba documentation](https://gmplib.org/manual/Karatsuba-Multiplication).

If one half is zero, only the other half's square is needed. If $A=B$, reuse one square and set $W=0$. These cases avoid unnecessary recursive work. The recursion cutoff is configurable; the table itself remains eight bits wide. Version 2 represents split halves as read-only views of existing limbs, avoiding copied high and low halves. The views remain owned by their input and are never freed as temporary integers.

Below that cutoff, the basecase evaluates the diagonal byte squares and each doubled off-diagonal byte product. Every such byte product uses the midpoint identity with table lookups. For square arguments of at most 32 bits, version 2 accumulates these nonnegative terms in a 64-bit scalar: their sum is the exact square and fits that width. Larger basecases accumulate into limbs. This closes the recursion with shifts, additions, and a finite table; it does not call a native multiplier to supply the missing cross terms.

### Powers of two, trailing zeros, and dense complements

For trailing-zero count $t$,

$$
S(z\ll t)=S(z)\ll2t.
$$

A power of two therefore needs only its result bit set. For a dense $n$-bit value, set $r=2^n-z$. A second useful identity is

$$
z^2=((z-r)\ll n)+r^2.
$$

Here $r\le z$, so the subtraction is nonnegative. The implementation forms the complement within the active width, plus one, rather than constructing an unnecessarily large square of $2^n$. For $z=2^n-1-2^j$, the complementary value is only $1+2^j$.

Complement recursion needs a progress condition. A power of two has $r=z$ and would loop if this rule were applied blindly. The implementation handles powers first and gates the complement path on a substantially smaller or suitably sparse remainder. Version 2 tests whether the complement is useful before allocating its limbs. After trailing zeros are removed the argument is odd, so adding one to its bitwise complement changes only the low bit; the predicate can scan the prospective remainder directly. Removing just one bit at each recursive step is not a sufficient performance argument.

### Compact prefix evaluation

For an input prefix $u$ and next bit $e\in\{0,1\}$,

$$
S(2u+e)=4S(u)+e(4u+1).
$$

Processing bits from most to least significant gives an iterative evaluator with $O(n)$ live magnitude storage and $O(n^2)$ worst-case bit work. The COMPACT option selects this simple evaluation strategy. It still belongs to the dynamically allocated library and its context still contains the 512-byte table; it is not a fixed-RAM guarantee.

## Branches for different multiplication demands

The square engine is selected for each argument independently. The public product paths preserve the midpoint identity as the common general kernel, while recognizing cases where its result simplifies directly.

| Demand or operand feature | Version 2 path | Expected benefit and limit |
|---|---|---|
| Zero or unit magnitude | Return zero or copy the other magnitude | Avoids all square evaluation; copying a large result still costs linear time. |
| Equal magnitudes | One square | Reuses identical work; a direct multiplier can make the same optimization. |
| Adjacent magnitudes | $a^2+a$ | One square and addition, including mixed parity. |
| Both magnitudes at most 255 | Direct midpoint-table evaluation | Avoids arbitrary-precision midpoint temporaries for this bounded case. |
| Nearby, nonadjacent magnitudes | Preserve the original midpoint when $\operatorname{bits}(b-a)\le\lfloor\operatorname{bits}(b)/2\rfloor$ | One large square and one smaller square; recognize this before independent trailing-zero stripping. |
| Trailing zeros after proximity handling | Strip them, multiply reduced magnitudes, restore the combined shift | Reduces arithmetic width; powers of two become unit products after stripping. |
| Very unequal lengths | Split the longer factor into blocks and use the same product kernel for each block | Avoids evaluating two large, almost equal squares for a tiny factor. |
| General balanced inputs | $h^2-d^2+pa$ | Exact general fallback; two square costs remain. |
| Sparse or dense square arguments | Sparse accumulation or gated complement, selected independently | Exploits structure that survives the midpoint transformation. |
| Fixed magnitude sum across calls | Cache $\lfloor(a+b)/2\rfloor^2$ | Saves its repeated square after preparation; checking the sum and the second square remain. |
| Only the low $L$ product bits are required | Truncated square residues and modular subtraction | Avoids producing discarded high product bits; this backend has quadratic worst-case work. |
| Iterative square evaluation preferred | COMPACT prefix square | Simple state progression, at the cost of quadratic work. |

Within square evaluation, AUTO first uses the eight-bit table and strips trailing zeros. Structural classification is limited to arguments longer than both 16 bits and the configured basecase cutoff. The effective sparse allowance is the smaller of the configured limit and $\lfloor\operatorname{bits}(z)/16\rfloor$; the complement predicate uses that same allowance. Remaining values up to the cutoff use the byte basecase; larger values recurse. The selected host defaults are a 32-bit cutoff, sparse limit 32, enabled complement handling, and blocking ratio four. These are engineering heuristics; host tuning is recorded in [optimization-results.md](optimization-results.md). Disabling sparse selection or blocking is possible by setting its respective threshold to zero. RECURSIVE, SPARSE, and COMPACT square modes support controlled comparisons. Product-level simplifications still apply; a requested square mode is not a promise to perform otherwise unnecessary squares.

### Preserve proximity before stripping each factor

After zero, unit, equal, and adjacent cases, the exact dispatcher tests

$$
\operatorname{bits}(b-a)\le\lfloor\operatorname{bits}(b)/2\rfloor.
$$

If true, it evaluates the original midpoint directly. Independently removing different numbers of trailing zeros from the two factors can turn a short difference into a large one, replacing one large square and one short square with two large squares. The proximity gate preserves the useful original relationship; each square can still strip its own trailing zeros. If the test fails, product-level trailing-zero normalization proceeds before the unequal-length check. The proximity test is a fixed heuristic. A nearby-aware direct multiplier can exploit the same input relationship, so this branch alone is not a claim of superiority.

### Unequal lengths without abandoning the common kernel

Let the shorter magnitude $a$ fit in $k$ bits and expand the longer one as

$$
b=\sum_{i=0}^{q-1}b_i2^{ki},\qquad 0\le b_i<2^k.
$$

Compute $ab_i$ using the same exact product kernel, then combine blocks with carries. A streaming formulation computes $t_i=ab_i+c_i$, emits its low $k$ bits, and carries $c_{i+1}=\lfloor t_i/2^k\rfloor$. Starting with $c_0=0$, the bound $c_i<a$ implies $t_i<a2^k$; each local intermediate needs at most $2k$ bits.

With bounded local accumulation and linear result assembly, the cost is $O(qT(k)+n)$ for a longer operand of $n$ bits. Fixed short $k$ therefore permits linear scaling in $n$. Repeatedly copying or adding across an entire growing result for every block would lose that bound; efficient limb accumulation is part of the implementation requirement.

Version 2 specializes the blocked case when $a\le255$: it uses eight-bit blocks, even if the factor's own bit length is smaller, and computes each byte product through the midpoint table. Scalar carry propagation assembles result limbs directly. This retains the same algebra while avoiding separate arbitrary-precision objects for each block. Larger short factors use the generic $k$-bit formulation above.

### Repeated magnitude sums

When $a+b=C$ stays fixed, both $h=\lfloor C/2\rfloor$ and $p=C\bmod2$ stay fixed. Precompute $h^2$ once, then use

$$
ab=h^2-d^2+pa
$$

for each pair. The cache is keyed by $|x|+|y|$, not by the signed sum $x+y$. The API validates that key on each call and returns a cache-mismatch error otherwise. Preparation cost and cache storage must be amortized across repeated calls before this becomes a useful tradeoff. The portable measurements below quantify one favorable fixed-sum workload; other sums, pair distances, and target devices need separate evaluation.

## Exact results, intermediate width, and modular demand

Avoiding overflow in the midpoint does not imply that its squares fit the final product width. For $10^9\cdot1$, the result needs 30 bits, while the midpoint square needs 58. For $1\cdot(2^{64}-1)$, the product needs 64 bits but the midpoint square needs 127. Unit and blocked branches address these cases; arbitrary-precision storage also makes the general formula correct.

If only a residue modulo $2^L$ is required, use

$$
ab\bmod2^L=(S(h)\bmod2^L-S(d)\bmod2^L+pa)\bmod2^L.
$$

The modular path first reduces each input magnitude modulo $2^L$, then computes the midpoint and half-distance exactly for those reduced magnitudes. Its bitwise square backend accumulates only retained low bits. Reducing the original sum before the midpoint right shift would not be equivalent: division by two needs the correct input carry information.

For negative signed products, a nonzero magnitude residue $r$ becomes $2^L-r$; zero stays zero. The API always returns the canonical nonnegative residue. The special request $L=0$ gives zero, because the modulus is one.

The same residue identity can recover an exact nonnegative product if a proven bound gives $ab<2^L$. For nonzero factors, $L=\operatorname{bits}(a)+\operatorname{bits}(b)$ is sufficient. Exact multiplication nevertheless uses its exact paths; the modular backend is a separate caller-selected demand.

The quarter-square form has an additional caveat: dividing by four after truncation requires retaining $L+2$ square bits, not $L$. With $a=b=10$ and $L=8$, prematurely truncating $20^2$ gives $144$, and $144/4=36$ is wrong. Retaining ten square bits gives $400/4=100$. The midpoint formula's integer correction avoids this division-after-truncation issue.

## Portable C contract and edge cases

The API in [include/xub.h](include/xub.h) represents magnitudes as little-endian 32-bit limbs and stores the sign separately. C11 targets must provide `uint32_t` and `uint64_t`. Public outputs may alias their inputs; public arithmetic errors preserve the previous output value. Callers initialize and free values and caches, and use a separate mutable context per thread. Allocation and address-size failures are reported rather than interpreted as arithmetic wraparound. Operand capacity is bounded by available RAM and `size_t` arithmetic. The implementation dynamically allocates memory; a no-heap embedded interface would require a separate scratch-storage design.

Version 2 contexts own retained scratch buffers. Initialize a context once, do not shallow-copy it, and call `xub_context_free` before discarding or reinitializing it. `xub_context_trim` releases scratch between public calls while preserving options, the square table, and counters; existing caller-owned results and cache values remain valid. `xub_context_free` additionally clears the context, which then requires initialization before reuse.

Scratch capacities are reused by recursive siblings and later operations. A successful call transfers the new result to the caller and can retain the previous output buffer for later work. A failed call preserves the existing output and returns its scratch ownership consistently. Retention can eliminate allocations for repeated shapes, but it can also keep capacity from an earlier, larger operation. Trimming provides an explicit way to release that memory.

Decimal, hexadecimal, and binary input are supported, with an optional sign. Parsing accepts no surrounding whitespace. Formatting returns an allocated string. Conversion back to `int64_t` checks the range, while the arbitrary-precision result itself may exceed it. The arithmetic design uses shifts, additions, subtraction, and bit tests for its square/product kernels. This is a source-level design statement, not a whole-program guarantee about instructions chosen by every compiler: allocation, conversion, and compiler lowering require separate auditing on the eventual target.

Signed machine minima need special care. To obtain the magnitude of `INT64_MIN`, convert to unsigned and perform unsigned subtraction from zero; do not evaluate its signed negation or `abs` in the same signed width. Native shifts also need valid shift counts and unsigned operands. Relevant C rules are in [WG14 N1570, sections 6.3.1.3, 6.5.7, and 7.22.6.1](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf).

| Example | Result | Relevant handling |
|---|---:|---|
| $1000000000\cdot1$ | 1000000000 | Unit shortcut; no large intermediate squares. |
| $67\cdot68$ | 4556 | $67^2+67$; equivalently $h=67,d=0,p=1$. |
| $(-4523)(-3412)$ | 15432476 | Positive sign; unnormalized formula has $h=3967,d=555,p=1$. |
| $(-4523)(3412)$ | -15432476 | Same magnitude computation, negative final sign. |
| $0\cdot x$ | 0 | Canonical zero, including signed textual zero. |
| $\texttt{INT64\_MIN}\cdot(-1)$ | $2^{63}$ | Exact large result; conversion to signed 64 bits reports range error. |
| $\texttt{INT64\_MIN}^2$ | $2^{126}$ | Magnitude conversion avoids signed overflow. |
| $(-3)\cdot5\bmod2^8$ | 241 | Canonical residue of $-15$. |

The negative-pair example expands algebraically to $3967^2-555^2+3412=15737089-308025+3412=15432476$. The actual dispatcher first strips two trailing zeros from 3412, so it evaluates $4523\cdot853$ and restores a two-bit shift. That reduced midpoint uses $h=2688,d=1835,p=0$. The two calculations agree; the unnormalized derivation is not a trace of the optimized execution.

Other necessary boundaries include limb transitions at 31/32/33 and 63/64/65 bits, all-ones values, long carry and borrow chains, unequal lengths near the blocking threshold, cache mismatch, zero-bit residues, and input/output aliasing. A multiplication-limited target must also be assessed for the cost of wide addition, bit scans, memory traffic, and allocation. On a small instruction set, even 64-bit additions and shifts may compile into runtime helper calls. Neither data-dependent dispatch nor table lookup is constant-time; no cryptographic timing guarantee is made.

## Implementation validation

The portable C11 build is warning-clean under the tested compiler. Its Python oracle checked 69,303 products, including all 65,536 ordered signed eight-bit pairs, all square modes, and operands up to 16,384 bits. The C suite passed 12,966 checks. Commands and preserved validation reports are linked from [README.md](README.md). Passing finite tests supports the implementation; it does not replace the algebraic proof or establish performance.

UndefinedBehaviorSanitizer also passed the C suite and a 3,275-product quick oracle through 8,193 operand bits without diagnostics. AddressSanitizer could not be validated on this host because its runtime stalled before program entry, including for the help command; no AddressSanitizer pass is claimed.

## Measurements for version 2

The refined host tuning search measured 18 configurations using a training corpus and then checked the selected defaults on disjoint, prespecified seeds and larger held-out sizes. Against 64-bit cutoff/sparse-limit-eight settings on the same optimized code, the selected 32/32 settings achieve a held-out time-ratio score of 0.4362. This score gives equal weight to seven workload families and uses geometric means; it is not a universal 56% speedup. All seven held-out families improve in the sample. The search was not exhaustive, and the full methodology is in [optimization-results.md](optimization-results.md).

The uninstrumented final benchmark and a fresh v1 recheck use Apple Clang 17 at `-O2 -g`, five CPU-time trials of at least 20 ms per row, and warm deterministic fixtures. Direct controls now reuse result buffers, and the modular direct control truncates each accumulation. They make the comparison fairer than attributing every gain to the identity. Selected medians are in microseconds per operation:

| Workload | Fresh v1 | Version 2 | Direct control with reused buffers |
|---|---:|---:|---:|
| Eight-bit product | 0.270 | 0.0316 | 0.0697 |
| Balanced 4,096-bit product | 1369.438 | 462.375 | 296.953 |
| 4,096-bit magnitude times 67 | 138.066 | 1.016 | 0.515 |
| Three-set-bit 4,096-bit square | 0.931 | 0.678 | 0.600 |
| Low 64 product bits of 4,096-bit inputs | 1.592 | 0.951 | 0.485 |

The balanced case improves 2.96-fold over v1 but still takes 1.56 times as long as direct shift/add. The eight-bit case beats the reused direct control by 2.21-fold. Nearby fixed-sum calls take 1.083 us with the cache versus 218.852 us ordinarily; preparation takes 218.703 us, predicting amortization after at least two products under an additive timing model. The all-ones square takes 0.466 us versus 0.945 us in forced recursive mode. These are benefits for the stated cases, not general superiority. Raw ranges, input distributions, cold-scratch controls, and methodological limits are in [optimization-results.md](optimization-results.md).

The separate intrusive allocation profile compares the final defaults of both versions. It records allocation traffic and requested live heap payload; it supplies no timing or RSS measurements.

For one balanced 4,096-bit pair, v1 makes 14,567 allocation attempts on each call. Version 2 makes 205 on its first call and zero on a steady repeat after five prior calls. All five tested workloads reach zero attempts in that steady state. The immediate first repeat may still allocate as output and scratch capacities rotate. These observations do not imply that every subsequent input or larger shape is allocation-free.

The balanced fixture's peak requested live heap payload rises from 18,176 bytes in v1 to 37,440 bytes in the retained-buffer implementation. These totals include prepared inputs, an independent reference result, output, and context allocations; they exclude allocator overhead, profiler headers, stack space, and allocator-internal transient copies. Trimming releases 32,320 bytes and returns the fixture to 5,120 live bytes while keeping its result valid. The complete methodology, other workloads, and cleanup checks are in [optimization-results.md](optimization-results.md).

Fault injection covers every allocation position of a 128-bit multiplication with a cold context and after a 64-bit warmup. Version 2 passes 49 and 34 positions respectively; failures preserve the output, retries succeed, and complete cleanup leaves zero tracked blocks and bytes. Its profiler passes 673 checks. The profile is compiled separately from production and timing binaries.

## Archived portable-library measurements for version 1

These archived measurements use the final v1 dispatcher, including the proximity gate, on the ARM64 macOS host with Apple Clang 17 and `-O2 -g`. They are not version 2 timings. They use process CPU time from C `clock()`: five trials per row, each at least 20 ms, with median, minimum, and maximum in the [preserved raw CSV](.scratchpad/portable-v1/benchmarks.csv). The [v1 portable benchmark report](portable-results.md) gives the complete methodology and 32 rows.

Balanced, long-by-short, and modular cases use eight deterministic pairs. Random magnitudes have their top and low bits forced, so these are fixed-width odd draws, not uniform draws over all magnitudes. The cache case uses eight nearby pairs sharing one 4,096-bit magnitude sum; their factors are 4,095 bits. Each sparse or dense square case uses one structured value. Trials reuse warm fixtures in fixed algorithm order, with uncontrolled CPU frequency and core placement. Parsing and reference preparation are excluded; public-call allocation, dispatch, counters, and result consumption are included. The direct shift/add comparator uses the same magnitude primitives and temporary-result policy; its modular variant truncates every accumulation to the requested width.

All times below are microseconds per operation.

| V1 workload | V1 path | Comparison | Observation |
|---|---:|---:|---|
| 4,096-bit odd pairs | AUTO: 1316.813 | Direct shift/add: 306.063 | AUTO took 4.30 times as long. |
| 4,096-bit magnitude times 67 | Blocked: 134.285 | Unblocked midpoint: 1306.625 | Blocking was 9.73 times faster within this architecture. |
| 4,096-bit three-set-bit square | AUTO: 0.920 | Forced recursive square: 28.613 | Structural selection was 31.1 times faster than that square mode. |
| 4,096-bit all-ones square | AUTO: 0.792 | Forced recursive square: 2.699 | Gated complement handling was 3.41 times faster. |
| Nearby pairs with fixed magnitude sum | Cached: 1.452 | Ordinary multiplication: 652.938 | About 450-fold steady-state savings, before cache preparation. |
| Low 64 product bits of 4,096-bit operands | Truncated midpoint: 1.542 | Truncated direct shift/add: 0.762 | Midpoint took 2.02 times as long. |

The comparisons have important boundaries. Direct shift/add took only 0.556 us for multiplication by 67, so blocking still took about 241 times as long as that three-set-bit direct product. The sparse square's direct shift/add comparison was 0.638 us, also faster than AUTO. The all-ones direct comparison took 595.203 us but did not recognize the all-ones structure, so that gap is not evidence against an equally specialized direct implementation. For general 4,096-bit odd pairs, forcing RECURSIVE took 1107.594 us: AUTO was approximately 19% slower on that dataset, so its classification did not pay off there.

Cache preparation took 649.969 us. For preparation time $P$, ordinary per-product time $T$, and cached time $C$, an additive timing model gives a speed benefit after $N$ products when $P+NC<NT$, or $N>P/(T-C)$ when $T>C$. The medians put one call near break-even, and the observed timing ranges do not support a robust one-call benefit. The model predicts clear amortization at two or more products in this nearby-pair workload; an entire $N$-call batch was not separately timed. These numbers describe reuse of a large common square; they do not predict the benefit for distant fixed-sum pairs, where the other square can also be large.

For the low-bit demand, computing the full v1 midpoint product and then masking took 1305.938 us. Avoiding unused work is useful, while the truncated direct comparator remains faster. The v1 eight-bit API takes about 266 ns versus 116 ns for direct shift/add; the historical approximately 1.5 ns scalar result cannot be transferred to this generic API. These are different implementations and input distributions. No speed result here is a measurement on a multiplication-limited target.

## Historical measurements and their limits

The following measurements belong to the earlier scalar and OpenSSL BIGNUM prototypes in `.scratchpad`. They are not timings of the final portable limb library and must not be presented as such. Full methodology, raw CSV links, and additional workloads are in [benchmark-results.md](benchmark-results.md).

The host was ARM64 macOS, Darwin 25.6.0, with Apple Clang 17 at `-O3`; the large prototype used OpenSSL 3.6.3 for storage and basic operations. Small runs used 4,096 pregenerated pairs and seven trials; large runs used eight pairs and five trials. Samples targeted roughly five milliseconds, algorithm order was shuffled, and tables and temporary buffers were warm. CPU core and frequency were uncontrolled. No multiplication-limited target board or cycle-accurate simulator was measured.

| Historical workload | Square-based candidate | Relevant comparison | Interpretation |
|---|---:|---:|---|
| Eight-bit random products; 512-byte table | 1.51 ns | Shift/add: 5.37 ns | 3.56-fold prototype advantage over that software baseline. |
| Eight-bit quarter table; 1 KiB | 1.13 ns | Full product table, 128 KiB: 1.14 ns | Similar measured throughput with 128-fold less table storage. |
| Sixteen-bit random products; 256 KiB table | 1.45 ns | Software Karatsuba: 8.61 ns | 5.95-fold advantage with a substantial table. |
| Thirty-two-bit random products | 36.11 ns | Shift/add: 18.44 ns | Midpoint candidate took 1.96 times as long. |
| 4,096-bit random products | 379.312 us | Direct software Karatsuba: 277.417 us | Midpoint candidate took 1.37 times as long. |
| 4,096-bit nearby products | 190.469 us | Nearby-aware control: 190.281 us | Effective tie in this experiment. |
| 4,096-bit sparse products | 89.859 us | Short/sparse shift/add: 6.667 us | Midpoint candidate took 13.48 times as long. |
| 4,096-bit three-set-bit square | 6.743 us | Recursive square: 44.533 us | Standalone sparse square was 6.60 times faster. |
| 4,096-bit random, native arithmetic control | 5.861 us | Direct native multiply: 2.819 us | Optimized native squares did not remove wrapper overhead. |

The approximately 1.1 ns small-call harness floor prevents precise instruction-latency conclusions from the smallest measurements. The 16-bit table is not the default v1 table. The sparse-square result is a standalone square result, not a sparse-product speedup. General near/equal comparisons used controls that also exploit known input structure. The large kernels retained BIGNUM API and allocation-management costs, so their constants cannot be transferred directly to limb code.

A single change from eight-bit BIGNUM leaves to 32-bit scalar leaves reduced the 4,096-bit random midpoint prototype from 2,381.125 us to 379.312 us, a 6.28-fold improvement. That demonstrates sensitivity to implementation overhead, not an inherent advantage of the identity. It still did not beat the relevant direct comparison.

Prototype verification included all 65,536 ordered unsigned eight-bit pairs, every 16-bit square value, 100,000 random 32-bit pairs, and larger boundary datasets. These historical checks are distinct from the portable release checks above.

Energy, cold-cache performance, total peak working RAM, million-bit inputs, and final target assembly remain unmeasured. The allocation experiment measures only the specified requested-heap-payload component of memory. Cache amortization has been estimated from measured setup and per-call costs for the nearby fixed-sum workload above; it is not established for arbitrary workloads or other processors.

## What is established, and what remains to improve

Addition, subtraction, and arbitrary shifts are linear in the touched limb count, even when each limb operation is cheap. They are not constant-time register operations on an arbitrarily long number. Schoolbook multiplication performs a rectangular collection of digit products; more advanced implementations already reduce that work. A fair comparison includes optimized direct multiplication, specialized squaring, and the same structural shortcuts. The [GMP multiplication overview](https://gmplib.org/manual/Multiplication-Algorithms) illustrates the need for size-dependent choices.

Any multiplication algorithm can square by using equal inputs. Conversely, a square algorithm gives multiplication through two squares plus linear work. Thus the two problems have comparable asymptotic difficulty up to these reductions. Replacing multiplication with squares does not supply a new asymptotic breakthrough. The general recursive route is subquadratic, the sparse route depends on set-bit count, and the compact and current truncated modular routes have quadratic worst cases.

The most useful next improvements are concrete experiments:

1. Benchmark the portable limb implementation on the intended hardware, including a direct shift/add and direct recursive comparison. Measure latency, throughput, cold and warm memory behavior, code/table size, and peak scratch memory separately.
2. Tune the square cutoff, sparse threshold, complement gate, and blocking ratio jointly. Explore 10-bit or 12-bit square tables only where 4 KiB or 16 KiB of table storage is acceptable.
3. Extend retained-buffer measurements to varying operand shapes, long-lived contexts, explicit memory budgets, and trimming policies. Buffer reuse is implemented; its retained-capacity tradeoff now needs broader workload evaluation.
4. Add a recursive truncated-square backend if large modular workloads justify it. The present modular branch establishes correct demand-specific arithmetic, not the fastest asymptotic implementation.
5. Extend fixed-sum cache measurements to diverse sums and pair distances, cold preparation, and the intended target. Measure per-call validation cost and the reuse count needed to amortize preparation for each workload.
6. Investigate shared evaluation of $D(u,v)=u^2-v^2$ beyond simple equal/adjacent cases. A general fused recursion is not implemented; internal signed differences and cancellation require their own correctness and performance treatment.
7. Choose assembly only after selecting a target and identifying its measured bottlenecks. Portable C remains the first deliverable requested here.

This is a workable multiplication architecture with explicit applicability limits. Existing evidence supports bounded lookup tables in scalar prototypes, selected square structures, and reusing a common large midpoint square. General large-integer superiority remains unproved and was not observed in either the historical or current general-random comparison.

## Repository record and references

The Markdown and LaTeX versions of this thesis describe the same version 2 design. The entry point for building, running, and checking the portable implementation is [README.md](README.md); its public API is [include/xub.h](include/xub.h), and current optimization measurements are in [optimization-results.md](optimization-results.md). The initial portable implementation is preserved in [portable-results.md](portable-results.md). Historical discussion and experiments remain in [discussion.md](discussion.md), [research.md](research.md), [edge-cases.md](edge-cases.md), [improvements.md](improvements.md), and [benchmark-results.md](benchmark-results.md). Raw programs and results are preserved under `.scratchpad`.

Primary background references:

- [Glaisher, The Method of Quarter Squares, Nature 40 (1889)](https://www.nature.com/articles/040573c0): historical quarter-square method.
- [GNU MP, Basecase Multiplication](https://gmplib.org/manual/Basecase-Multiplication): rectangular multiplication and symmetric squaring.
- [GNU MP, Karatsuba Multiplication](https://gmplib.org/manual/Karatsuba-Multiplication): three-subproblem divide-and-conquer arithmetic.
- [GNU MP, Multiplication Algorithms](https://gmplib.org/manual/Multiplication-Algorithms): algorithm selection by operand size.
- [WG14 N1570, C11 committee draft (2011)](https://www.open-std.org/jtc1/sc22/wg14/www/docs/n1570.pdf): unsigned conversion, shifts, and signed absolute-value limits.
