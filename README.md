# Trader Calc

A luxurious, cross-platform trader's calculator: 13 trading calculators, a scientific calculator,
a Monte Carlo simulator and a trade journal. Windows · macOS · Linux · Android.
Persian (RTL) and English.

> Status: **skeleton** - the UI shell runs, the core port is in progress (see [docs/ROADMAP.md](docs/ROADMAP.md)).

## Layout

```
packages/core/   pure-Dart calculation core (no Flutter). Verified against /golden
golden/          frozen, language-neutral expected outputs: the specification of the core
app/             Flutter UI
tools/           bootstrap scripts, golden generator
docs/            architecture, design system, roadmap, release guide
.github/         CI + release workflows
```

## Getting started

1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) (stable).
2. Run `./tools/bootstrap.sh` (Windows: `.\tools\bootstrap.ps1`). It runs the core tests, generates the
   platform folders in `app/` (commit them), and runs the app's tests.
3. `cd app && flutter run -d linux` (or `windows`, `macos`, an Android device).

Core only (no Flutter needed beyond the Dart SDK):

```bash
cd packages/core && dart pub get && dart test
```

Tests for modules that are not ported yet show up as **skipped**; each one switches on automatically
the moment its function stops throwing `UnimplementedError`.

## Releasing

`git tag v0.1.0 && git push origin v0.1.0` builds all platforms and publishes a GitHub Release.
First-time setup (Android signing, optional macOS/Windows signing): [docs/RELEASING.md](docs/RELEASING.md).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). `main` is protected: all changes go through a pull request with green CI.

## License

[MIT](LICENSE) (c) 2026 Logivex
