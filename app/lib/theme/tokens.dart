import 'package:flutter/material.dart';
import 'package:trader_core/trader_core.dart';

/// Design tokens: one place for every colour, radius and spacing value.
/// See docs/DESIGN.md.
///
/// The palette is deliberately restrained: warm graphite (or paper) surfaces,
/// a single "bone / ink" accent, and colour ONLY where it carries meaning
/// (profit, loss, caution).
class TraderColors extends ThemeExtension<TraderColors> {
  const TraderColors({
    required this.bg,
    required this.surface,
    required this.surfaceHigh,
    required this.outline,
    required this.text,
    required this.textDim,
    required this.accent,
    required this.onAccent,
    required this.pos,
    required this.neg,
    required this.warn,
  });

  final Color bg;
  final Color surface;
  final Color surfaceHigh;
  final Color outline;
  final Color text;
  final Color textDim;

  /// Selection / emphasis; also the `acc` tone. Bone in dark, ink in light.
  final Color accent;
  final Color onAccent;
  final Color pos;
  final Color neg;
  final Color warn;

  static const dark = TraderColors(
    bg: Color(0xFF0F1114),
    surface: Color(0xFF15181C),
    surfaceHigh: Color(0xFF1C2025),
    outline: Color(0xFF2A2F36),
    text: Color(0xFFE8E6E1),
    textDim: Color(0xFF8B9099),
    accent: Color(0xFFE8E4D8),
    onAccent: Color(0xFF0F1114),
    pos: Color(0xFF3DDC97),
    neg: Color(0xFFFF5C72),
    warn: Color(0xFFF2B84B),
  );

  static const light = TraderColors(
    bg: Color(0xFFF4F2EC),
    surface: Color(0xFFFBFAF7),
    surfaceHigh: Color(0xFFEAE7DF),
    outline: Color(0xFFD8D4C8),
    text: Color(0xFF17181A),
    textDim: Color(0xFF6A6D74),
    accent: Color(0xFF17181A),
    onAccent: Color(0xFFF4F2EC),
    pos: Color(0xFF0E8F63),
    neg: Color(0xFFD0334A),
    warn: Color(0xFFA9701A),
  );

  /// Maps the core's semantic [Tone] to a colour.
  Color tone(Tone t) => switch (t) {
        Tone.pos => pos,
        Tone.neg => neg,
        Tone.warn => warn,
        Tone.acc => accent,
        Tone.neu => text,
      };

  @override
  TraderColors copyWith({
    Color? bg,
    Color? surface,
    Color? surfaceHigh,
    Color? outline,
    Color? text,
    Color? textDim,
    Color? accent,
    Color? onAccent,
    Color? pos,
    Color? neg,
    Color? warn,
  }) =>
      TraderColors(
        bg: bg ?? this.bg,
        surface: surface ?? this.surface,
        surfaceHigh: surfaceHigh ?? this.surfaceHigh,
        outline: outline ?? this.outline,
        text: text ?? this.text,
        textDim: textDim ?? this.textDim,
        accent: accent ?? this.accent,
        onAccent: onAccent ?? this.onAccent,
        pos: pos ?? this.pos,
        neg: neg ?? this.neg,
        warn: warn ?? this.warn,
      );

  @override
  TraderColors lerp(ThemeExtension<TraderColors>? other, double t) {
    if (other is! TraderColors) return this;
    return TraderColors(
      bg: Color.lerp(bg, other.bg, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      outline: Color.lerp(outline, other.outline, t)!,
      text: Color.lerp(text, other.text, t)!,
      textDim: Color.lerp(textDim, other.textDim, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      pos: Color.lerp(pos, other.pos, t)!,
      neg: Color.lerp(neg, other.neg, t)!,
      warn: Color.lerp(warn, other.warn, t)!,
    );
  }
}

/// Spacing scale (logical pixels).
abstract final class Gap {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 40;
}

/// Corner radii.
abstract final class Radii {
  static const double card = 12;
  static const double field = 10;
}

extension TraderTheme on BuildContext {
  TraderColors get colors => Theme.of(this).extension<TraderColors>()!;
}
