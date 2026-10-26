#!/usr/bin/env python3
"""Correctness-only checks of proposed improvements; no performance claims."""
import json
from pathlib import Path
import random

from verify_midpoint import SQUARE_TABLE, midpoint_product, square_recursive


def square_reuse(z):
    if z < 256:
        return SQUARE_TABLE[z]
    r = z.bit_length() >> 1
    high, low = z >> r, z & ((1 << r) - 1)
    u = square_reuse(high)
    if low == 0:
        return u << (r << 1)
    if high == low:
        return (u << (r << 1)) + (u << (r + 1)) + u
    v = square_reuse(low)
    w = square_reuse(abs(high - low))
    return (u << (r << 1)) + ((u + v - w) << r) + v


def square_complement_identity(z):
    if not z:
        return 0
    n = z.bit_length()
    r = (((1 << n) - 1) ^ z) + 1
    assert 0 < r <= z
    # Use an independent squarer for r. A future recursive dispatcher must
    # handle powers of two first, since those have r == z.
    return ((z - r) << n) + square_reuse(r)


def fused_difference(u, v):
    if u == v:
        return 0
    if u < v:
        return -fused_difference(v, u)
    if u < 16:
        return SQUARE_TABLE[u] - SQUARE_TABLE[v]
    r = u.bit_length() >> 1
    mask = (1 << r) - 1
    uh, ul = u >> r, u & mask
    vh, vl = v >> r, v & mask
    high = fused_difference(uh, vh)
    low = fused_difference(ul, vl)
    middle = fused_difference(abs(uh - ul), abs(vh - vl))
    return (high << (r << 1)) + ((high + low - middle) << r) + low


def midpoint_fused(x, y):
    a, b = sorted((x, y))
    delta = b - a
    d = delta >> 1
    return fused_difference(a + d, d) + (a if delta & 1 else 0)


def chunked_midpoint(x, y):
    a, b = sorted((x, y))
    if not a:
        return 0
    k = a.bit_length()
    mask = (1 << k) - 1
    output = carry = offset = 0
    while b:
        digit = b & mask
        part = midpoint_product(a, digit, square_reuse) + carry
        assert 0 <= part < (1 << (k << 1))
        output |= (part & mask) << offset
        carry = part >> k
        assert carry < a
        offset += k
        b >>= k
    return output | (carry << offset)


def verify():
    for z in range(1 << 16):
        assert square_reuse(z) == z * z
        assert square_complement_identity(z) == z * z
    for x in range(256):
        for y in range(256):
            assert fused_difference(x, y) == x * x - y * y
            assert midpoint_fused(x, y) == x * y
            assert chunked_midpoint(x, y) == x * y
    rng = random.Random(0x465554555245)
    pairs = []
    square_values = []
    for bits in (16, 32, 64, 128, 256, 1024, 4096):
        top = 1 << (bits - 1)
        x = top | rng.getrandbits(bits - 1)
        y = top | rng.getrandbits(bits - 1)
        pairs.extend(((x, y), (y, x), (x, x), (x, x + 1),
                      (173, x), (1, top), (top, top >> 1)))
        square_values.extend((x, (top << 1) - 1, (top << 1) - 1 - (top >> 2),
                              top, top + 1, (x << bits) | x, x << bits))
    for z in square_values:
        assert square_reuse(z) == z * z
        assert square_complement_identity(z) == z * z
    for x, y in pairs:
        assert fused_difference(x, y) == x * x - y * y
        assert midpoint_fused(x, y) == x * y
        assert chunked_midpoint(x, y) == x * y
        # Exact neighboring/power-of-two gap rules for a future fused evaluator.
        assert fused_difference(x + 1, x) == (x << 1) + 1
        for t in (0, 1, 7, 31):
            gap = 1 << t
            assert fused_difference(x + gap, x) == (x << (t + 1)) + (gap << t)
    return {
        'status': 'passed',
        'purpose': 'Correctness of proposed identities only; no speed measurements.',
        'unsigned_16bit_values_per_square_identity': 65536,
        'ordered_8bit_pairs_per_product_and_difference_identity': 65536,
        'larger_product_pairs_per_identity': len(pairs),
        'larger_square_values_per_identity': len(square_values),
        'maximum_product_operand_bits': max(max(x.bit_length(), y.bit_length()) for x, y in pairs),
        'maximum_square_input_bits': max(z.bit_length() for z in square_values),
        'notes': [
            'Fused differences are signed internally; a native port needs explicit signed-magnitude handling.',
            'A four-bit leaf forces fused recursion in the exhaustive eight-bit sweep.',
            'Complement uses an independent square of r and is not yet an adaptive recursive dispatcher.',
            'Powers of two have complement r == z and need a termination guard in such a dispatcher.',
            'Python chunk assembly verifies arithmetic, not the proposed linear-time limb implementation.',
        ],
    }


if __name__ == '__main__':
    report = verify()
    path = Path(__file__).with_name('improvement-identity-results.json')
    path.write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(report, indent=2))
