# Multiplication through subtraction of squares

Portable C11 version 2 implements exact signed arbitrary-precision multiplication
through a common integer midpoint identity. The target of the investigation is
hardware with limited multiplication support. Operand sizes are limited by
available memory and addressable sizes, rather than a fixed integer register.

For ordered magnitudes `a <= b`, compute `delta=b-a`, `d=delta>>1`,
`h=a+d`, and `p=delta&1`. Then:

```text
|x*y| = square(h) - square(d) + (p ? a : 0)
```

Restore the sign after the magnitude calculation. This handles the original
half-bit observation exactly, using integers throughout. Square evaluation uses
bit structure, additions, shifts, and a 512-byte square table. The multiplication
and square kernels do not use native operand multiplication. Decimal formatting
does use division; generated instructions and helper routines depend on the compiler.

## Build and run

Requires a C11 compiler with `uint32_t` and `uint64_t`, a C runtime with dynamic
allocation, and `make`. Python 3 is needed only for the oracle tests.

```sh
make
build/xub 1000000000 1             # 1000000000
build/xub --stats 67 68           # 4556; branch counters on stderr
build/xub -4523 -3412             # 15432476
build/xub --mod-bits 8 -67 68     # 52, the canonical residue modulo 256
build/xub --cache-sum 135 67 68   # 4556
build/xub --hex 0xffff 0b101
build/xub --help
```

Use `--batch` to read two whitespace-separated operands per line. It is especially
useful with `--cache-sum SUM`: all pairs must have that same sum of magnitudes.
Cache construction occurs once; each product still verifies the sum.

## Branches for different demands

| Demand or structure | Implemented path |
|---|---|
| Zero or unit magnitude | Return zero or copy the other magnitude. |
| Equal magnitudes | Evaluate one square. |
| Adjacent magnitudes | Evaluate `a*a+a`. |
| Nearby magnitudes | Preserve a short half-distance before stripping trailing zeros. |
| Powers of two / trailing zero bits | Reduce magnitudes, use the same core, restore the shift. |
| Very unequal bit lengths | Split the long operand into chunks; use midpoint multiplication for each chunk with streamed carries. |
| General exact product | Evaluate the two midpoint squares independently, subtract, correct parity. |
| Small square | Eight-bit table or symmetric byte expansion using table-based midpoint digit products. |
| Sparse square argument | Accumulate one shifted row per set bit. |
| Suitable dense square argument | Square its shorter or sparse distance from a power of two. |
| General large square | Three-square recursion with equal-half reuse. |
| Bounded temporary-array count | `--mode compact`: bit-prefix recurrence; quadratic worst case. |
| Only the low L bits are needed | `--mod-bits L`: genuinely truncated square rows and modular arithmetic. |
| Repeated magnitude sum | `--cache-sum SUM`: reuse the midpoint square. |

`--mode auto|recursive|sparse|compact` selects the exact square policy. Cheap
product, table, and trailing-zero reductions still apply. Modular products have
their own truncated evaluator. AUTO thresholds are configurable engineering
defaults, not established optimal values. Current Mac-tuned defaults are a
32-bit leaf cutoff, a maximum sparse count of 32, complement handling enabled,
and a blocking ratio of four. AUTO classifies only above the leaf cutoff and
16 bits; sparse selection also requires at most one set bit per 16 input bits.

## Library API

The build produces `build/libxub.a`; public declarations are in
[include/xub.h](include/xub.h). Link the library after your object files.
Initialize each integer with `xub_init`, each context with `xub_context_init`,
and release integers with `xub_free`. **Contexts now retain scratch buffers:**
call `xub_context_free` before discarding a context. `xub_context_trim` releases
retained scratch between calls while preserving options, tables, and counters.
Do not reinitialize a live context or copy its struct. The integer's fields are
also library-owned; use `xub_copy` instead of copying the struct. Each thread
needs its own context. Callers using the earlier header must recompile.

Main operations are `xub_square`, `xub_mul`, `xub_mul_mod2`, and the
`xub_cache_prepare`/`xub_mul_cached` pair. Public arithmetic permits its result
to alias an input and preserves the prior result on error. Cache-owned fields
cannot be result destinations. `xub_parse` accepts signed decimal, hexadecimal,
or binary text; `xub_format` returns an allocated string that the caller frees.

The code uses 32-bit limbs and 64-bit unsigned intermediates for carries and
shifts. It allocates dynamically and is data-dependent. It is a portable research
implementation, without a constant-time guarantee or a no-heap embedded profile.
Warm calls can reuse capacity held by the context and output; first calls and
larger operands may still allocate. Trimming trades that reuse for lower retained
memory. Recursive halves are read-only views, and byte-sized blocked products
stream through the same midpoint table without a temporary integer per byte.

## Validation and measurements

```sh
make test       # C API tests plus Python integer oracle
make ubsan      # undefined-behavior sanitizer, including a reduced oracle
make sanitize  # address + undefined-behavior sanitizers
make benchmark # portable implementation comparisons; writes build/benchmarks.csv
make profile   # separate allocation accounting and allocation-failure tests
make profile-v1 # the same profiler against the archived v1 implementation
make tune      # training search and fresh-seed validation; longer than tests
```

On the available ARM64 Mac, the strict C11 build and 12,966 C checks passed.
The full Python oracle checked 69,303 products, including all 65,536 signed
eight-bit pairs, all four square policies, and operands through 16,384 bits.
UBSan passed the C checks and 3,275 additional oracle products through 8,193 bits.
AddressSanitizer stalls before `main` on this host, including for `--help`;
therefore an ASan pass is not claimed. Generated oracle reports are in `build/`.

The [version 2 optimization report](optimization-results.md) records the new
implementation, allocation traffic and retained memory, training/validation
split, and comparisons against a rebuilt v1. Sampled 4,096-bit general products
are 2.96 times faster than v1, but still take 1.56 times as long as the updated
direct shift/add comparator, which also reuses buffers. Byte-blocked 4,096-bit
products by 67 improved by about 136 times over v1.

The selected settings reduced the equal-group aggregate CPU-time measure by
56.4% on fresh held-out inputs relative to the optimized code's untuned settings.
This is distinct from the speed improvement over v1. The final allocation
profile passed 673 checks, including injected allocation failures and recovery.
The sampled 4,096-bit product performs zero allocation attempts on steady
repeated calls, retaining 32,320 bytes of scratch in addition to the fixture and
output. Trimming releases that scratch. Profiling counts requested heap payload;
it does not measure total process RAM or stack usage.

[Version 1 measurements](portable-results.md) and the older
[prototype measurements](benchmark-results.md) remain separate historical
records. All current measurements remain on the Mac by request. A
multiplication-limited target, target-specific assembly, and energy measurements
remain future work.

## Thesis and research record

- [Current thesis, Markdown](thesis.md) and [LaTeX source](thesis.tex): proof,
  square algorithms, demand-based dispatch, edge cases, tradeoffs, and limits.
- [Portable C kernel](src/xub_mul.c) and [integer primitives](src/xub_int.c).
- [Historical measurements](benchmark-results.md), [improvements](improvements.md),
  and [edge-case analysis](edge-cases.md).
- [Portable C measurements](portable-results.md), with archived raw results and
  source hashes separate from the earlier prototypes.
- [Version 2 optimization results](optimization-results.md): tuning, timing,
  allocation, retained-memory tradeoffs, and reproduction commands.
- [Research notebook](research.md) and [requests and decisions](discussion.md).
- [Scratch reference](.scratchpad/verify_midpoint.py) and other retained experiments
  under `.scratchpad/`.

Assembly is deferred by the user's choice: **portable C first; choose assembly
later**. LaTeX source is supplied; no PDF is claimed because this environment has
no TeX compiler. With a TeX installation, run `pdflatex thesis.tex` twice.

