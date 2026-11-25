import 'package:test/test.dart';
import 'package:trader_core/trader_core.dart';

import 'golden_util.dart';

void main() {
  final cases = (loadGolden('expression') as List<dynamic>).cast<Map<String, dynamic>>();
  final ported = isPorted(() => calcEval('1', deg: true));

  group('calcEval (golden/expression.json)', () {
    for (var i = 0; i < cases.length; i++) {
      final c = cases[i];
      final input = c['in'] as String;
      final deg = c['deg'] as bool;
      final ans = (c['ans'] as num).toDouble();
      test('#$i ${deg ? "DEG" : "RAD"} "$input"', () {
        if (c.containsKey('error')) {
          expect(
            () => calcEval(input, deg: deg, ans: ans),
            throwsA(isA<CalcError>().having((e) => e.message, 'message', c['error'])),
          );
        } else {
          final v = calcEval(input, deg: deg, ans: ans);
          expectGolden(v, c['out']);
          expect(fmtCalc(v), c['fmt']);
          expect(rawCalc(v), c['raw']);
        }
      });
    }
  }, skip: ported ? false : 'calcEval not ported yet');
}
