#!/usr/bin/env python3
"""Operation vectors for specified arithmetic algorithms, not cycle estimates.

Run: python3 .scratchpad/cost-model.py --output .scratchpad/cost-model.json

Counts describe this source exactly; limb spans describe operand widths with
32-bit limbs. They omit allocation, cache, branch, call, and instruction costs.
Do not add the different vector components or interpret them as elapsed time.
"""

from __future__ import annotations

import argparse
from collections import Counter
import json
from pathlib import Path
import random


def make_table():
    table, square, odd = [], 0, 1
    for _ in range(256):
        table.append(square)
        square += odd
        odd += 2
    return table


TABLE = make_table()


class Model:
    def __init__(self):
        self.c = Counter()

    @staticmethod
    def words(x):
        return max(1, (abs(x).bit_length() + 31) >> 5)

    def add(self, x, y):
        self.c['add_sub_calls'] += 1
        self.c['add_sub_input_limb_spans'] += max(self.words(x), self.words(y))
        return x + y

    def sub(self, x, y):
        self.c['add_sub_calls'] += 1
        self.c['add_sub_input_limb_spans'] += max(self.words(x), self.words(y))
        return x - y

    def shl(self, x, n):
        self.c['left_shift_calls'] += 1
        result = x << n
        self.c['left_shift_output_limb_spans'] += self.words(result)
        return result

    def shr(self, x, n):
        self.c['right_shift_calls'] += 1
        self.c['right_shift_input_limb_spans'] += self.words(x)
        return x >> n

    def boolean(self, x, y, operation):
        self.c['boolean_calls'] += 1
        self.c['boolean_input_limb_spans'] += max(self.words(x), self.words(y))
        if operation == 'and':
            return x & y
        if operation == 'or':
            return x | y
        return x ^ y

    def split(self, x, n):
        self.c['split_calls'] += 1
        self.c['split_input_limb_spans'] += self.words(x)
        return x >> n, x & ((1 << n) - 1)

    def table(self, x):
        self.c['square_table_lookups'] += 1
        return TABLE[x]

    def square_recursive(self, x):
        self.c['recursive_square_calls'] += 1
        if x < 256:
            return self.table(x)
        r = x.bit_length() >> 1
        a, b = self.split(x, r)
        u = self.square_recursive(a)
        v = self.square_recursive(b)
        w = self.square_recursive(abs(self.sub(a, b)))
        cross = self.sub(self.add(u, v), w)
        return self.add(self.add(self.shl(u, r << 1), self.shl(cross, r)), v)

    def square_set_bits(self, x):
        result = 0
        while x:
            self.c['set_bit_square_iterations'] += 1
            higher = self.boolean(x, self.sub(x, 1), 'and')
            bit = self.boolean(x, higher, 'xor')
            i = bit.bit_length() - 1
            row = self.boolean(self.shl(bit, i), self.shl(higher, i + 1), 'or')
            result = self.add(result, row)
            x = higher
        return result

    def midpoint(self, x, y, square):
        a, b = (x, y) if x <= y else (y, x)
        delta = self.sub(b, a)
        d = self.shr(delta, 1)
        h = self.add(a, d)
        result = self.sub(square(h), square(d))
        return self.add(result, a) if delta & 1 else result

    def sparse_multiply(self, x, y):
        # Include both population-count scans; no constant-time popcount assumed.
        self.c['popcount_input_limb_spans'] += self.words(x) + self.words(y)
        if x.bit_count() < y.bit_count():
            x, y = y, x
        result = 0
        while y:
            self.c['set_bit_multiply_iterations'] += 1
            higher = self.boolean(y, self.sub(y, 1), 'and')
            bit = self.boolean(y, higher, 'xor')
            result = self.add(result, self.shl(x, bit.bit_length() - 1))
            y = higher
        return result

    def karatsuba(self, x, y):
        self.c['recursive_multiply_calls'] += 1
        if not x or not y:
            return 0
        if x == 1:
            return y
        if y == 1:
            return x
        if x == y:
            self.c['equal_input_square_shortcuts'] += 1
            return self.square_recursive(x)
        n = max(x.bit_length(), y.bit_length())
        if n <= 8:
            return self.midpoint(x, y, self.table)
        if min(x.bit_length(), y.bit_length()) <= 8:
            self.c['short_operand_shift_add_shortcuts'] += 1
            return self.sparse_multiply(x, y)
        r = n >> 1
        ah, al = self.split(x, r)
        bh, bl = self.split(y, r)
        u = self.karatsuba(ah, bh)
        v = self.karatsuba(al, bl)
        da, db = self.sub(ah, al), self.sub(bh, bl)
        w = self.karatsuba(abs(da), abs(db))
        cross = self.add(u, v)
        cross = self.sub(cross, w) if (da < 0) == (db < 0) else self.add(cross, w)
        return self.add(self.add(self.shl(u, r << 1), self.shl(cross, r)), v)


def patterns(width, rng):
    top = 1 << (width - 1)
    x = top | rng.getrandbits(width - 1)
    y = top | rng.getrandbits(width - 1)
    sparse1 = top | (1 << (width // 3)) | 1
    sparse2 = top | (1 << (width // 2)) | 2
    near = (x & ~255) | 17
    return {
        'balanced_random': (x, y),
        'equal_random': (x, x),
        'near_random_plus_7': (near, near + 7),
        'sparse_three_bits': (sparse1, sparse2),
        'dense_all_ones': ((1 << width) - 1, (1 << width) - 3),
        'one_times_random': (1, x),
        'byte_times_random': (173, x),
        'sparse_with_dense_difference': (1, top),
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    rng = random.Random(0x434F5354)
    rows = []
    for width in (64, 256, 1024, 4096):
        for pattern, (x, y) in patterns(width, rng).items():
            a, b = sorted((x, y))
            d = (b - a) >> 1
            h = a + d
            algorithms = {
                'midpoint_recursive': lambda m: m.midpoint(x, y, m.square_recursive),
                'midpoint_set_bits': lambda m: m.midpoint(x, y, m.square_set_bits),
                'direct_karatsuba_with_basic_shortcuts': lambda m: m.karatsuba(x, y),
                'direct_sparse_shift_add': lambda m: m.sparse_multiply(x, y),
            }
            for name, algorithm in algorithms.items():
                m = Model()
                result = algorithm(m)
                assert result == x * y, (width, pattern, name)
                rows.append({
                    'width': width,
                    'pattern': pattern,
                    'algorithm': name,
                    'input_popcounts': [x.bit_count(), y.bit_count()],
                    'square_argument_popcounts': [h.bit_count(), d.bit_count()],
                    'square_argument_bits': [h.bit_length(), d.bit_length()],
                    'counts': dict(sorted(m.c.items())),
                })
    report = {
        'status': 'passed',
        'purpose': 'Operation vectors; not timings, cycles, or weighted performance scores.',
        'seed': '0x434F5354',
        'limb_bits': 32,
        'square_leaf_bits': 8,
        'square_table_native_bytes': 512,
        'case_count': len(rows),
        'limitations': [
            'One deterministic pair per width and pattern; not a distributional benchmark.',
            'Limb spans are operand widths, not measured memory accesses or instructions.',
            'Counts omit comparison, bit-length, control-flow, allocation, cache, and call costs.',
            'Each vector applies only to the stated implementations and shortcuts.',
            'Direct Karatsuba uses zero/one/equality/short-operand shortcuts; midpoint is literal.',
            'No combined scalar cost or target-device speed estimate is implied.',
        ],
        'rows': rows,
    }
    text = json.dumps(report, indent=2) + '\n'
    if args.output:
        args.output.write_text(text)
    print(json.dumps({'status': 'passed', 'case_count': len(rows), 'output': str(args.output)}))


if __name__ == '__main__':
    main()
