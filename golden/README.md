# Golden vectors for the Trader Calc core

Language-neutral expected outputs. They were generated once from the original implementation (kept
outside this repository) and are **frozen**: they are the specification the Dart core must reproduce.
They are not regenerated in CI and are not edited by hand in normal changes.

| file | what it checks |
|---|---|
| `parse.json` | `parse(str)` -> number, or `{"error": true}` (Persian digits, `k/m/b`, `%`, junk) |
| `expression.json` | scientific-calculator evaluator: value + `fmt_calc` + `raw_calc`, or an error message; DEG and RAD |
| `calculators.json` | all 13 calculators: input -> list of `[text, tone]` cells, or a message string; plus `ctx` (verdict, labels, chart data). `settings` = defaults used (`mmr`); `alt` = same with `mmr=1.25` |
| `mc.json` | raw Mersenne-Twister stream (`rng`) and `mc_run` results. **Seeds must stay compatible**: MT19937 `init_by_array(key)` + 53-bit `genrand_res53`, same as NumPy's legacy `RandomState` |
| `mc_full.json` | `c_mc` end to end (percentile bands, labels, verdict) |
| `stats.json` | `pctl`, `p_streak`, `trade_result`, `journal_stats` |

Comparison rules
- Strings (`text` in cells, `fmt`, `raw`, verdicts, messages): **exact match**. Number formatting
  (`:,.2f`, `:+,.2f`, `:g`, `:.12g`, `:.3g` style) is the riskiest part of a port, and exactly what these files catch.
- Raw numbers: relative tolerance 1e-12 (the Monte Carlo random stream and everything derived from it
  should match to the last bit).
- `"Infinity"`, `"-Infinity"`, `"NaN"` are JSON strings standing for the float values.
- Tuples are JSON lists; integer dict keys (percentiles in `ctx.mc.bands`) are JSON strings.
