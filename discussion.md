# Request and decisions

## Original request — 2026-10-26

The following is the user's initial prompt, retained verbatim for continuity:

> when we multiply two natural numbers x, y through a traditional computer it requires x(i) digit being multiplied by y(j) and then summed, right. or the other being to shift the constants  by poweres of two and combine them. even otherwise we have measures like booth's algorithm but signed bit is not something i value very highly since what can be applied for two natural numbers can be extended to zero and negatives by flipping bits. i want to be able to calculate numbers beyond the normal stretch of finiteness in a more optimised manner.
>
> below is my thesis:
>
> now, for any x, y, we will have m=(x+y)/ 2 and k=m-x=y-m. irrespective of x<y, x=y, x>y.
>
> m=x/2 + y/2 which are both a right shift operation. We decompose it since x+y might as well exceed the range (reasonable though since multiplication will surely exceed the range).
>
> let us look at last bit of x and then y. if both are zero, just a shift operation and then summation is fine. if both are one, we right shift, truncate and then add a one to the final summation. for exclusively one of these x and y final bits being 1, we should continue with right shift truncate and store the fact of extra one bit being to an external register.
>
> if m has this register entry for a hanging 0.5, then k is also having the hanging bit for 0.5 by virtue.
>
> now, the product of x and y is technically (x) * (y) = (m-k)*(m+k) = m^2 - k^2
>
> for m ending is 0.5, its square ends in 0.25 which is also the case when k squared ends in 0.25.
>
> and subtraction of the squared values is simple on the bitwise manner so pretty optimised.
>
> still one of the open items is how to get the squares fast and i need your help in objective 1> find a suitable manner to find the squares through natural bitwise symmetry of the numbers perhaps. i was initially latching onto storing an entire map of numbers as such:
>
> number x: square of x: (square of (x + 0.5)) - 0.25 . onjective 2> if going with this approach, leverage a smart way to do so.
>
> objective 3> judge the entire algorithm against its bests and its pitfalls. what tradeoffs do we make and whether it truly does optimise anything. ofc the presumption is that addition (by extension subtraction) is an easier operation for register bit computation than for the multiplication.
>
> objective 4> port the final solution after all iterations of discussion onto a C / ASM code + a Latex / MD file explaining neatly what we are trying to do. this is to be done at the end of it all.
>
> nb>  feel free to use the .scratchpad for any new methods or stuff you need to write out. maintain documentation within this xub for what we are achieveing or not (including the prompts if relevant)

## Workload clarification — same session

Assistant question:

> Which workload should guide the experiments? I'll start with general arbitrary-precision integers unless you have a more specific target.

User answer:

> Hardware with limited multiplication support but not very specific to just small integers. perhaps make a different plan for small integers and then a different plan for general large integers or numbers with structure. just keep the underlying thesis correct and redirect to this subtraction of squares as a common code.

Consequences for the design:

- Keep one subtraction-of-squares multiplication routine.
- Adapt the square evaluator to small, large, and structured values.
- Treat limited hardware multiplication as the primary setting.
- Evaluate against software multiplication as well as any native baseline.
- Preserve final C/ASM and polished write-up as end-of-discussion deliverables.

## Findings after the first discussion

Established: an exact integer-only midpoint formula; a multiplication-free
three-square recursive evaluator; redundant half-integer table entries; the
exponential size of full-range tables; passing finite correctness checks.

Proposed: small tables as recursion leaves, square-specific structural
optimizations, and platform-specific threshold tuning.

Unresolved: actual speed, memory/latency tradeoffs on the intended device,
appropriate native limb size, table size, ASM ISA, and which structural cases
justify specialization. No measured speedup or novelty claim is recorded.

## Bitwise squaring and objective confirmation — same session

User:

> use the bitwise representaion of numbers for squaring if it helps. also let me know if you understood the overall objective of what we are doing

Working interpretation: build an exact multiplication method for arbitrary-size
natural numbers, especially on hardware with weak multiplication support, using
subtraction of squares as the shared multiplication routine. Exploit binary
structure, shifts, additions, subtraction, and bounded tables inside square
evaluation; select methods appropriate to small, large, and structured inputs.
Assess actual costs and limitations. Preserve final C/ASM and polished documents
as end-of-discussion deliverables.

This iteration added a direct set-bit square to the scratch reference. It groups
all cross terms associated with one bit into one shifted row, combines the
disjoint diagonal with OR, and adds the row with carry handling. The evaluator
uses one accumulation per set bit and O(s*n) bit work for s set bits in an n-bit
input. It is a sparse-input candidate, not a universal improvement. Updated
checks include sparse and alternating patterns and pass all three evaluators;
performance and dispatch thresholds remain unmeasured.

## Request for measurements — same session

User:

> Measure the advantages of speed or as to where it is advantageous and where it is not

This authorizes native benchmark prototypes now while preserving the final
C/ASM implementation as a later design deliverable. The measurement work used
the available ARM64 host and existing OpenSSL library; no target board or
cycle-accurate simulation of a multiplication-limited ISA was available.

Completed: small native product benchmarks; arbitrary-precision benchmarks with
eight-bit BIGNUM leaves and then thirty-two-bit scalar leaves; standalone square
benchmarks; generated-assembly inspection; correctness checks; and reproducible
raw CSV, metadata, and report generation.

Observed: small bounded tables can outperform software multiplication and save
large amounts of table memory. Sparse standalone set-bit squares beat the
recursive software square. The current full midpoint method does not show a
robust general large-integer win over the appropriate direct software baselines;
nearby values approach a tie, and sparse or short-factor products can lose badly.

See [measured results](benchmark-results.md) for times, comparator definitions,
scope, and limitations. These results describe the measured prototypes and host,
not every implementation or the unselected target device.

## Further improvements — same session

User:

> what further improvements do you see as possible

The response prioritizes changes supported by the observed costs while preserving
the common subtraction-of-squares method. Detailed proposals are in
[further improvements](improvements.md). These include dense complementation,
local recursive reuse, trailing-zero normalization, short-factor chunking through
the original core, independent square dispatch, representation improvements,
bounded table tuning, reuse-aware caching, and a fused square-difference evaluator.

Scratch checks verified the complement, reuse, chunked product, and fused
recurrence identities. They are correctness checks only. No prior timing files
were replaced and no speedup from the proposed changes has been measured.

## Edge cases — same session

User:

> also figure out edge cases to this problem such as 1000000000*1, 67*68, -4523*-3412 etc.

Added [edge-case documentation](edge-cases.md) and a signed correctness harness.
The original unsigned core is retained behind sign/magnitude normalization.
The requested results are 1,000,000,000; 4,556; and 15,432,476 respectively.
Unit magnitude, consecutive magnitudes, and two negative signs exercise
different paths. Additional cases include zero, all sign/parity combinations,
minimum signed values, table boundaries, carries, and complement termination.

The review also established that full square intermediates can be wider than
the product, while explicitly modular squares can recover an exact product
when its output-width bound is known. Quarter-square division needs two extra
bits before shifting. These observations were checked in scratch Python;
the native benchmark results and final C/ASM deliverable status are unchanged.

## Portable implementation and version 1 thesis — same session

User:

> are we in a state to start coding then and finalising our thesis, or any more caveats to look into? branch out cases for different demands in the multiplication operation

Assistant question:

> Which assembly target should accompany the portable C implementation? I’ll use the current ARM64 Mac for executable validation unless you specify another target.

User answer:

> Portable C first; choose assembly later

Decision: implement the settled integer-only design as portable C11, with a
library and CLI, and finalize matching Markdown/LaTeX version 1 documents.
Keep assembly as a later target-specific task. The claim remains an exact
structure-aware multiplication architecture; general speed superiority has not
been established.

Implemented: signed magnitude storage; zero/unit/equal/adjacent reductions;
trailing-zero normalization; blocked unequal-length multiplication through the
same midpoint kernel; table, symmetric byte, sparse, recursive, complemented,
and prefix squares; fixed magnitude-sum caching; and genuinely truncated
modular products. General fused square-difference recursion remains research.

Validation: strict C11 build, 1,583 C checks, and 69,303 Python-oracle products,
including every signed eight-bit pair and operands through 16,384 bits. UBSan
also passes the API checks and 3,275 quick-oracle products. Independent review
checked another 1,280 cases with aliases, alternate thresholds, caches, highly
unequal factors, and residue widths. Clang static analysis emitted no diagnostics.
ASan stalls before main on this host and is explicitly not reported as passing.

New portable-library measurements are kept separate from the historical
prototype results. The build, API, workload branches, and reproduction commands
are documented in [README.md](README.md); the final account is in
[thesis.md](thesis.md) and [thesis.tex](thesis.tex). No TeX compiler is installed,
so the LaTeX source is delivered without claiming a compiled PDF.

The first portable-library benchmark exposed a dispatch caveat: independently
stripping trailing zeros could destroy proximity of unequal inputs. The exact
dispatcher now preserves the original midpoint whenever the difference's bit
length is at most half the larger factor's bit length. This keeps the second
square short. It is a configurable-future heuristic, currently a fixed v1 rule;
it does not establish optimal dispatch for every pattern.

## Allocation and dispatch optimization — same session

User, accepting the proposed next improvements:

> Let us do these

Assistant clarification:

> Which hardware should guide target validation? RV32I without the M extension is a useful reference because it has no integer multiply instruction; actual device timing will still need a board or suitable simulator.

User answer:

> Keep measurements on the current Mac for now

Scope: reduce temporary allocation/copying, tune dispatch on training inputs,
validate against separate held-out inputs, and keep all measurements on the Mac.
The original v1 source and documentation are preserved under
`.scratchpad/portable-v1/source`, matching the previously archived source hashes.

Implementation changes include context-owned reusable scratch frames, explicit
context trim/free operations, capacity-retaining setters, carry and aligned-shift
improvements, read-only recursive split views, scalar 32-bit square leaves built
from the midpoint byte table, streamed byte products for small blocked factors,
and complement classification before allocation. The arithmetic identity and
public transactional-output guarantees are retained.

Allocator profiling is separate from timing. It measures actual allocation
calls and retained payload, and injects allocation failures to check recovery
and output preservation. Tuning uses disjoint training and held-out seeds and
widths, with structured and mixed-parity workloads. Host-tuned defaults do not
constitute claims about a multiplication-limited device.

The first search's training data favored disabling sparse selection to reduce
classification overhead, with a regression on sparse squares. That motivated a
second implementation pass: skip classification in the cheap scalar leaves and
cap the sparse count by input density. The second search fixed new held-out
seeds before measurements. It selected leaf_bits=32, sparse_limit=32, complement
enabled, and block_ratio=4. All seven held-out groups improved versus the
optimized implementation with its original parameter settings; the equal-group
geometric time ratio was 0.4362. Both searches remain archived.

Final validation passed 12,966 C checks, 69,303 oracle products, UBSan, and 673
allocation-profile checks including all 49 cold and 34 warmed-growth failure
positions in the tested allocation traces. Fresh measurements against rebuilt
v1 show 2.96-fold faster sampled general 4,096-bit products and approximately
136-fold faster 4,096-bit products by 67. The stronger direct comparison also
reuses buffers; general products remain 1.56 times slower than that baseline.

Final sources, hashes, tuning data, timing data, and memory profiles are in
`.scratchpad/optimization-v2/final`. [The optimization report](optimization-results.md)
records the retained-memory tradeoff and current limitations. Assembly and
hardware-target measurements remain deferred by the user's explicit choice.
