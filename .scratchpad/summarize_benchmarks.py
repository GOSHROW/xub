#!/usr/bin/env python3
"""Regenerate the measurement report from the recorded native CSV files."""
from pathlib import Path
import csv
import json
import platform
import re

ROOT = Path(__file__).resolve().parent.parent
SCRATCH = ROOT / '.scratchpad'


def load(name, method_column='algorithm'):
    rows = list(csv.DictReader((SCRATCH / name).open()))
    result = {}
    for row in rows:
        for key in ('median_ns', 'min_ns', 'max_ns'):
            row[key] = float(row[key])
        assert 0 < row['min_ns'] <= row['median_ns'] <= row['max_ns']
        key = (int(row['bits']), row['pattern'], row[method_column])
        assert key not in result
        result[key] = row
    return result


small = load('small-results.csv', 'method')
old = load('large-results.csv')
large = load('large-leaf32-results.csv')
squares = load('square-results.csv')


def ns(data, bits, pattern, method):
    return data[bits, pattern, method]['median_ns']


def best(data, bits, pattern, names):
    available = [n for n in names if (bits, pattern, n) in data]
    return min(available, key=lambda n: ns(data, bits, pattern, n))


MID = ('mid_recursive', 'mid_set_bits', 'mid_prefix')
DIRECT = ('direct_karatsuba', 'recursive_equal_aware', 'shift_add_short',
          'shift_add_sparse', 'near_recursive')
PATTERNS = ('random', 'near', 'equal', 'sparse', 'dense', 'short8', 'one', 'power2')
WIDTHS = (64, 256, 1024, 4096, 16384)
summary = {'purpose': 'Measured warm native throughput; no weak-device cycle claim.',
           'environment': {'machine': platform.machine(), 'system': platform.system(),
                           'release': platform.release()}, 'large_comparisons': []}
for bits in WIDTHS:
    for pattern in PATTERNS:
        m = best(large, bits, pattern, MID)
        d = best(large, bits, pattern, DIRECT)
        summary['large_comparisons'].append({
            'bits': bits, 'pattern': pattern, 'midpoint': m, 'direct': d,
            'midpoint_ns': ns(large, bits, pattern, m),
            'direct_ns': ns(large, bits, pattern, d),
            'speedup_direct_over_midpoint': ns(large, bits, pattern, d) / ns(large, bits, pattern, m),
        })

lines = []


def add(text=''):
    lines.append(text)


add('# Measured speed and tradeoffs')
add('')
add('Date: 2026-10-26. These are exploratory native C measurements, not the final C/ASM deliverable.')
add('')
add('Small bounded tables provide the clearest demonstrated advantage over software multiplication. '
    'The literal midpoint routine does not show a robust general large-integer advantage over the '
    'appropriate direct software comparisons in this experiment. Nearby inputs approach a tie; '
    'sparse and unequal inputs often lose substantially. These findings apply to the measured '
    'implementations and workloads, not to every possible implementation of the identity.')
add('')
add('## What was measured')
add('')
add('- ARM64 macOS host, Darwin 25.6.0; Apple Clang 17, `-O3`, no link-time optimization. '
    'No multiplication-limited target board or cycle-accurate target simulator was available.')
add('- Small inputs: 8, 16 and 32 bits, 4,096 pregenerated pairs per workload, seven trials.')
add('- Large inputs: 64 through 16,384 bits, eight pregenerated pairs per workload, five trials. '
    'OpenSSL 3.6.3 supplies BIGNUM storage, add/subtract/shift operations and native controls.')
add('- Each sample targeted approximately five milliseconds; algorithm order was shuffled. '
    'Tables and temporary buffers were warm. Independent suites ran sequentially.')
add('- Medians include dispatch and checksum overhead. Raw CSV includes minimum and maximum. '
    'CPU frequency, core selection and affinity were uncontrolled.')
add('- Custom arithmetic kernels were inspected for multiplication instructions; small kernels '
    'have none. Large custom square/product kernels have neither multiply instructions nor '
    'calls to native multiplication. Native controls and verification intentionally use them; '
    'every instruction inside the linked library was not audited.')
add('')
add('## Small integers: measured table advantage')
add('')
add('| Workload | Candidate | Table bytes | Candidate ns/product | Comparison | Comparison ns/product | Comparison / candidate |')
add('|---|---|---:|---:|---|---:|---:|')
for bits, method, memory, direct, label in (
    (8, 'midpoint_table8', 512, 'shift_add', 'Eight-bit random'),
    (8, 'quarter_table8', 1024, 'full_product_table8', 'Eight-bit random'),
    (16, 'midpoint_table16', 262144, 'software_karatsuba', 'Sixteen-bit random'),
    (32, 'midpoint_recursive', 512, 'shift_add', 'Thirty-two-bit random'),
):
    m, d = ns(small,bits,'random',method), ns(small,bits,'random',direct)
    add(f'| {label} | `{method}` | {memory:,} | {m:.2f} | `{direct}` | {d:.2f} | {d/m:.2f}x |')
add('')
add('The eight-bit full product table occupies 128 KiB; the quarter-square table occupies 1 KiB. '
    'Their measured throughput is indistinguishable near the call/harness floor, giving a '
    '128-fold table-memory reduction with comparable measured throughput in this warm workload. '
    'The 512-byte ordinary-square table uses half the quarter-square storage and takes slightly longer.')
add('')
add('The 16-bit square table occupies 256 KiB, which may be too large for a small device. '
    'A 32-bit whole-input square table would occupy 32 GiB, so this approach does not scale '
    'to arbitrary operand widths. Recursive use of the small table is evaluated separately.')
add('')
add('Native multiplication and the call/harness floor are both about 1.1 ns/product in these small '
    'tests. Table timings close to that floor cannot establish exact instruction latencies or '
    'a win over a hardware multiplier. The software-Karatsuba eight-bit base case itself uses '
    'the midpoint table; comparing the direct leaf against that wrapper would mostly measure dispatch.')
add('')
add('## Thirty-two-bit workloads')
add('')
add('| Pattern | Best tested midpoint | Midpoint ns | Appropriate direct method | Direct ns | Midpoint / direct |')
add('|---|---|---:|---|---:|---:|')
for pattern in ('random','near','equal','sparse','dense','times_one','times_byte','times_power2'):
    m = best(small,32,pattern,('midpoint_recursive','midpoint_set_bits','midpoint_prefix'))
    d = best(small,32,pattern,('shift_add','sparse_multiply','software_karatsuba',
                              'equal_aware_recursive','square_plus_delta'))
    mt, dt = ns(small,32,pattern,m), ns(small,32,pattern,d)
    add(f'| {pattern} | `{m}` | {mt:.2f} | `{d}` | {dt:.2f} | {mt/dt:.2f}x |')
add('')
add('Ratios above one in this table mean the midpoint method took longer. Nearby/equal operands '
    'narrow the difference, but do not show an advantage over the appropriate comparator.')
add('')
add('## Large integers: software arithmetic comparisons')
add('')
add('The primary large-number results below use the tuned 32-bit scalar leaves. Both methods '
    'remain multiply-free in their custom arithmetic. The square leaf uses three-square recursion '
    'and the same 512-byte table; direct-product leaves use scalar set-bit shift-and-add. '
    'This removes obvious small-leaf BIGNUM API overhead without claiming fully optimized limb code.')
add('')
add('The matrix reports **direct time / midpoint time**. Above 1 favors midpoint; below 1 favors '
    'direct multiplication. Values very close to 1 should be treated as ties for conclusions here.')
add('')
add('| Pattern | 64 bits | 256 bits | 1,024 bits | 4,096 bits | 16,384 bits |')
add('|---|---:|---:|---:|---:|---:|')
for pattern in PATTERNS:
    values = []
    for bits in WIDTHS:
        row = next(r for r in summary['large_comparisons'] if r['bits']==bits and r['pattern']==pattern)
        ratio=row['speedup_direct_over_midpoint']
        values.append(f'{ratio:.3g}x' if ratio<.01 else
                      f'{ratio:.3f}x' if ratio<.1 else f'{ratio:.2f}x')
    add('| '+pattern+' | '+' | '.join(values)+' |')
add('')
add('Each cell selects the best tested midpoint evaluator and the best eligible direct software '
    'comparison for that dataset. This is retrospective selection, not an implemented dispatcher; '
    'automatic classification would have its own cost. At 16,384 bits the quadratic methods were '
    'omitted to bound run time, so the comparisons are among the methods actually measured there. '
    'Use the 4,096-bit row details below when comparing all software families.')
add('')
add('| 4,096-bit pattern | Midpoint evaluator | Midpoint microseconds | Direct comparison | Direct microseconds |')
add('|---|---|---:|---|---:|')
for r in summary['large_comparisons']:
    if r['bits']==4096:
        add(f"| {r['pattern']} | `{r['midpoint']}` | {r['midpoint_ns']/1000:.3f} | `{r['direct']}` | {r['direct_ns']/1000:.3f} |")
add('')
add('Equal-input controls explicitly square. Near-input controls evaluate a^2+a(b-a). '
    'Short-operand controls scan the shorter factor; sparse controls can count and choose the '
    'sparser factor. Thus apparent wins over a baseline that ignores known structure are not '
    'credited as general advantages.')
add('')
add('### Effect of the single recursion-cutoff experiment')
add('')
add('| Random input bits | Midpoint recursion, 8-bit BN leaves (microseconds) | 32-bit scalar leaves (microseconds) | Speedup from cutoff change |')
add('|---:|---:|---:|---:|')
for bits in WIDTHS:
    before=ns(old,bits,'random','mid_recursive'); after=ns(large,bits,'random','mid_recursive')
    add(f'| {bits:,} | {before/1000:.3f} | {after/1000:.3f} | {before/after:.2f}x |')
add('')
add('This substantial improvement shows why raw prototype timing is not a mathematical lower '
    'bound. It also did not produce a robust general advantage over the tuned direct comparisons. '
    'Leaf-32 and leaf-8 product runs use identical generated inputs.')
add('')
add('## The cost of the wrapper with optimized native squares')
add('')
add('This separate control uses OpenSSL squares and hardware-supported arithmetic. It isolates '
    'the practical cost of the midpoint transformation from our experimental software square kernels.')
add('')
add('| Bits / pattern | Direct native multiply (microseconds) | Midpoint with native squares (microseconds) | Structure-aware native control (microseconds) |')
add('|---|---:|---:|---:|')
for bits in (1024,4096,16384):
    for pattern in ('random','near','equal'):
        native=ns(large,bits,pattern,'native_mul'); midpoint=ns(large,bits,pattern,'mid_native_square')
        other='near_native' if pattern=='near' else 'native_equal_aware'
        add(f'| {bits:,} / {pattern} | {native/1000:.3f} | {midpoint/1000:.3f} | {ns(large,bits,pattern,other)/1000:.3f} |')
add('')
add('## Does the direct bitwise square help?')
add('')
add('These are standalone squares, without the midpoint wrapper. All times are microseconds per '
    'square. The set-bit method scans bit positions through the BIGNUM API and performs one '
    'wide accumulation per set bit.')
add('')
add('| Bits / pattern | Set-bit square | Recursive square | Bit-prefix square | Native square | Recursive / set-bit |')
add('|---|---:|---:|---:|---:|---:|')
for bits in (1024,4096):
    for pattern in ('random','sparse3','dense','power2','near_power2_plus_byte'):
        st=ns(squares,bits,pattern,'set_bit_square'); rt=ns(squares,bits,pattern,'recursive_square')
        pt=ns(squares,bits,pattern,'prefix_square'); nt=ns(squares,bits,pattern,'native_square')
        add(f'| {bits:,} / {pattern} | {st/1000:.3f} | {rt/1000:.3f} | {pt/1000:.3f} | {nt/1000:.3f} | {rt/st:.2f}x |')
add('')
add('A fast square for a sparse value does not imply a fast product of sparse inputs. '
    'For x=1 and y=2^n, the midpoint is a power of two, but the half-difference is '
    '2^(n-1)-1, containing a long run of ones. Pure powers of two also admit a simpler direct '
    'shift than either generic squarer; the square-only table is a comparison of the listed '
    'evaluators, not a claim of optimal handling of that structure.')
add('')
add('## Table construction, coverage, and limits')
add('')
add('Warm table rebuild medians were measured separately. These are not cold startup costs; '
    'ROM tables have no runtime construction cost.')
add('')
add('| Table | Bytes | Warm rebuild nanoseconds |')
add('|---|---:|---:|')
for match in re.finditer(r'table_build name=(\w+) bytes=(\d+).*?median_ns=([\d.]+)',(SCRATCH/'small-run.log').read_text()):
    add(f'| {match[1]} | {int(match[2]):,} | {float(match[3]):.1f} |')
add('')
add('Correctness passed exhaustive eight-bit pairs, all 16-bit square values, 100,000 random '
    '32-bit pairs and boundary cases in the small suite. Large validation passed the table rule '
    'exhaustively and 433 boundary/larger pairs across 12 product implementations, plus scalar '
    'leaf tests and every measured dataset against native multiplication. Square-only datasets '
    'were checked against native squaring. These checks do not establish speed on another device.')
add('')
add('Important practical limits:')
add('')
add('- Measurements are warm throughput, not cold-cache or dependency-chain latency. '
    'The eight-bit full-product table accesses an upper-right logical quadrant for exact-width '
    'random operands, and the 16-bit table reuses a 4,096-pair working set.')
add('- Host bit-count/leading-zero/trailing-zero instructions may be unavailable or more '
    'expensive on a multiplication-limited device.')
add('- OpenSSL API calls, bit scans, and temporary-buffer management are part of the big-number '
    'prototype costs. Hand-written limb code could change thresholds and constants substantially.')
add('- No energy, cold-cache behavior, peak working RAM, or million-bit timing was measured. '
    'Tables have exact reported storage sizes; those are not total program-memory figures.')
add('- Cached repeated-midpoint workloads, complement/run-of-ones square shortcuts, other leaf '
    'sizes, and a target-specific ASM implementation remain unmeasured. They should not be '
    'described as measured wins or losses from this experiment.')
add('')
add('## Reproduction and raw artifacts')
add('')
add('```sh\nclang -O3 -std=c11 -Wall -Wextra .scratchpad/bench_small.c -o .scratchpad/small-bench\n'
    '.scratchpad/small-bench > .scratchpad/small-results.csv 2> .scratchpad/small-run.log\n```')
add('')
add('Build/run commands for both large variants are in [large methodology](.scratchpad/large-methodology.md). '
    'For the square-only suite, use the same OpenSSL include and link flags with '
    '`-DSCALAR_LEAF_BITS=32`, compile `.scratchpad/bench_squares.c`, and run '
    '`.scratchpad/square-bench --output .scratchpad/square-results.csv`. Run timing suites sequentially.')
add('')
add('- [Small raw CSV](.scratchpad/small-results.csv), [run metadata](.scratchpad/small-run.log), '
    '[assembly audit](.scratchpad/small-assembly-audit.json).')
add('- [Large initial CSV](.scratchpad/large-results.csv), [tuned CSV](.scratchpad/large-leaf32-results.csv), '
    '[tuned run metadata](.scratchpad/large-leaf32-run.log).')
add('- [Square-only CSV](.scratchpad/square-results.csv), [square metadata](.scratchpad/square-metadata.txt).')
add('- [Operation vectors](.scratchpad/cost-model.json) describe a separate Python model, not cycles '
    'or native instruction counts. They explain structural costs without predicting target timing.')
add('- [Machine-readable comparison summary](.scratchpad/measurement-summary.json).')
add('')
add('Regenerate this report: `python3 .scratchpad/summarize_benchmarks.py`.')

(SCRATCH/'measurement-summary.json').write_text(json.dumps(summary,indent=2)+'\n')
(ROOT/'benchmark-results.md').write_text('\n'.join(lines)+'\n')
print(json.dumps({'report':str(ROOT/'benchmark-results.md'),
                  'small_rows':len(small),'large_initial_rows':len(old),
                  'large_tuned_rows':len(large),'square_rows':len(squares)}))
