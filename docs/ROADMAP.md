# Roadmap

Legend: `[x]` done · `[ ]` todo. Each core item is "done" only when its golden test is green on all three OSes.

## Phase 0 - Foundation
- [x] Repo skeleton (core / app / golden / CI / release workflow)
- [x] Golden harness with auto-skip for unported modules
- [ ] Run `tools/bootstrap.sh`, commit generated `app/android|windows|macos|linux`
- [ ] Choose license, add `LICENSE`
- [ ] Push to GitHub, confirm CI is green

## Phase 1 - Core port (`packages/core`)
- [ ] `format.dart`: `fmtFixed`, `fmtG`, `pyRound` (`test/format_test.dart`)
- [ ] `numparse.dart` (`parse.json`)
- [ ] `expression.dart` (`expression.json`)
- [ ] `mt19937.dart` (`mc.json` -> rng)
- [ ] `stats.dart`: `pctl`, `pStreak`, `tradeResult`, `journalStats`, `mcRun`
- [ ] Calculators, simplest first: quick, pnl, size, rr, liq, fund, comp, dd, kelly, scale, dca, fib, pivot
- [ ] Monte Carlo end to end (`mc_full.json`)

## Phase 2 - Design system
- [ ] Bundle fonts, finalise tokens
- [ ] Components: number field, segmented control, result card, verdict banner, copy button
- [ ] Mock-ups for phone and desktop (review before coding the screens)

## Phase 3 - Screens
- [ ] Calculator screens (form + live result), tone colours from core
- [ ] Charts: compounding curve, Fibonacci / pivot ladders, liquidation distance
- [ ] Scientific calculator (history, DEG/RAD, `ans`)
- [ ] Monte Carlo simulator (fan chart, percentile bands)

## Phase 4 - Journal and settings
- [ ] SQLite (`drift`) journal, stats screen, equity curve
- [ ] CSV import / export
- [ ] Settings (fee, leverage, risk, mmr, theme, language), persisted
- [ ] Persian digits in the UI layer, Jalali dates

## Phase 5 - Release engineering
- [ ] Android keystore + secrets, signed APK/AAB ([RELEASING.md](RELEASING.md))
- [ ] First pre-release `v0.1.0-beta.1`, test on all four platforms
- [ ] Linux AppImage/.deb, Windows installer
- [ ] "New version available" check against the GitHub Releases API
- [ ] Optional: macOS notarization, Windows signing, winget / Homebrew / Flathub

## Phase 6 - Polish
- [ ] Accessibility (contrast, screen readers, text scaling)
- [ ] Golden image tests for key screens
- [ ] Performance pass (Monte Carlo in an isolate)
- [ ] Opt-in crash reporting (only if wanted)
