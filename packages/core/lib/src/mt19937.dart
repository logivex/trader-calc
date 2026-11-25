/// Mersenne Twister, bit-compatible with NumPy's legacy `RandomState`.
///
/// Required so Monte Carlo runs with the same seed give the same results as
/// the original implementation (`golden/mc.json`, `rng` section).
///
/// * seeding: `init_by_array(key)` where `key` = [seed] split into 32-bit words,
///   least significant first (`123456789012` -> `[3197704724, 28]`,
///   `2^32` -> `[0, 1]`, small seeds -> `[seed]`)
/// * output: `genrand_res53` = `(a >> 5, b >> 6)` -> `(a*67108864 + b) / 9007199254740992`
///
/// Native targets only: 32-bit multiplications overflow 2^53 on Dart-for-web.
///
/// TODO(port): implement against `test/golden/mc_test.dart`.
class MersenneTwister {
  MersenneTwister.fromKey(List<int> key) {
    throw UnimplementedError('MersenneTwister is not ported yet');
  }

  /// Splits [seed] into the 32-bit key words NumPy would use.
  static List<int> keyFromSeed(int seed) {
    throw UnimplementedError('keyFromSeed is not ported yet');
  }

  /// Next uniform double in [0, 1) with 53-bit resolution.
  double nextDouble() => throw UnimplementedError();
}
