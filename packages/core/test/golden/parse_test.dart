import 'package:test/test.dart';
import 'package:trader_core/trader_core.dart';

import 'golden_util.dart';

void main() {
  final cases =
      (loadGolden('parse') as List<dynamic>).cast<Map<String, dynamic>>();
  final ported = isPorted(() => parseNumber('1'));

  group('parseNumber (golden/parse.json)', () {
    for (final c in cases) {
      final input = c['in'] as String;
      test('"$input"', () {
        if (c.containsKey('error')) {
          expect(() => parseNumber(input), throwsFormatException);
        } else if (c['out'] == null) {
          expect(parseNumber(input), isNull);
        } else {
          expectGolden(parseNumber(input), c['out']);
        }
      });
    }
  }, skip: ported ? false : 'parseNumber not ported yet');
}
