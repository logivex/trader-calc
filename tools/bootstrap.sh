#!/usr/bin/env bash
# One-time (and idempotent) project setup on your machine.
#   ./tools/bootstrap.sh
# Requires: Flutter SDK (stable) on PATH.
set -euo pipefail
cd "$(dirname "$0")/.."

command -v flutter >/dev/null || { echo "Flutter SDK not found. Install: https://docs.flutter.dev/get-started/install"; exit 1; }

echo "==> core: pub get + tests"
(cd packages/core && dart pub get && dart test)

echo "==> app: generate platform folders (skips files that already exist)"
(cd app && flutter create --project-name trader_calc_app --org app.tradercalc \
    --platforms=android,windows,macos,linux .)

echo "==> app: pub get + analyze + test"
(cd app && flutter pub get && flutter analyze --no-fatal-infos && flutter test)

echo
echo "Done. Run the app:  cd app && flutter run -d linux   # or windows / macos / an Android device"
