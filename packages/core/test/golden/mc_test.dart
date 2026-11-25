import 'package:test/test.dart';
import 'package:trader_core/trader_core.dart';

import 'golden_util.dart';

void main() {
  final golden = loadGolden('mc') as Map<String, dynamic>;
  final ported = isPorted(() => MersenneTwister.keyFromSeed(0));

  group('MT19937 stream (golden/mc.json -> rng)', () {
    final rng = (golden['rng'] as List<dynamic>).cast<Map<String, dynamic>>();
    for (final c in rng) {
      final seed = c['seed'] as int;
      test('seed $seed', () {
        final key = MersenneTwister.keyFromSeed(seed);
        expect(key, (c['key'] as List<dynamic>).cast<int>());
        final mt = MersenneTwister.fromKey(key);
        final first = (c['first'] as List<dynamic>).cast<double>();
        // The stream must match bit for bit.
        expect([for (var i = 0; i < first.length; i++) mt.nextDouble()], first);
      });
    }
  }, skip: ported ? false : 'MersenneTwister not ported yet');

  // TODO(port): `runs` (mc_run) and golden/mc_full.json (c_mc end to end):
  // implement mcRun in stats.dart, then add tests here comparing idxs, cols,
  // finals and mdds with goldenDiff (rel 1e-12).
}
