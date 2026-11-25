import '../outcome.dart';
import '../settings.dart';

/// Signature every calculator implements. [input] holds the field values by
/// name exactly as in the golden `in` objects (numbers are `double?`, enums are
/// `String`: `side` = "Long" | "Short", fib `side` = "Up move" | "Down move",
/// pivot `method` = "Classic" | "Fibonacci" | "Camarilla" | "Woodie").
typedef CalcFn = CalcOutcome Function(Map<String, Object?> input, Settings s);

/// Stable calculator ids (same keys as `golden/calculators.json`).
const calculatorIds = <String>[
  'quick', // quick profit / loss
  'pnl', // futures PnL
  'size', // position size from risk
  'rr', // risk / reward
  'scale', // scale-out plan
  'dca', // average entry
  'liq', // liquidation price
  'fund', // funding cost
  'comp', // compounding
  'dd', // drawdown recovery
  'kelly', // Kelly / edge
  'fib', // Fibonacci levels
  'pivot', // pivot points
];

/// Port progress: add each calculator here as it is implemented and its golden
/// test goes green. Until then the golden test for it stays skipped.
final Map<String, CalcFn> calculators = <String, CalcFn>{
  // 'quick': cQuick,
};

/// Runs calculator [id]. Domain failures (division by zero, bad math) must be
/// reported as [CalcRaised] to match the reference.
CalcOutcome runCalculator(String id, Map<String, Object?> input, Settings s) {
  final fn = calculators[id];
  if (fn == null) {
    throw UnimplementedError('Calculator "$id" is not ported yet');
  }
  return fn(input, s);
}
