#!/usr/bin/env python3
"""Deterministic external oracle: Python int is the independent reference.

This checks values and API-facing CLI behavior. It is not a timing benchmark.
"""

import argparse
import json
import random
import subprocess
import sys
from pathlib import Path

SEED = 0x585542
MODES = ("auto", "recursive", "sparse", "compact")


def signed(value, index):
    return -value if index & 1 else value


class Oracle:
    def __init__(self, binary):
        self.binary = str(binary.resolve())
        self.products = 0
        self.processes = 0
        self.groups = {}
        self.maximum_bits = 0

    def run(self, arguments, text=None, success=True):
        self.processes += 1
        result = subprocess.run(
            [self.binary, *arguments], input=text, text=True,
            capture_output=True, timeout=240,
        )
        if (result.returncode == 0) != success:
            raise AssertionError(
                f"CLI {arguments[:12]!r} exit {result.returncode}; "
                f"stdout={result.stdout[:300]!r}; stderr={result.stderr[:1200]!r}"
            )
        return result

    def batch(self, name, pairs, arguments=(), width=None, formats=False):
        pairs = list(pairs)
        encoders = (str, hex, bin)
        lines = []
        for index, (left, right) in enumerate(pairs):
            encode = encoders[index % len(encoders)] if formats else hex
            lines.append(f"{encode(left)} {encode(right)}\n")
            self.maximum_bits = max(self.maximum_bits, abs(left).bit_length(),
                                    abs(right).bit_length())
        result = self.run([*arguments, "--batch", "--hex"], "".join(lines))
        if result.stderr:
            raise AssertionError(f"Unexpected diagnostic in {name}: {result.stderr[:1000]}")
        actual = result.stdout.splitlines()
        if len(actual) != len(pairs):
            raise AssertionError(f"{name}: {len(actual)} results for {len(pairs)} inputs")
        for index, ((left, right), line) in enumerate(zip(pairs, actual)):
            wanted = left * right
            if width is not None:
                wanted %= 1 << width
            got = int(line, 0)
            if got != wanted:
                raise AssertionError(
                    f"{name}[{index}]: {hex(left)} * {hex(right)}, bits={width}; "
                    f"expected {hex(wanted)}, got {line}"
                )
        self.products += len(pairs)
        self.groups[name] = len(pairs)


def structured_pairs(quick, rng):
    lengths = [1, 7, 8, 9, 15, 16, 17, 31, 32, 33, 63, 64, 65,
               127, 128, 129, 255, 256, 257, 511, 512, 1023, 1024]
    lengths += [2048, 4096] if quick else [2047, 2048, 2049, 4095, 4096, 8192]
    pairs = [(1000000000, 1), (67, 68), (68, 67), (-4523, -3412),
             (-4523, 3412), (-(1 << 63), -1), (0, 0), (-1, -1)]
    for bits in lengths:
        power = 1 << (bits - 1)
        dense = (1 << bits) - 1
        sparse = power | (1 << (bits // 2)) | 1
        random_x = rng.getrandbits(bits) | power | 1
        random_y = rng.getrandbits(bits) | power | 1
        pairs.extend([
            (dense, dense), (-dense, dense), (sparse, sparse),
            (power, random_x), (random_x, 1), (0, -dense),
            (dense, dense - 1), (dense, dense - 2),
            (random_x, random_y), (-random_x, random_y),
            (random_x, random_x + 37),
            (random_x, -random_y), (-random_x, -random_y),
            (random_x, 7), (random_x, (1 << min(31, bits - 1)) | 3),
            (random_x << 31, random_y << 33),
            ((power << bits) | (dense >> 1), sparse),
        ])
        for index in range(2 if quick else 8):
            # Independent lengths exercise rectangular inputs as well as parity.
            right_bits = rng.randrange(1, bits + 1)
            pairs.append((signed(rng.getrandbits(bits), index),
                          signed(rng.getrandbits(right_bits), index >> 1)))
    return pairs


def test_cli(oracle):
    for arguments, expected in [
        (["1000000000", "1"], "1000000000\n"),
        (["67", "68"], "4556\n"),
        (["-4523", "-3412"], "15432476\n"),
        (["--", "-4523", "3412"], "-15432476\n"),
        (["+0xFF", "-0b101"], "-1275\n"),
        (["--hex", "-0xFF", "0b101"], "-0x4fb\n"),
        (["--hex", "-0", "5"], "0x0\n"),
    ]:
        result = oracle.run(arguments)
        if result.stdout != expected or result.stderr:
            raise AssertionError(f"Unexpected output for {arguments}: {result}")
        oracle.products += 1
    huge = (1 << 8192) + 923
    oracle.maximum_bits = max(oracle.maximum_bits, huge.bit_length())
    result = oracle.run([str(huge), "-134999"])
    if result.stdout != str(-huge * 134999) + "\n":
        raise AssertionError("Large decimal I/O mismatch")
    oracle.products += 1
    bad_arguments = [
        [], ["1"], ["1", "2", "3"], ["--bogus", "1", "2"],
        ["--mode", "wrong", "1", "2"], ["--mode"],
        ["--mod-bits", "-1", "1", "2"], ["--mod-bits", "1x", "1", "2"],
        ["--mod-bits", "18446744073709551616", "1", "2"],
        ["--mod-bits", "18446744073709551615", "1", "2"],
        ["--mod-bits"], ["--cache-sum"], ["--cache-sum", "-3", "1", "2"],
        ["--cache-sum", "4", "1", "2"],
        ["--mod-bits", "8", "--cache-sum", "3", "1", "2"],
        ["--batch", "1", "2"], ["0b2", "1"], ["0x", "1"], [" 2", "3"],
    ]
    for arguments in bad_arguments:
        result = oracle.run(arguments, success=False)
        if result.stdout:
            raise AssertionError(f"Failed operation emitted a product: {arguments}")
    for text in ("1\n", "1 2 3\n", "0b2 4\n", "1\x00 2\n"):
        oracle.run(["--batch"], text, success=False)
    result = oracle.run(["--batch"], "\n  \n67\t68\r\n-4523 -3412")
    if result.stdout != "4556\n15432476\n":
        raise AssertionError("Whitespace or final line handling failed")
    oracle.products += 2
    result = oracle.run(["--stats", "--batch"], "0 9\n1 9\n67 68\n")
    stats = [json.loads(line) for line in result.stderr.splitlines()]
    if len(stats) != 3:
        raise AssertionError("Expected one JSON statistics object per product")
    if result.stdout != "0\n9\n4556\n":
        raise AssertionError("Statistics option changed the product output")
    oracle.products += 3
    for index, name in enumerate(("zero_products", "unit_products", "adjacent_products")):
        if stats[index][name] != 1:
            raise AssertionError(f"Expected route {name}: {stats[index]}")
    if stats[1]["zero_products"] or stats[2]["unit_products"]:
        raise AssertionError("Batch statistics were not reset between products")
    if "Usage:" not in oracle.run(["--help"]).stdout:
        raise AssertionError("Help text missing")
    oracle.groups["cli_contract"] = len(bad_arguments) + 4 + 11


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--binary", type=Path, default=Path("build/xub"))
    parser.add_argument("--output", type=Path, default=Path("tests/results.json"))
    parser.add_argument("--quick", action="store_true", help="Smaller sanitizer corpus")
    args = parser.parse_args()
    if hasattr(sys, "set_int_max_str_digits"):
        sys.set_int_max_str_digits(0)
    oracle = Oracle(args.binary)
    rng = random.Random(SEED)
    domain = range(-16, 16) if args.quick else range(-128, 128)
    oracle.batch("exhaustive_signed_small", ((x, y) for x in domain for y in domain))
    pairs = structured_pairs(args.quick, rng)
    for mode in MODES:
        oracle.batch("structured_" + mode, pairs, ["--mode", mode], formats=True)
    widths = [0, 1, 7, 8, 9, 31, 32, 33, 63, 64, 65, 127, 128, 257, 1024]
    if not args.quick:
        widths += [2048, 4096]
    for width in widths:
        modular_pairs = [(0, -3), (-3, 5), (1 << width, -1),
                         ((1 << (width + 9)) - 1, (1 << (width + 8)) + 3)]
        for index in range(12 if args.quick else 32):
            left = rng.getrandbits(width + 67)
            right = rng.getrandbits(width + 11)
            modular_pairs.append((signed(left, index), signed(right, index >> 1)))
        oracle.batch(f"modulo_{width}", modular_pairs, ["--mod-bits", str(width)], width)
    for total in [0, 1, 135, 256, (1 << 521) + 173, 1 << 1024]:
        cached_pairs = [(0, total), (total, 0), (total // 2, total - total // 2)]
        for index in range(8 if args.quick else 32):
            left = rng.randrange(total + 1)
            right = total - left
            cached_pairs.append((signed(left, index), signed(right, index >> 1)))
        oracle.batch(f"cached_sum_{total.bit_length()}bits_{total & 255}", cached_pairs,
                     ["--cache-sum", hex(total)])
    test_cli(oracle)
    report = {
        "status": "passed", "purpose": "correctness; not a timing benchmark",
        "binary": oracle.binary, "seed": SEED, "quick": args.quick,
        "products_checked": oracle.products, "maximum_operand_bits": oracle.maximum_bits,
        "subprocesses": oracle.processes, "groups": oracle.groups,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(f"Python oracle passed ({oracle.products:,} products; "
          f"up to {oracle.maximum_bits:,} operand bits). Report: {args.output}")


if __name__ == "__main__":
    try:
        main()
    except (AssertionError, OSError, subprocess.TimeoutExpired) as error:
        print(f"Oracle failed: {error}", file=sys.stderr)
        sys.exit(1)
