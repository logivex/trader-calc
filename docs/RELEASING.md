# Releasing

## Normal release

```bash
# 1. bump version in app/pubspec.yaml (e.g. 0.2.0+2) and commit
git tag v0.2.0
git push origin main --tags
```

`.github/workflows/release.yml` then: runs the core golden tests -> builds Android, Windows, macOS, Linux
in parallel -> publishes one GitHub Release with `SHA256SUMS.txt` and auto-generated notes.
A tag with a dash (`v0.2.0-beta.1`) is published as a pre-release.

## One-time setup

### 1. Platform folders
Run `./tools/bootstrap.sh` once and commit `app/android`, `app/windows`, `app/macos`, `app/linux`.
(CI generates them on the fly if missing, but committing makes builds reproducible and lets you edit
app icons, bundle ids and permissions.)

### 2. Android signing (required for updates to install over each other)

```bash
keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
base64 -w0 upload-keystore.jks   # macOS: base64 -i upload-keystore.jks
```

Add GitHub repo secrets: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`
(`upload`), `ANDROID_KEY_PASSWORD`.

**Keep the .jks and passwords backed up somewhere safe. If you lose them you cannot ship updates
that install over existing installs.**

Then wire the signing config once in `app/android/app/build.gradle(.kts)`: load `key.properties`
(the workflow writes it from the secrets) and use it in a `release` signing config instead of the
default debug signing. See https://docs.flutter.dev/deployment/android#sign-the-app.

### 3. Optional signing (removes OS warnings)
- **macOS**: Apple Developer account (paid) -> Developer ID certificate + notarization. Without it, users
  right-click > Open the first time.
- **Windows**: unsigned builds trigger SmartScreen. SignPath Foundation offers free signing for open source.

### 4. Distribution channels (later)
winget manifest, Homebrew cask, Flathub, F-Droid / Obtainium for Android.

## Pin the toolchain
`ci.yml` and `release.yml` use Flutter `stable`. Before the first public release, pin an exact version
(`flutter-version:` in `subosito/flutter-action`) so a Flutter update never changes a release build.
