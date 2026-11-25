import 'package:flutter/material.dart';

import 'tokens.dart';

/// Style for every figure on screen: tabular digits keep columns from jittering
/// while values animate.
const TextStyle numberStyle = TextStyle(
  fontFeatures: [FontFeature.tabularFigures()],
  fontFamilyFallback: ['Inter'],
);

ThemeData buildTheme(Brightness brightness) {
  final c = brightness == Brightness.dark ? TraderColors.dark : TraderColors.light;
  final scheme = ColorScheme(
    brightness: brightness,
    primary: c.accent,
    onPrimary: c.onAccent,
    secondary: c.accent,
    onSecondary: c.onAccent,
    error: c.neg,
    onError: Colors.white,
    surface: c.surface,
    onSurface: c.text,
    outline: c.outline,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: c.bg,
    fontFamily: 'Vazirmatn',
    fontFamilyFallback: const ['Inter'],
    extensions: <ThemeExtension<dynamic>>[c],
    dividerColor: c.outline,
    splashFactory: NoSplash.splashFactory,
    hoverColor: c.text.withValues(alpha: 0.04),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: c.surface,
      indicatorColor: c.accent.withValues(alpha: 0.14),
      labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 12, color: c.textDim),
      ),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: c.surface,
      indicatorColor: c.accent.withValues(alpha: 0.14),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: c.surfaceHigh,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.field),
        borderSide: BorderSide(color: c.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.field),
        borderSide: BorderSide(color: c.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Radii.field),
        borderSide: BorderSide(color: c.accent, width: 1.5),
      ),
    ),
  );
}
