# Multiplication through subtraction of squares

Portable C11 version 1 implements exact signed arbitrary-precision multiplication
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
defaults, not established optimal values.

## Library API

The build produces `build/libxub.a`; public declarations are in
[include/xub.h](include/xub.h). Link the library after your object files.
Initialize each integer with `xub_init`, each context with `xub_context_init`,
and release integers with `xub_free`. The integer's fields are library-owned;
use `xub_copy` instead of copying the struct. Each thread needs its own context.

Main operations are `xub_square`, `xub_mul`, `xub_mul_mod2`, and the
`xub_cache_prepare`/`xub_mul_cached` pair. Public arithmetic permits its result
to alias an input and preserves the prior result on error. Cache-owned fields
cannot be result destinations. `xub_parse` accepts signed decimal, hexadecimal,
or binary text; `xub_format` returns an allocated string that the caller frees.

The code uses 32-bit limbs and 64-bit unsigned intermediates for carries and
shifts. It allocates dynamically and is data-dependent. It is a portable research
implementation, without a constant-time guarantee or a no-heap embedded profile.

## Validation and measurements

```sh
make test       # C API tests plus Python integer oracle
make ubsan      # undefined-behavior sanitizer, including a reduced oracle
make sanitize  # address + undefined-behavior sanitizers
make benchmark # portable implementation comparisons; writes build/benchmarks.csv
```

On the available ARM64 Mac, the strict C11 build and 1,583 C checks passed.
The full Python oracle checked 69,303 products, including all 65,536 signed
eight-bit pairs, all four square policies, and operands through 16,384 bits.
UBSan passed the C checks and 3,275 additional oracle products through 8,193 bits.
AddressSanitizer stalls before `main` on this host, including for `--help`;
therefore an ASan pass is not claimed. Generated oracle reports are in `build/`.

Clang static analysis also emitted no diagnostics. The earlier prototypes showed
useful bounded-table and sparse-square gains,
but no general large-integer multiplication advantage over the tested software
comparisons. Their timings belong to those prototypes. See
[historical measurements](benchmark-results.md) and the thesis for the scope of
the evidence. [New portable-library measurements](portable-results.md) show useful
structured-square and cache gains, while sampled general 4,096-bit multiplication
is 4.30 times slower than direct shift/add. A multiplication-limited target,
target-specific assembly, energy,
and peak working-memory measurements remain to be selected or measured.

## Thesis and research record

- [Version 1 thesis, Markdown](thesis.md) and [LaTeX source](thesis.tex): proof,
  square algorithms, demand-based dispatch, edge cases, tradeoffs, and limits.
- [Portable C kernel](src/xub_mul.c) and [integer primitives](src/xub_int.c).
- [Historical measurements](benchmark-results.md), [improvements](improvements.md),
  and [edge-case analysis](edge-cases.md).
- [Portable C measurements](portable-results.md), with archived raw results and
  source hashes separate from the earlier prototypes.
- [Research notebook](research.md) and [requests and decisions](discussion.md).
- [Scratch reference](.scratchpad/verify_midpoint.py) and other retained experiments
  under `.scratchpad/`.

Assembly is deferred by the user's choice: **portable C first; choose assembly
later**. LaTeX source is supplied; no PDF is claimed because this environment has
no TeX compiler. With a TeX installation, run `pdflatex thesis.tex` twice.

