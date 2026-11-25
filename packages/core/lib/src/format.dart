/// Python-compatible number formatting.
///
/// This is the riskiest part of the port: do NOT use `intl` or
/// `toStringAsFixed` for it. Python formats the exact binary value and rounds
/// ties to even; JS/Dart-style `toStringAsFixed` can differ on ties such as
/// `0.125`. These functions must match the golden strings exactly.
///
/// TODO(port): implement and unit-test (see `test/format_test.dart`).

/// `f"{x:,.{decimals}f}"`, optionally with sign (`:+,.2f`) and no grouping.
String fmtFixed(
  double x,
  int decimals, {
  bool grouping = true,
  bool showPlus = false,
}) {
  throw UnimplementedError('fmtFixed is not ported yet');
}

/// `f"{x:.{significant}g}"` (Python `g` presentation, e.g. `:g`, `:.12g`, `:.3g`).
String fmtG(double x, {int significant = 6}) {
  throw UnimplementedError('fmtG is not ported yet');
}

/// Python `round(x)` (banker's rounding: `round(2.5) == 2`, `round(-2.5) == -2`).
/// Dart's `double.round()` rounds half away from zero, so it must NOT be used.
double pyRound(double x) {
  throw UnimplementedError('pyRound is not ported yet');
}
