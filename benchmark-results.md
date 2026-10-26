# Measured speed and tradeoffs

Date: 2026-10-26. These are exploratory native C measurements, not the final C/ASM deliverable.

Small bounded tables provide the clearest demonstrated advantage over software multiplication. The literal midpoint routine does not show a robust general large-integer advantage over the appropriate direct software comparisons in this experiment. Nearby inputs approach a tie; sparse and unequal inputs often lose substantially. These findings apply to the measured implementations and workloads, not to every possible implementation of the identity.

## What was measured

- ARM64 macOS host, Darwin 25.6.0; Apple Clang 17, `-O3`, no link-time optimization. No multiplication-limited target board or cycle-accurate target simulator was available.
- Small inputs: 8, 16 and 32 bits, 4,096 pregenerated pairs per workload, seven trials.
- Large inputs: 64 through 16,384 bits, eight pregenerated pairs per workload, five trials. OpenSSL 3.6.3 supplies BIGNUM storage, add/subtract/shift operations and native controls.
- Each sample targeted approximately five milliseconds; algorithm order was shuffled. Tables and temporary buffers were warm. Independent suites ran sequentially.
- Medians include dispatch and checksum overhead. Raw CSV includes minimum and maximum. CPU frequency, core selection and affinity were uncontrolled.
- Custom arithmetic kernels were inspected for multiplication instructions; small kernels have none. Large custom square/product kernels have neither multiply instructions nor calls to native multiplication. Native controls and verification intentionally use them; every instruction inside the linked library was not audited.

## Small integers: measured table advantage

| Workload | Candidate | Table bytes | Candidate ns/product | Comparison | Comparison ns/product | Comparison / candidate |
|---|---|---:|---:|---|---:|---:|
| Eight-bit random | `midpoint_table8` | 512 | 1.51 | `shift_add` | 5.37 | 3.56x |
| Eight-bit random | `quarter_table8` | 1,024 | 1.13 | `full_product_table8` | 1.14 | 1.01x |
| Sixteen-bit random | `midpoint_table16` | 262,144 | 1.45 | `software_karatsuba` | 8.61 | 5.95x |
| Thirty-two-bit random | `midpoint_recursive` | 512 | 36.11 | `shift_add` | 18.44 | 0.51x |

The eight-bit full product table occupies 128 KiB; the quarter-square table occupies 1 KiB. Their measured throughput is indistinguishable near the call/harness floor, giving a 128-fold table-memory reduction with comparable measured throughput in this warm workload. The 512-byte ordinary-square table uses half the quarter-square storage and takes slightly longer.

The 16-bit square table occupies 256 KiB, which may be too large for a small device. A 32-bit whole-input square table would occupy 32 GiB, so this approach does not scale to arbitrary operand widths. Recursive use of the small table is evaluated separately.

Native multiplication and the call/harness floor are both about 1.1 ns/product in these small tests. Table timings close to that floor cannot establish exact instruction latencies or a win over a hardware multiplier. The software-Karatsuba eight-bit base case itself uses the midpoint table; comparing the direct leaf against that wrapper would mostly measure dispatch.

## Thirty-two-bit workloads

| Pattern | Best tested midpoint | Midpoint ns | Appropriate direct method | Direct ns | Midpoint / direct |
|---|---|---:|---|---:|---:|
| random | `midpoint_recursive` | 36.11 | `shift_add` | 18.44 | 1.96x |
| near | `midpoint_recursive` | 19.56 | `shift_add` | 18.37 | 1.06x |
| equal | `midpoint_recursive` | 19.40 | `equal_aware_recursive` | 18.43 | 1.05x |
| sparse | `midpoint_set_bits` | 25.29 | `sparse_multiply` | 4.74 | 5.33x |
| dense | `midpoint_recursive` | 38.67 | `shift_add` | 18.50 | 2.09x |
| times_one | `midpoint_recursive` | 36.13 | `sparse_multiply` | 1.51 | 23.90x |
| times_byte | `midpoint_recursive` | 36.06 | `shift_add` | 7.45 | 4.84x |
| times_power2 | `midpoint_recursive` | 36.17 | `sparse_multiply` | 1.51 | 23.98x |

Ratios above one in this table mean the midpoint method took longer. Nearby/equal operands narrow the difference, but do not show an advantage over the appropriate comparator.

## Large integers: software arithmetic comparisons

The primary large-number results below use the tuned 32-bit scalar leaves. Both methods remain multiply-free in their custom arithmetic. The square leaf uses three-square recursion and the same 512-byte table; direct-product leaves use scalar set-bit shift-and-add. This removes obvious small-leaf BIGNUM API overhead without claiming fully optimized limb code.

The matrix reports **direct time / midpoint time**. Above 1 favors midpoint; below 1 favors direct multiplication. Values very close to 1 should be treated as ties for conclusions here.

| Pattern | 64 bits | 256 bits | 1,024 bits | 4,096 bits | 16,384 bits |
|---|---:|---:|---:|---:|---:|
| random | 0.56x | 0.70x | 0.65x | 0.73x | 0.74x |
| near | 0.92x | 1.04x | 1.00x | 1.00x | 1.00x |
| equal | 0.76x | 0.96x | 0.99x | 0.99x | 1.00x |
| sparse | 0.47x | 0.21x | 0.11x | 0.074x | 0.34x |
| dense | 0.65x | 0.63x | 0.54x | 0.34x | 0.26x |
| short8 | 0.24x | 0.026x | 0.00523x | 0.00168x | 0.000752x |
| one | 0.090x | 0.0087x | 0.0013x | 0.000304x | 0.000125x |
| power2 | 0.25x | 0.095x | 0.022x | 0.00837x | 0.00658x |

Each cell selects the best tested midpoint evaluator and the best eligible direct software comparison for that dataset. This is retrospective selection, not an implemented dispatcher; automatic classification would have its own cost. At 16,384 bits the quadratic methods were omitted to bound run time, so the comparisons are among the methods actually measured there. Use the 4,096-bit row details below when comparing all software families.

| 4,096-bit pattern | Midpoint evaluator | Midpoint microseconds | Direct comparison | Direct microseconds |
|---|---|---:|---|---:|
| random | `mid_recursive` | 379.312 | `direct_karatsuba` | 277.417 |
| near | `mid_recursive` | 190.469 | `near_recursive` | 190.281 |
| equal | `mid_recursive` | 191.688 | `recursive_equal_aware` | 189.719 |
| sparse | `mid_recursive` | 89.859 | `shift_add_short` | 6.667 |
| dense | `mid_recursive` | 99.175 | `recursive_equal_aware` | 33.263 |
| short8 | `mid_recursive` | 380.750 | `shift_add_short` | 0.640 |
| one | `mid_recursive` | 381.938 | `shift_add_short` | 0.116 |
| power2 | `mid_recursive` | 67.542 | `direct_karatsuba` | 0.566 |

Equal-input controls explicitly square. Near-input controls evaluate a^2+a(b-a). Short-operand controls scan the shorter factor; sparse controls can count and choose the sparser factor. Thus apparent wins over a baseline that ignores known structure are not credited as general advantages.

### Effect of the single recursion-cutoff experiment

| Random input bits | Midpoint recursion, 8-bit BN leaves (microseconds) | 32-bit scalar leaves (microseconds) | Speedup from cutoff change |
|---:|---:|---:|---:|
| 64 | 3.211 | 0.433 | 7.41x |
| 256 | 29.994 | 4.441 | 6.75x |
| 1,024 | 272.333 | 41.180 | 6.61x |
| 4,096 | 2381.125 | 379.312 | 6.28x |
| 16,384 | 21372.625 | 3426.750 | 6.24x |

This substantial improvement shows why raw prototype timing is not a mathematical lower bound. It also did not produce a robust general advantage over the tuned direct comparisons. Leaf-32 and leaf-8 product runs use identical generated inputs.

## The cost of the wrapper with optimized native squares

This separate control uses OpenSSL squares and hardware-supported arithmetic. It isolates the practical cost of the midpoint transformation from our experimental software square kernels.

| Bits / pattern | Direct native multiply (microseconds) | Midpoint with native squares (microseconds) | Structure-aware native control (microseconds) |
|---|---:|---:|---:|
| 1,024 / random | 0.231 | 0.577 | 0.235 |
| 1,024 / near | 0.231 | 0.365 | 0.330 |
| 1,024 / equal | 0.232 | 0.318 | 0.239 |
| 4,096 / random | 2.819 | 5.861 | 2.804 |
| 4,096 / near | 2.846 | 3.118 | 3.072 |
| 4,096 / equal | 2.842 | 2.912 | 2.686 |
| 16,384 / random | 29.756 | 56.932 | 29.619 |
| 16,384 / near | 29.420 | 29.156 | 28.824 |
| 16,384 / equal | 29.466 | 28.054 | 27.261 |

## Does the direct bitwise square help?

These are standalone squares, without the midpoint wrapper. All times are microseconds per square. The set-bit method scans bit positions through the BIGNUM API and performs one wide accumulation per set bit.

| Bits / pattern | Set-bit square | Recursive square | Bit-prefix square | Native square | Recursive / set-bit |
|---|---:|---:|---:|---:|---:|
| 1,024 / random | 29.142 | 20.554 | 41.383 | 0.226 | 0.71x |
| 1,024 / sparse3 | 1.764 | 8.244 | 22.082 | 0.223 | 4.67x |
| 1,024 / dense | 47.545 | 7.744 | 52.202 | 0.227 | 0.16x |
| 1,024 / power2 | 1.636 | 4.769 | 22.147 | 0.222 | 2.92x |
| 1,024 / near_power2_plus_byte | 1.819 | 6.934 | 22.237 | 0.224 | 3.81x |
| 4,096 / random | 378.375 | 187.750 | 495.125 | 2.632 | 0.50x |
| 4,096 / sparse3 | 6.743 | 44.533 | 283.375 | 2.503 | 6.60x |
| 4,096 / dense | 718.125 | 35.215 | 658.625 | 2.184 | 0.05x |
| 4,096 / power2 | 6.432 | 20.339 | 283.667 | 2.121 | 3.16x |
| 4,096 / near_power2_plus_byte | 6.935 | 32.913 | 287.500 | 2.466 | 4.75x |

A fast square for a sparse value does not imply a fast product of sparse inputs. For x=1 and y=2^n, the midpoint is a power of two, but the half-difference is 2^(n-1)-1, containing a long run of ones. Pure powers of two also admit a simpler direct shift than either generic squarer; the square-only table is a comparison of the listed evaluators, not a claim of optimal handling of that structure.

## Table construction, coverage, and limits

Warm table rebuild medians were measured separately. These are not cold startup costs; ROM tables have no runtime construction cost.

| Table | Bytes | Warm rebuild nanoseconds |
|---|---:|---:|
| square8 | 512 | 179.7 |
| square16 | 262,144 | 49695.3 |
| quarter8 | 1,024 | 367.2 |
| product8 | 131,072 | 2648.4 |

Correctness passed exhaustive eight-bit pairs, all 16-bit square values, 100,000 random 32-bit pairs and boundary cases in the small suite. Large validation passed the table rule exhaustively and 433 boundary/larger pairs across 12 product implementations, plus scalar leaf tests and every measured dataset against native multiplication. Square-only datasets were checked against native squaring. These checks do not establish speed on another device.

Important practical limits:

- Measurements are warm throughput, not cold-cache or dependency-chain latency. The eight-bit full-product table accesses an upper-right logical quadrant for exact-width random operands, and the 16-bit table reuses a 4,096-pair working set.
- Host bit-count/leading-zero/trailing-zero instructions may be unavailable or more expensive on a multiplication-limited device.
- OpenSSL API calls, bit scans, and temporary-buffer management are part of the big-number prototype costs. Hand-written limb code could change thresholds and constants substantially.
- No energy, cold-cache behavior, peak working RAM, or million-bit timing was measured. Tables have exact reported storage sizes; those are not total program-memory figures.
- Cached repeated-midpoint workloads, complement/run-of-ones square shortcuts, other leaf sizes, and a target-specific ASM implementation remain unmeasured. They should not be described as measured wins or losses from this experiment.

## Reproduction and raw artifacts

```sh
clang -O3 -std=c11 -Wall -Wextra .scratchpad/bench_small.c -o .scratchpad/small-bench
.scratchpad/small-bench > .scratchpad/small-results.csv 2> .scratchpad/small-run.log
```

Build/run commands for both large variants are in [large methodology](.scratchpad/large-methodology.md). For the square-only suite, use the same OpenSSL include and link flags with `-DSCALAR_LEAF_BITS=32`, compile `.scratchpad/bench_squares.c`, and run `.scratchpad/square-bench --output .scratchpad/square-results.csv`. Run timing suites sequentially.

- [Small raw CSV](.scratchpad/small-results.csv), [run metadata](.scratchpad/small-run.log), [assembly audit](.scratchpad/small-assembly-audit.json).
- [Large initial CSV](.scratchpad/large-results.csv), [tuned CSV](.scratchpad/large-leaf32-results.csv), [tuned run metadata](.scratchpad/large-leaf32-run.log).
- [Square-only CSV](.scratchpad/square-results.csv), [square metadata](.scratchpad/square-metadata.txt).
- [Operation vectors](.scratchpad/cost-model.json) describe a separate Python model, not cycles or native instruction counts. They explain structural costs without predicting target timing.
- [Machine-readable comparison summary](.scratchpad/measurement-summary.json).

Regenerate this report: `python3 .scratchpad/summarize_benchmarks.py`.
