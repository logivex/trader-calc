import 'package:test/test.dart';
import 'package:trader_core/trader_core.dart';

import 'golden_util.dart';

void main() {
  final golden = loadGolden('stats') as Map<String, dynamic>;
  final ported = isPorted(() => pctl(const [1.0], 50));

  group('pctl (golden/stats.json)', () {
    final cases =
        (golden['pctl'] as List<dynamic>).cast<Map<String, dynamic>>();
    for (var i = 0; i < cases.length; i++) {
      final c = cases[i];
      test('#$i p=${c['p']}', () {
        final vals = [
          for (final v in c['vals'] as List<dynamic>) (v as num).toDouble()
        ]..sort();
        expectGolden(pctl(vals, (c['p'] as num).toDouble()), c['out']);
      });
    }
  }, skip: ported ? false : 'pctl not ported yet');

  // TODO(port): p_streak, trade_result, journal_stats (same file).
}
