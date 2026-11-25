# One-time (and idempotent) project setup on Windows:  .\tools\bootstrap.ps1
$ErrorActionPreference = 'Stop'
Set-Location (Join-Path $PSScriptRoot '..')

if (-not (Get-Command flutter -ErrorAction SilentlyContinue)) {
  throw 'Flutter SDK not found. Install: https://docs.flutter.dev/get-started/install'
}

Write-Host '==> core: pub get + tests'
Push-Location packages/core; dart pub get; dart test; Pop-Location

Write-Host '==> app: generate platform folders'
Push-Location app
flutter create --project-name trader_calc_app --org app.tradercalc --platforms=android,windows,macos,linux .
flutter pub get; flutter analyze --no-fatal-infos; flutter test
Pop-Location

Write-Host 'Done. Run the app:  cd app; flutter run -d windows'
