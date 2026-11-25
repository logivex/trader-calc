import 'package:test/test.dart';
import 'package:trader_core/trader_core.dart';

import 'golden/golden_util.dart';

/// Hand-checked against CPython 3.13 (`python3 -c 'print(f"{0.125:.2f}")'`, ...).
/// These are the edge cases where Python and JS/Dart-style formatting differ.
void main() {
  final ported = isPorted(() => fmtFixed(1, 2));

  group('Python-compatible formatting', () {
    test('fixed + grouping', () {
      expect(fmtFixed(1234.5, 2), '1,234.50');
      expect(fmtFixed(1234567.891, 2), '1,234,567.89');
      expect(fmtFixed(1234.5, 2, showPlus: true), '+1,234.50');
      expect(fmtFixed(1234.5, 2, grouping: false), '1234.50');
    });

    test('ties round half to even on the exact binary value', () {
      expect(fmtFixed(0.125, 2), '0.12');
      expect(fmtFixed(2.5, 0), '2');
    });

    test('negative zero keeps its sign', () {
      expect(fmtFixed(-0.0, 2), '-0.00');
      expect(fmtFixed(-0.001, 2), '-0.00');
    });

    test('%g presentation', () {
      expect(fmtG(1e-7), '1e-07');
      expect(fmtG(123456789.0), '1.23457e+08');
      expect(fmtG(100000.0), '100000');
      expect(fmtG(1e6), '1e+06');
      expect(fmtG(0.0001), '0.0001');
      expect(fmtG(0.00001), '1e-05');
      expect(fmtG(0.1 + 0.2, significant: 12), '0.3');
      expect(fmtG(1 / 3, significant: 3), '0.333');
      expect(fmtG(123456789012345678.0, significant: 12), '1.23456789012e+17');
    });

    test("pyRound is banker's rounding", () {
      expect(pyRound(2.5), 2);
      expect(pyRound(3.5), 4);
      expect(pyRound(-2.5), -2);
      expect(pyRound(0.5), 0);
    });
  }, skip: ported ? false : 'format helpers not ported yet');
}
