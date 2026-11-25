# Fonts

Bundle fonts instead of using `google_fonts` at runtime, so the app is offline-first
and looks identical on every platform.

| family | use | where to get it (both are OFL / free) |
|---|---|---|
| Vazirmatn | Persian UI text (also has Latin glyphs) | https://github.com/rastikerdar/vazirmatn |
| Inter | Latin text and figures | https://rsms.me/inter/ |

Put these files here, then uncomment the `fonts:` block in `app/pubspec.yaml`:

- `Vazirmatn-Regular.ttf`, `Vazirmatn-Medium.ttf`, `Vazirmatn-Bold.ttf`
- `Inter-Regular.ttf`, `Inter-SemiBold.ttf`

Numbers always use tabular figures (`FontFeature.tabularFigures()`), see `lib/theme/app_theme.dart`.
