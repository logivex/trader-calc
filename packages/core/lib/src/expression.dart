/// Scientific-calculator evaluator (`golden/expression.json`).
///
/// Supported by the reference: `+ - * / ^ ! %`, implicit multiplication
/// (`2(3)`, `2pi`), functions (`sin cos tan asin acos atan ln log log2 exp abs
/// cbrt floor ceil round sqrt √`), constants (`pi π e tau ans`), `mod`,
/// Persian/Arabic digits, `×` `÷` `**`. `%` is context-sensitive
/// (`200+10%` = 220, `10%` = 0.1). Angles in DEG or RAD.
class CalcError implements Exception {
  CalcError(this.message);

  /// One of: `Empty`, `Syntax error`, `Undefined`, `Cannot divide by zero`,
  /// `Result too large`, `Unknown name: <x>`, `Factorial needs a whole number >= 0`.
  final String message;

  @override
  String toString() => message;
}

/// Evaluates [expression]. Throws [CalcError].
///
/// TODO(port): implement against `test/golden/expression_test.dart`.
double calcEval(String expression, {required bool deg, double ans = 0}) {
  throw UnimplementedError('calcEval is not ported yet');
}

/// Display format of a result (`fmt_calc` in the reference).
String fmtCalc(double v) => throw UnimplementedError('fmtCalc is not ported yet');

/// Full-precision copy format (`raw_calc` in the reference).
String rawCalc(double v) => throw UnimplementedError('rawCalc is not ported yet');
