import 'package:test/test.dart';
import 'package:trader_core/trader_core.dart';

import 'golden_util.dart';

/// Converts an outcome to the same JSON shape the golden files use.
Map<String, Object?> outcomeToJson(CalcOutcome o) => switch (o) {
      CalcCells(:final cells, :final ctx) => {
          'out': [
            for (final c in cells) [c.text, c.tone.name],
          ],
          'ctx': ctx,
        },
      CalcMessage(:final message) => {'out': message, 'ctx': <String, Object?>{}},
      CalcRaised(:final kind) => {'raised': kind},
    };

Settings _settings(Map<String, dynamic> m) => Settings(
      fee: (m['fee'] as num).toDouble(),
      lev: (m['lev'] as num).toDouble(),
      risk: (m['risk'] as num).toDouble(),
      mmr: (m['mmr'] as num).toDouble(),
    );

void _check(String id, Map<String, dynamic> c, Settings s) {
  final input = normalizeInput(c['in'] as Map<String, dynamic>);
  final expected = <String, Object?>{
    for (final e in c.entries)
      if (e.key != 'in') e.key: e.value,
  };
  expectGolden(outcomeToJson(runCalculator(id, input, s)), expected);
}

void main() {
  final golden = loadGolden('calculators') as Map<String, dynamic>;
  final defaults = _settings(golden['settings'] as Map<String, dynamic>);
  final alt = defaults.copyWith(
    mmr: ((golden['settings_alt'] as Map<String, dynamic>)['mmr'] as num).toDouble(),
  );
  final altCases = golden['alt'] as Map<String, dynamic>;

  for (final id in calculatorIds) {
    final ported = calculators.containsKey(id);
    group('calculator "$id"', () {
      final cases = (golden[id] as List<dynamic>).cast<Map<String, dynamic>>();
      for (var i = 0; i < cases.length; i++) {
        test('case $i', () => _check(id, cases[i], defaults));
      }
      final extra = (altCases[id] as List<dynamic>?)?.cast<Map<String, dynamic>>() ?? const [];
      for (var i = 0; i < extra.length; i++) {
        test('alt settings (mmr=1.25) case $i', () => _check(id, extra[i], alt));
      }
    }, skip: ported ? false : 'not ported yet');
  }
}
