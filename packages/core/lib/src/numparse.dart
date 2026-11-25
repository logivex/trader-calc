/// Parses a user-typed number.
///
/// Contract (see `golden/parse.json`):
/// * blank input -> `null`
/// * junk -> throws [FormatException]
/// * accepts Persian/Arabic digits and separators (`۱٬۲۳۴٫۵`), thousands
///   separators, a leading currency sign, a trailing `%`, unicode minus/en-dash,
///   exponent (`1e3`), and `k` / `m` / `b` suffixes (`2.5k`, `1.2m`, `3B`).
/// * `nan`, `inf`, `1e999`, `0x10`, `1..2`, `--1`, `12kk` are errors.
///
/// TODO(port): implement against `test/golden/parse_test.dart`.
double? parseNumber(String input) {
  throw UnimplementedError('parseNumber is not ported yet');
}
