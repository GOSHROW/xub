# Portable C version 1: measured results

Measured on 26 October 2026 after the nearby-input dispatch correction. These
results belong to the new limb library in `src/`, independently of the older
scalar/OpenSSL experiments in [benchmark-results.md](benchmark-results.md).

The implementation benefits from selected square structures and repeated sums.
It does **not** beat the tested direct shift/add implementation on general
balanced inputs, short-factor products, or low-64-bit products. Correctness and
useful internal optimizations do not establish general multiplication superiority.

## Results

All times below are median microseconds per operation. Full five-sample minimum,
median, and maximum values and route counters are in the
[archived 32-row CSV](.scratchpad/portable-v1/benchmarks.csv).

| Workload | Candidate | Relevant comparison | Finding |
|---|---:|---:|---|
| Eight-bit balanced odd inputs | AUTO: 0.266 | Direct shift/add: 0.116 | Generic allocated API is slower, despite its small table. |
| 4,096-bit balanced odd inputs | AUTO: 1,316.813 | Direct shift/add: 306.063 | AUTO takes 4.30 times as long. |
| Same 4,096-bit inputs | AUTO: 1,316.813 | Forced recursive: 1,107.594 | Structure classification adds about 19% here. |
| 4,096-bit input times 67 | Blocked: 134.285 | Whole-operand midpoint: 1,306.625 | Blocking improves this implementation by 9.73 times. |
| Same input times 67 | Blocked: 134.285 | Direct shift/add: 0.556 | Blocking still takes about 241 times as long. |
| 4,096-bit square with three set bits | AUTO: 0.920 | Recursive square: 28.613 | AUTO is about 31 times faster than that square route. |
| Same three-set-bit square | AUTO: 0.920 | Direct shift/add: 0.638 | The direct sparse product remains faster. |
| Square of `2^4096-1` | AUTO complement: 0.792 | Recursive square with reuse: 2.699 | Complement path is about 3.41 times faster. |
| Nearby pairs sharing a 4,096-bit magnitude sum | Cached: 1.452 | Ordinary midpoint: 652.938 | About 450 times faster per call after preparation, for this reuse pattern. |
| Same sum, cache preparation | 649.969 | Ordinary product: 652.938 | Setup costs approximately one ordinary product. |
| Low 64 bits of 4,096-bit inputs | Truncated midpoint: 1.542 | Truncated direct shift/add: 0.762 | Midpoint takes 2.02 times as long. |
| Same low-bit demand | Truncated midpoint: 1.542 | Full midpoint then mask: 1,305.938 | Demand-specific computation avoids most full-product work. |

The three-set-bit square is `1 + 2^2053 + 2^4095`. The all-ones square takes
595.203 microseconds with ordinary direct shift/add, but that comparator does
not exploit its dense structure. The fairer within-engine comparison above
uses recursive squaring with equal-half reuse. Neither result implies that
subtraction of squares is uniquely able to exploit these patterns.

The cached workload has eight nearby pairs whose magnitudes sum to the same
4,096-bit value; the individual factors have 4,095 bits. The cached midpoint
square is large, while the difference squares are tiny. Cache-key validation is
included in every timed call. The cost model is `setup + N*cached_time`, versus
`N*ordinary_time`; these medians put setup near the cost of one call, with clear
amortization by two calls. The exact boundary is sensitive to timing variation,
and this experiment does not establish that result for arbitrary cache workloads.

The general API allocates intermediates and carries signs, errors, options, and
counters. Its eight-bit time must not be confused with the historical scalar
512-byte-table routine's roughly 1.5 ns time. A dedicated bounded scalar API
would be a separate implementation profile.

## Methodology and reproduction

Run:

```sh
make benchmark
```

This builds [benchmarks/bench_xub.c](benchmarks/bench_xub.c) against the current
library and writes `build/benchmarks.csv`. The archived measurement and source
hashes are preserved under [.scratchpad/portable-v1](.scratchpad/portable-v1/manifest.json).
Rebuilding after changes produces a new measurement, rather than reproducing
the archived source snapshot automatically.

- Host: ARM64 macOS, Darwin 25.6.0; Apple Clang 17.0.0. CPU model was unavailable
  through the sandbox. No multiplication-limited board or simulator was measured.
- Flags: `-O2 -g -std=c11 -Wall -Wextra -Wpedantic -Werror`. No link-time optimization.
- Time: C `clock()` process CPU time, with `CLOCKS_PER_SEC=1000000`. Five trials
  per row, each at least 20 ms, each covering every input pair. Results are
  amortized per-call CPU costs, not instruction cycles or isolated dependency latency.
- Inputs: eight deterministic fixed-width odd pairs for each balanced case,
  eight long inputs times 67, eight pairs for the modular case, and eight pairs
  sharing one cached sum. The PRNG seed is `0x58554217`; top and low bits are
  forced. Each sparse/dense square case uses one specifically constructed value.
- Inputs and exact reference results are prepared outside timing. Public API
  allocations, dispatch, counters, and result consumption are included. Every
  pair is checked against independent direct shift/add before timing. Low-bit
  outputs are checked against the independently computed exact product residue.
- The direct exact baseline adds a shifted multiplicand for each set bit of the
  shorter factor. The direct modular baseline includes input reduction and
  **truncates every shifted-add row**. Both use the same limb primitives and
  staged output commit as the candidate.
- Runs repeatedly use warm fixtures. Algorithm order is fixed; CPU core,
  frequency, and temperature are uncontrolled. Min/max ranges in the CSV are
  sample ranges, not confidence intervals. Route counters describe the first
  pair, not the average path across all eight pairs.

The current direct baseline is not a tuned Karatsuba/Toom/transform multiplier,
nor a hardware-multiply baseline. Historical comparisons included different
implementations of those controls; their constants cannot be transferred here.
The data establish outcomes for these inputs and implementations, without a
general crossover threshold or target-device performance claim.

## Engineering consequences

1. Keep the exact identity and independent square policies, but treat AUTO
   thresholds as tunable. Structure testing loses time on the sampled random data.
2. Reduce allocation and copying before inferring algorithm-level cost. Blocking
   fixes the width pathology but currently performs hundreds of small allocated
   midpoint calls for a factor that direct shift/add handles with three rows.
3. Preserve nearby inputs before independently removing trailing zeros. The first
   benchmark exposed this issue; the final implementation includes that correction.
4. Cache only demonstrated reuse. This fixed-sum experiment justifies a cache for
   that workload, not an unbounded map of arbitrary squares.
5. Keep modular demand explicit. Truncation is valuable, while the current sparse
   truncated-square backend remains quadratic and is slower than the direct
   truncated baseline here.
6. Measure the intended small ISA, peak working memory, cold-cache behavior, and
   energy before selecting an assembly target or claiming an embedded-device win.

The strict build, 1,583 C checks, 69,303 full-oracle products, UBSan checks, and
their limitations are recorded in [README.md](README.md). Validation reports
are also archived beside the measurements.
