#!/usr/bin/env python3
"""Focused primitive regression with poisoned spare capacity and Python ints."""
import ctypes as c
from pathlib import Path
import random
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parents[1]


class Integer(c.Structure):
    _fields_ = [("limbs", c.POINTER(c.c_uint32)), ("used", c.c_size_t),
                ("capacity", c.c_size_t), ("negative", c.c_int)]


def run(library):
    lib = c.CDLL(str(library))
    ptr = c.POINTER(Integer)
    size = c.c_size_t
    u32 = c.c_uint32
    signatures = [
        ("xub_init", [ptr], None), ("xub_free", [ptr], None),
        ("xub_parse", [ptr, c.c_char_p], c.c_int),
        ("xub_format", [ptr, c.c_uint], c.c_void_p),
        ("xub_copy", [ptr, ptr], c.c_int),
        ("xub_set_u64", [ptr, c.c_uint64], c.c_int),
        ("xi_reserve", [ptr, size], c.c_int),
        ("xi_add", [ptr, ptr, ptr], c.c_int),
        ("xi_add_u32", [ptr, ptr, u32], c.c_int),
        ("xi_sub", [ptr, ptr, ptr], c.c_int),
        ("xi_lshift", [ptr, ptr, size], c.c_int),
        ("xi_rshift", [ptr, ptr, size], c.c_int),
        ("xi_low", [ptr, ptr, size], c.c_int),
        ("xi_slice", [ptr, ptr, size, size], c.c_int),
        ("xi_set_bit", [ptr, size], c.c_int),
        ("xi_add_shifted", [ptr, ptr, size, size], c.c_int),
        ("xi_clz32", [u32], c.c_uint),
        ("xi_ctz32", [u32], c.c_uint),
    ]
    for name, args, result in signatures:
        function = getattr(lib, name)
        function.argtypes, function.restype = args, result
    libc = c.CDLL(None)
    libc.free.argtypes = [c.c_void_p]
    libc.free.restype = None
    integers = [Integer() for _ in range(3)]
    a, b, out = integers
    for value in integers:
        lib.xub_init(c.byref(value))
    count = 0

    def call(name, *args):
        args = [c.byref(x) if isinstance(x, Integer) else x for x in args]
        assert getattr(lib, name)(*args) == 0, name

    def poison(value):
        for i in range(value.used, value.capacity):
            value.limbs[i] = 0xA5A5A5A5

    def put(value, number):
        call("xub_parse", value, str(number).encode())
        # A retained scratch buffer can contain old nonzero data everywhere.
        call("xi_reserve", value, 256)
        poison(value)

    def check(value, expected):
        nonlocal count
        address = lib.xub_format(c.byref(value), 16)
        assert address
        actual = int(c.string_at(address), 16)
        libc.free(address)
        assert actual == expected, (actual, expected)
        assert value.negative == (expected < 0)
        assert bool(value.used) == bool(expected)
        count += 1
        poison(value)

    rng = random.Random(0x58554223)
    for i in range(600):
        av = rng.getrandbits(rng.randrange(2049))
        bv = rng.getrandbits(rng.randrange(2049))
        if i % 20 == 0:
            av = (1 << rng.randrange(2049)) - 1
        if i % 21 == 0:
            bv = 0
        shift = rng.choice([0, 1, 31, 32, 64, 96, 1024, rng.randrange(3000)])
        limit = rng.randrange(3000)
        small = rng.choice([0, 1, 0xFFFFFFFF, rng.getrandbits(32)])
        put(a, av)
        put(b, bv)
        put(out, 1 << 4095)
        call("xi_add", out, a, b)
        check(out, av + bv)
        call("xi_add", a, a, b)
        check(a, av + bv)
        put(a, av)
        call("xi_add", b, a, b)
        check(b, av + bv)
        put(b, bv)
        call("xi_add", a, a, a)
        check(a, av + av)
        put(a, av)
        call("xi_add_u32", out, a, small)
        check(out, av + small)
        call("xi_add_u32", a, a, small)
        check(a, av + small)
        put(a, av)
        call("xi_lshift", out, a, shift)
        check(out, av << shift)
        call("xi_rshift", out, a, shift)
        check(out, av >> shift)
        call("xi_rshift", a, a, shift)
        check(a, av >> shift)
        put(a, av)
        call("xi_low", out, a, limit)
        check(out, av % (1 << limit))
        call("xi_low", a, a, limit)
        check(a, av % (1 << limit))
        put(a, av)
        call("xi_slice", out, a, shift, limit)
        check(out, (av >> shift) % (1 << limit))
        call("xi_set_bit", out, shift)
        check(out, ((av >> shift) % (1 << limit)) | (1 << shift))
        call("xi_add_shifted", b, a, shift, size(-1).value)
        check(b, bv + (av << shift))
        put(b, bv)
        call("xi_add_shifted", b, a, shift, limit)
        check(b, (bv + (av << shift)) % (1 << limit))
        put(a, max(av, bv))
        put(b, min(av, bv))
        call("xi_sub", out, a, b)
        check(out, abs(av - bv))
        call("xi_sub", b, a, b)
        check(b, abs(av - bv))

    words = [0, 0xFFFFFFFF]
    words += [((1 << n) + d) & 0xFFFFFFFF for n in range(32) for d in [-1, 0, 1]]
    words += [rng.getrandbits(32) for _ in range(5000)]
    for word in words:
        assert lib.xi_clz32(word) == 32 - word.bit_length()
        assert lib.xi_ctz32(word) == ((word & -word).bit_length() - 1 if word else 32)

    put(out, 1 << 4095)
    address, capacity = c.addressof(out.limbs.contents), out.capacity
    for value in [0, 1, (1 << 64) - 1, 0]:
        call("xub_set_u64", out, value)
        check(out, value)
        assert c.addressof(out.limbs.contents) == address and out.capacity == capacity
    put(a, -123456789)
    call("xub_copy", out, a)
    check(out, -123456789)
    assert c.addressof(out.limbs.contents) == address and out.capacity == capacity
    for value in integers:
        lib.xub_free(c.byref(value))
    print(f"Passed {count} poisoned-capacity oracle checks, {len(words)} clz/ctz cases, and buffer reuse checks.")


if __name__ == "__main__":
    with tempfile.TemporaryDirectory(prefix="xub-primitives-") as temporary:
        library = Path(temporary) / "libprimitives.dylib"
        subprocess.run(["cc", "-std=c11", "-O2", "-Wall", "-Wextra", "-Wpedantic", "-Werror",
                        "-shared", "-fPIC", "-I" + str(ROOT / "include"),
                        "-I" + str(ROOT / "src"), str(ROOT / "src/xub_int.c"),
                        "-o", str(library)], check=True)
        run(library)
