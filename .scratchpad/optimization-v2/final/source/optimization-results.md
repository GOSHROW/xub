# Portable C optimization and allocation measurements

Revision 2, 26 October 2026. Measurements remain on the current ARM64 Mac, as requested. No other processor, board, simulator, or target assembly is evaluated here. The [original portable results](portable-results.md) remain the v1 record; this report distinguishes implementation changes from subsequent threshold tuning.

Revision 2 reduces the measured 4,096-bit random-product time from 1369.438 to 462.375 us, a 2.96-fold improvement over a fresh v1 run, while remaining 1.56 times slower than direct shift/add with reused buffers. Small bounded products and structured operations benefit more. The selected 32-bit cutoff and sparse allowance of 32 reduce the held-out tuning score to 0.4362 of untuned settings on the same optimized code. Reuse removes steady-state allocator calls in the tested fixtures while retaining more heap capacity. These are host-specific results.

## Changes being evaluated

- Each context retains scratch frames and their integer buffers. Recursive siblings and later calls reuse capacities. Successful calls transfer the result to the caller and return the previous output buffer to the scratch pool. Errors preserve the caller's output value.
- Recursive square halves use read-only views of existing limbs. They do not allocate copied high and low halves, and those borrowed views are never freed or returned as owned scratch buffers.
- Squares of at most 32 bits can accumulate the symmetric byte terms in a `uint64_t`. Each off-diagonal byte product still uses the midpoint square table. The general byte basecase remains available below the configured recursion cutoff.
- In the blocked path, a factor at most 255 uses streamed base-256 products and scalar carries. It avoids constructing an arbitrary-precision object for every short block. Larger short factors retain the generic block formulation.
- A cheap predicate examines the complementary distance of an odd square argument before allocating that distance. Unhelpful complement candidates can be rejected without copying their limbs.
- Structural classification runs only above both 16 bits and the configured basecase cutoff. Its effective sparse limit is the smaller of the configured limit and the argument's bit length divided by 16, rounded down. The complement gate uses the same allowance.
- Integer primitives reuse existing capacity, avoid clearing unused capacity, and use bounded bit-scan stages. Writers still initialize every limb they expose as part of a value.

These changes preserve the difference-of-squares kernel and its parity correction. They change buffer ownership and constant factors, not the arithmetic identity or its general asymptotic class.

## Selected defaults and independent tuning check

The installed defaults are AUTO, `leaf_bits=32`, `sparse_limit=32`, enabled dense-complement handling, and `block_ratio=4`. The experiment compares these with fixed control settings of 64, 8, enabled, and 4 on the same optimized implementation. It does not compare those two scores across different code versions.

The refined search measured 18 distinct candidate configurations in two rounds of coordinate descent. A change needed at least a 3% training-score improvement to be accepted. It tested cutoff choices 16/32/64/128/256, sparse limits 0/4/8/16/32, complement on/off, and blocking ratios 0/2/4/8/16; it did not exhaust their Cartesian product. An exploratory first run motivated the classifier refinement. New held-out seeds were fixed for the refined search and did not select its parameters.

Training and validation each have 30 cells and four pairs per cell, drawn from two disjoint seeds per split. Large training sizes are 256 and 2,048 bits; held-out sizes are 512 and 4,096. Small squares use 8/32/64 bits in both splits with different seeds. Parity varies. Seven workload families receive equal weight: balanced, equal, nearby, skewed, sparse squares, dense squares, and small squares. The score is the geometric mean of time ratios within each family and then across the seven families; it is not a total-runtime ratio for a production workload.

Training uses three CPU-time trials of at least 3 ms per cell; held-out comparisons use five trials of at least 10 ms, alternating baseline and selected order. The selected score is 0.4859 on training and 0.4362 on held-out cells, equivalent to a 56.38% reduction in the held-out geometric score. Every held-out family improves in this sample; ratios range from 0.1021 for sparse squares to 0.7709 for small squares. The baseline end/start score is 0.9977, a limited drift check. These results validate a useful host setting, not a global optimum or a bound for unseen inputs.

The full [tuning summary](.scratchpad/optimization-v2/final/tuning-summary.json) and [raw tuning rows](.scratchpad/optimization-v2/final/tuning.csv) preserve the seeds, cell times, ranges, and settings.

## Uninstrumented timing results

The final Apple Clang 17 `-O2 -g` build uses five C `clock()` CPU-time trials per row, each at least 20 ms. Eight deterministic fixed-width odd pairs cover balanced, long-by-short, and modular workloads; eight nearby pairs share one magnitude sum; each sparse/dense square case uses one structured value. Parsing and reference preparation are excluded. Public API work and counters are included. Trials are warm, algorithm order is fixed, and CPU frequency and core selection are uncontrolled. The [45 final rows](.scratchpad/optimization-v2/final/benchmarks.csv) and [32 fresh v1 recheck rows](.scratchpad/optimization-v2/final/v1-recheck.csv) include minima and maxima.

The new direct controls retain their result buffers; the modular control also retains reduced operands and truncates each accumulation. These controls avoid crediting the midpoint method merely for allocation reuse. Times below are microseconds per operation.

| Workload | Fresh v1 | Revision 2 | Revision 2 direct control with reused buffers |
|---|---:|---:|---:|
| Eight-bit product | 0.270 | 0.0316 | 0.0697 |
| Balanced 4,096-bit product | 1369.438 | 462.375 | 296.953 |
| 4,096-bit magnitude times 67 | 138.066 | 1.016 | 0.515 |
| Three-set-bit 4,096-bit square | 0.931 | 0.678 | 0.600 |
| All-ones 4,096-bit square | 0.831 | 0.466 | Not an equally specialized comparator |
| Low 64 product bits of 4,096-bit inputs | 1.592 | 0.951 | 0.485 |

Eight-bit products are 8.55 times faster than v1 and 2.21 times faster than the reused direct control here. The large-by-67 path improves about 136-fold over v1 but still takes 1.97 times as long as its direct control. Sparse-square AUTO loses narrowly to direct shift/add; selecting SPARSE explicitly takes 0.558 us in that case. The all-ones AUTO square beats forced recursive squaring at 0.945 us, while the direct control does not recognize that structure. The low-bit midpoint path still takes 1.96 times as long as the fair truncated direct comparison.

Trimming scratch before every operation, including the trim cost, raises the 4,096-bit midpoint median to 508.188 us and the eight-bit median to 0.145 us. These are workspace-release experiments, not cold-cache or process-startup latency measurements. Even their comparison with warm calls does not isolate all allocation costs from the other code changes.

For nearby pairs with a shared magnitude sum, cached calls take 1.083 us versus 218.852 us ordinarily; preparation takes 218.703 us. An additive setup-plus-per-call model predicts amortization after two or more products in this fixture. An entire repeated-call batch was not separately timed. Distant fixed-sum pairs can retain a large second square and need separate measurement.

## Context ownership and lifetime

`xub_context_init` now starts an owning context. It must not be shallow-copied, and it must be freed before being discarded or reinitialized. Each thread uses its own context.

`xub_context_trim` releases retained scratch storage between public calls while preserving options, the square table, and counters. Caller-owned results and cache values remain valid. `xub_context_free` releases scratch and clears the context; call `xub_context_init` before using it again.

Retaining buffers is useful for repeated operations. A one-shot call or a small call following a much larger call may prefer an explicit trim afterward. The library remains dynamically allocated: zero allocation calls in a warmed experiment do not establish a general no-heap contract, a fixed memory budget, or constant-time execution.

## Allocation methodology

The standalone profiler is [profile_xub.c](benchmarks/profile_xub.c), with wrappers in [alloc_profile.c](benchmarks/alloc_profile.c) and [alloc_profile.h](benchmarks/alloc_profile.h). `make profile` compiles only the library objects with allocation-call replacement. The wrapper and harness use ordinary compilation; production and timing builds do not contain the replacements.

The wrappers count calls to `malloc`, `calloc`, `realloc`, and `free`, successful fresh blocks and growth operations, failures, currently live requested payload, and peak live requested payload. An aligned private header records each block's requested size. Reported bytes exclude that profiler header, allocator metadata, allocator-internal temporary copies, stack storage, and process RSS. A `free(NULL)` is a function call but releases no tracked block; the CSV reports both counts.

Before each measured interval, counters reset while existing live-byte and block totals remain intact. Inputs and an independently computed shift/add result are prepared outside the interval. They remain live and are included in the reported baseline. Peaks therefore include those fixtures; the CSV also records the peak increment above the interval baseline. Reference arithmetic shares the library's primitive addition routines, and the separate Python oracle supplies independent integer verification.

The five cases each use one deterministic pair, with random magnitudes forced to the specified width and to odd parity. The fixed-sum case uses nearby 4,095-bit factors whose sum is 4,096 bits; its cache is prepared first, and preparation is reported separately. The modular case requests only the low 64 product bits of 4,096-bit inputs.

Each case records its first call, immediate first repeat, and a steady repeat after five preceding calls in total. It then records context trimming, freeing the trimmed context, and complete fixture cleanup. Context options, table, counters, and the independently owned result are checked across trimming. The same harness also compiles with `XUB_PROFILE_V1` against the archived v1 headers and sources; compatibility context cleanup is a no-op because that context owned no workspace.

The final comparison uses each library's actual defaults and records them in CSV comments: v1 uses cutoff 64/sparse limit eight; revision 2 uses cutoff 32/sparse limit 32. Both enable complement handling and use blocking ratio four. It therefore compares the completed versions, including tuning. The [first-pass archive](.scratchpad/optimization-v2/pass1/manifest.json) separately preserves the pre-tuning comparison at then-identical settings.

The final raw files are [v1 allocations](.scratchpad/optimization-v2/final/allocations-v1.csv) and [revision 2 allocations](.scratchpad/optimization-v2/final/allocations.csv), alongside their [source record](.scratchpad/optimization-v2/final/manifest.json). Reproduce the profiles with `make profile profile-v1`. This intrusive profiler provides no elapsed-time or CPU-time comparison.

## Final allocation traffic and retained memory

An allocation attempt is a source call that requests storage, including `realloc(NULL, size)` and growth of an existing block. Reusing an existing capacity does not count as an attempt. No injected failures occur in the table below.

| Workload | V1 first call | Revision 2 first call | V1 steady repeat | Revision 2 steady repeat |
|---|---:|---:|---:|---:|
| Balanced 4,096-bit product | 14,567 | 205 | 14,567 | 0 |
| Eight-bit product | 6 | 3 | 6 | 0 |
| 4,096-bit magnitude times 67 | 2,871 | 5 | 2,871 | 0 |
| Nearby fixed-sum cached product | 6 | 8 | 6 | 0 |
| Low 64 bits of a 4,096-bit product | 10 | 12 | 10 | 0 |

The first repeat is not always fully warmed: the balanced product makes two allocation attempts on that repeat as ownership rotates between output and scratch buffers. The other cases need one or two. The reported zero-attempt state follows further repetitions of the same operation on the same prepared values. A different shape, larger operand, different mode, or trimmed context may allocate again.

The retained capacity has a measurable cost. The following are requested heap-payload bytes, including prepared inputs, reference results, output, cache, and context allocations. They are not total working RAM or resident memory.

| Workload | V1 steady-call peak | Revision 2 steady-call peak | Revision 2 live bytes after trim |
|---|---:|---:|---:|
| Balanced 4,096-bit product | 18,176 | 37,440 | 5,120 |
| Eight-bit product | 80 | 384 | 32 |
| 4,096-bit magnitude times 67 | 4,168 | 4,776 | 2,568 |
| Nearby fixed-sum cached product | 11,792 | 12,136 | 8,192 |
| Low 64 bits of a 4,096-bit product | 3,152 | 3,832 | 3,080 |

For the balanced case, 32,320 bytes remain in the context beyond the 5,120-byte fixture/output baseline. Trimming returns to that baseline without invalidating the result. Cold cached and modular calls also make slightly more allocation attempts than v1; the benefit is repeated reuse, not a universal improvement on the first call. Every case returns to zero tracked live blocks and bytes after complete cleanup.

## Allocation failure and cleanup checks

The profiler injects failure at every allocation position of a deterministic 128-bit multiplication, both with a fresh context and after a 64-bit warmup. Each failure must return `XUB_ENOMEM`, preserve an existing negative output value, and permit a successful retry after failure injection is disabled. Releasing all objects must leave zero tracked blocks and bytes.

Revision 2 passes 49 cold and 34 warmed-growth failure positions. The archived v1 implementation passes 56 positions in each case. Including wrapper alignment, retained-count reset, failed-reallocation preservation, zero initialization, overflow rejection, result, trim, and cleanup checks, the harness reports 673 checks for revision 2 and 847 for v1. The differing totals reflect their different numbers of allocation positions; they are not a measure of relative correctness.

These injection sweeps cover the stated multiplication paths. They do not claim exhaustive coverage of allocation failures in every public operation, every input, or every thread interleaving. The wrapper is deliberately single-threaded and is excluded from production builds.

The final production build also passes 12,966 C checks and the 69,303-product Python oracle. UBSan passes the C suite and a 3,275-product quick oracle. Reports and source hashes are preserved in the [final archive](.scratchpad/optimization-v2/final/manifest.json). AddressSanitizer remains unavailable because its runtime stalls before program entry on this host.

## Host tooling and limits

Full Xcode and its profiling tools are installed. Instruments CLI help is available, but template enumeration aborts when it tries to create its cache outside the workspace's permitted directories. No Instruments trace is claimed; the source wrappers supply the reproducible allocation counts here.

Timing conclusions above come from the separate uninstrumented runs. Eliminating allocator calls alone does not establish a product speedup: limb scans, shifts, additions, classification, and recursion still take time. Measurements on this Mac do not establish speed, energy use, or code size on hardware without a multiplier.
