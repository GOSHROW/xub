#!/usr/bin/env python3
"""Signed and boundary correctness checks; no native-performance claims.

Native Python multiplication appears only in oracles and diagnostic values.
Run: python3 .scratchpad/verify_edge_cases.py
"""
from collections import Counter
import json
from pathlib import Path
import random

from verify_midpoint import SQUARE_TABLE, midpoint_product
from verify_improvement_identities import square_reuse, fused_difference


def square_edge(z):
    assert z >= 0
    if not z:
        return 0
    if z & (z - 1) == 0:
        return 1 << ((z.bit_length() - 1) << 1)
    return square_reuse(z)


def signed_midpoint(x, y, square=square_edge, trace=None):
    """Sign wrapper plus common D(h,d), with exact zero/unit/power-gap rules."""
    a, b = sorted((abs(x), abs(y)))
    delta = b - a
    d = delta >> 1
    h = a + d
    p = delta & 1
    evaluated = []

    def sq(z):
        evaluated.append(z)
        return square(z)

    if h == d:
        magnitude, path = 0, 'equal_square_arguments_zero'
    elif d == 0:
        magnitude, path = sq(h), 'one_square'
    elif a == 1:
        magnitude, path = (d << 1) + 1, 'unit_gap_no_squares'
    elif a & (a - 1) == 0:
        j = a.bit_length() - 1
        magnitude = (d << (j + 1)) + (a << j)
        path = 'power_of_two_gap_no_squares'
    else:
        magnitude, path = sq(h) - sq(d), 'two_squares'
    if p:
        magnitude += a
    negative = bool(magnitude) and ((x < 0) != (y < 0))
    result = -magnitude if negative else magnitude
    if trace is not None:
        trace.update(a=a, b=b, h=h, d=d, parity=p, path=path,
                     negative=negative, square_arguments=evaluated,
                     result=result)
    return result


def square_mod_prefix(z, width):
    assert z >= 0 and width >= 1
    mask = (1 << width) - 1
    prefix = result = 0
    for i in range(z.bit_length() - 1, -1, -1):
        bit = (z >> i) & 1
        result = (result << 2) & mask
        if bit:
            result = (result + (prefix << 2) + 1) & mask
        prefix = (prefix << 1) | bit
    return result


def unsigned_midpoint_mod(x, y, width):
    assert x >= 0 and y >= 0 and width >= 1
    mask = (1 << width) - 1
    a, b = sorted((x, y))
    delta = b - a
    d, h = delta >> 1, a + (delta >> 1)
    result = (square_mod_prefix(h, width) - square_mod_prefix(d, width)) & mask
    return (result + (a if delta & 1 else 0)) & mask


def signed_via_bounded_residues(x, y):
    ax, ay = abs(x), abs(y)
    width = max(1, ax.bit_length() + ay.bit_length())
    magnitude = unsigned_midpoint_mod(ax, ay, width)
    return -magnitude if magnitude and ((x < 0) != (y < 0)) else magnitude


def unsigned_magnitude_model(x, width):
    """Model unsigned conversion then unsigned negation, avoiding signed -MIN."""
    assert -(1 << (width - 1)) <= x < (1 << (width - 1))
    mask = (1 << width) - 1
    unsigned = x & mask
    return (-unsigned) & mask if x < 0 else unsigned


def verify():
    paths = Counter()
    for x in range(-128, 128):
        for y in range(-128, 128):
            expected = x * y
            trace = {}
            assert signed_midpoint(x, y, SQUARE_TABLE.__getitem__, trace) == expected
            paths[trace['path']] += 1
            baseline = midpoint_product(abs(x), abs(y), SQUARE_TABLE.__getitem__)
            if (x < 0) != (y < 0):
                baseline = -baseline
            assert baseline == expected
            assert signed_via_bounded_residues(x, y) == expected
            residue = unsigned_midpoint_mod(abs(x), abs(y), 8)
            if (x < 0) != (y < 0):
                residue = -residue
            assert residue & 255 == expected & 255
            assert trace['negative'] == (expected < 0)
            assert trace['h'] - trace['d'] == trace['a']
            assert trace['h'] == (trace['a'] & trace['b']) + ((trace['a'] ^ trace['b']) >> 1)

    examples = [(1000000000, 1), (67, 68), (-4523, -3412),
                (4523, -3412), (0, -4523), (-67, -68),
                (0b1000000000, 1)]
    widths = (1, 2, 7, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65,
              127, 128, 129, 255, 256, 257, 511, 512, 513, 1024, 4096)
    pairs = set(examples)
    rng = random.Random(0x45444745)
    for width in widths:
        power, minimum = 1 << width, -(1 << (width - 1))
        maximum = -minimum - 1
        signed_boundaries = {minimum, maximum, -1, 0}
        if maximum >= 1:
            signed_boundaries.add(1)
        pairs.update((x, y) for x in signed_boundaries for y in signed_boundaries)
        magnitudes = ((power - 1, power - 1), (power - 1, power + 1),
                      (power, power), (power, power + 1), (1, power - 1),
                      (power - 1, 173), (0, power + 1))
        for a, b in magnitudes:
            for sx, sy in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
                x, y = a if sx > 0 else -a, b if sy > 0 else -b
                pairs.add((x, y)); pairs.add((y, x))
        for _ in range(3):
            a, b = rng.getrandbits(width), rng.getrandbits(width)
            for x, y in ((a, b), (-a, b), (a, -b), (-a, -b)):
                pairs.add((x, y))

    for x, y in sorted(pairs):
        expected = x * y
        trace = {}
        assert signed_midpoint(x, y, trace=trace) == expected
        assert signed_midpoint(y, x) == expected
        assert signed_via_bounded_residues(x, y) == expected
        baseline = midpoint_product(abs(x), abs(y), square_reuse)
        if (x < 0) != (y < 0):
            baseline = -baseline
        assert baseline == expected
        assert trace['negative'] == (expected < 0)
        assert 0 <= trace['d'] <= trace['h'] <= trace['b']
        assert trace['h'] - trace['d'] == trace['a']
        assert trace['parity'] == ((trace['a'] ^ trace['b']) & 1)

    magnitude_checks = 0
    for width in (8, 16, 32, 64, 128):
        minimum = -(1 << (width - 1))
        values = range(-128, 128) if width == 8 else (minimum, minimum + 1, -1, 0, 1, -minimum - 1)
        for x in values:
            assert unsigned_magnitude_model(x, width) == abs(x)
            magnitude_checks += 1

    # Negative internal differences are possible despite a positive final D.
    high = fused_difference(8, 7)
    low = fused_difference(0, 15)
    middle = fused_difference(8, 8)
    assert low < 0 and high + low - middle < 0
    assert (high << 8) + ((high + low - middle) << 4) + low == fused_difference(128, 127) == 255

    # Quarter-square division must retain two extra bits BEFORE >>2.
    quarter_checks = 0
    mask = 255
    for x in range(256):
        for y in range(256):
            q_sum = square_mod_prefix(x + y, 10) >> 2
            q_diff = square_mod_prefix(abs(x - y), 10) >> 2
            assert (q_sum - q_diff) & mask == (x * y) & mask
            quarter_checks += 1
    assert (square_mod_prefix(20, 8) >> 2) == 36  # incorrect eight-bit Q for 10*10
    assert (square_mod_prefix(20, 10) >> 2) == 100

    # Regression checks for why temporary capacity and zero/bit scans matter.
    assert (500000000 ** 2).bit_length() == 58
    assert (1000000000).bit_length() == 30
    for bits in widths:
        z = 1 << (bits - 1)
        r = (((1 << bits) - 1) ^ z) + 1
        assert r == z  # unguarded complement recursion cannot make progress
    assert signed_midpoint(-(1 << 63), -1) == 1 << 63
    assert signed_midpoint(-(1 << 63), -(1 << 63)) == 1 << 126

    traces = []
    for x, y in examples:
        trace = {'x': x, 'y': y}
        signed_midpoint(x, y, trace=trace)
        trace['full_square_bits'] = max((trace['h'] ** 2).bit_length(), (trace['d'] ** 2).bit_length())
        trace['result_magnitude_bits'] = abs(trace['result']).bit_length()
        traces.append(trace)
    assert not traces[0]['square_arguments']
    assert traces[1]['square_arguments'] == [67]
    assert traces[2]['square_arguments'] == [3967, 555]

    return {
        'status': 'passed',
        'purpose': 'Signed and boundary correctness only; proposed D shortcuts are not speed benchmarks.',
        'all_ordered_signed_8bit_pairs': 65536,
        'signed_8bit_paths': dict(sorted(paths.items())),
        'additional_unique_signed_boundary_and_random_pairs': len(pairs),
        'maximum_tested_operand_bits': max(max(abs(x).bit_length(), abs(y).bit_length()) for x, y in pairs),
        'unsigned_magnitude_model_checks': magnitude_checks,
        'quarter_square_residue_pairs': quarter_checks,
        'examples': traces,
        'notes': [
            'Full exact squares can be wider than the exact final product.',
            'Bounded modulo squares are exact after subtraction if the product fits the proven output width.',
            'Modulo arithmetic does not make out-of-range native shifts or signed overflow valid.',
            'Python models the proposed C magnitude rule; this is not a native signed-minimum or buffer test.',
            'Previous unsigned native benchmarks and their timings are unchanged.',
        ],
    }


if __name__ == '__main__':
    report = verify()
    destination = Path(__file__).with_name('edge-case-results.json')
    destination.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))
