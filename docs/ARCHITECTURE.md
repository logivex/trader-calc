# Architecture

## Principles

1. **Golden vectors are the spec.** `golden/*.json` were generated once from the original implementation (which is not part of this repository) and are frozen. A function is "done"
   when its golden tests pass on Linux, Windows and macOS.
2. **Core is pure.** `packages/core` has no Flutter, no I/O, no global state. Settings are passed in.
   This keeps it testable with `dart test` and swappable (e.g. for a Rust core) without touching the UI.
3. **Structured results, localised UI.** Calculators return `Cell(text, tone)` + `ctx` using the English
   reference strings (needed for exact golden matching). The UI localises labels and may re-render
   numbers (Persian digits) *on top of* that; it never changes the core's output.
4. **Tokens, not literals.** Widgets read colours/spacing from `TraderColors`, `Gap`, `Radii`.

## Layers

```
 app/lib/features/*   screens (calculator forms, charts, journal)
 app/lib/theme        design tokens + ThemeData
 app/lib/l10n         fa / en strings
 ------------------------------------------------------------
 packages/core        parse -> calculators -> CalcOutcome(cells, ctx)
                      expression evaluator, Monte Carlo (MT19937), journal stats
```

## Core contract

| module | public API | golden file |
|---|---|---|
| `numparse` | `double? parseNumber(String)` (null = blank, throws `FormatException`) | `parse.json` |
| `expression` | `calcEval(expr, deg:, ans:)`, `fmtCalc`, `rawCalc`, `CalcError` | `expression.json` |
| `calculators/*` | `CalcFn = CalcOutcome Function(Map input, Settings)`; registered in `calculators` map | `calculators.json` |
| `mt19937` + `stats` | `MersenneTwister`, `pctl`, `pStreak`, `tradeResult`, `journalStats`, `mcRun` | `mc.json`, `stats.json` |
| `c_mc` pipeline | `calculators['mc']`-style end to end | `mc_full.json` |
| `format` | `fmtFixed`, `fmtG`, `pyRound` (Python-compatible) | indirectly everywhere |

`CalcOutcome` is one of `CalcCells(cells, ctx)`, `CalcMessage(text)` (validation), `CalcRaised(kind)`.

## Known porting traps

- Python formats the **exact** binary value and rounds ties to even: `f"{0.125:.2f}" == "0.12"`.
  Do not use `toStringAsFixed`/`intl` for core output.
- `round(2.5) == 2` in Python (banker's). Dart's `round()` gives 3.
- `:g` / `:.12g` / `:.3g` switch to exponent form (`1e-07`, `1e+06`) by Python's rules.
- MT19937: seeds >= 2^32 split into 32-bit words (little-endian); output is `genrand_res53`.
  Native targets only (32-bit multiplication overflows 2^53 on web).
- `"NaN"` / `"Infinity"` / `"-Infinity"` in golden JSON are strings standing for floats.
- Doubles in tests: JSON `10` decodes to `int` in Dart; normalise inputs to `double`.

## Persistence (Phase 5)

Journal in SQLite via `drift` (works on all four platforms), behind a `JournalRepository` interface so
the UI never touches SQL. Export/import as CSV.
