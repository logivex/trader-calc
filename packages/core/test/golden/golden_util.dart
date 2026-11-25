import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

/// Finds `<repo>/golden` by walking up from the current directory
/// (tests normally run with cwd = `packages/core`).
Directory goldenDir() {
  final sep = Platform.pathSeparator;
  var dir = Directory.current;
  for (var i = 0; i < 6; i++) {
    final g = Directory('${dir.path}${sep}golden');
    if (File('${g.path}${sep}parse.json').existsSync()) return g;
    dir = dir.parent;
  }
  throw StateError(
      'golden/ directory not found from ${Directory.current.path}');
}

/// Loads `golden/<name>.json`.
Object? loadGolden(String name) {
  final f = File('${goldenDir().path}${Platform.pathSeparator}$name.json');
  return jsonDecode(f.readAsStringSync());
}

/// True when [probe] runs without hitting a not-yet-ported stub.
/// Golden tests use it to skip themselves until the code under test exists.
bool isPorted(void Function() probe) {
  try {
    probe();
    return true;
  } on UnimplementedError {
    return false;
  } catch (_) {
    return true; // implemented (it may legitimately throw for the probe input)
  }
}

const _tagged = {'NaN', 'Infinity', '-Infinity'};

double _untag(String s) => switch (s) {
      'NaN' => double.nan,
      'Infinity' => double.infinity,
      _ => double.negativeInfinity,
    };

String? _numDiff(double a, double e, String path, double rel) {
  final bad = '$path: expected $e, got $a';
  if (e.isNaN || a.isNaN) return (e.isNaN && a.isNaN) ? null : bad;
  if (e.isInfinite || a.isInfinite) return a == e ? null : bad;
  final scale = a.abs() > e.abs() ? a.abs() : e.abs();
  return (a - e).abs() <= rel * scale ? null : bad;
}

/// Compares [actual] with golden [expected] following the rules in
/// `golden/README.md`:
/// * strings -> exact match
/// * numbers -> relative tolerance [rel] (default 1e-12)
/// * `"NaN"`, `"Infinity"`, `"-Infinity"` in the golden stand for those floats
///
/// Returns a description of the first mismatch, or null if equal.
String? goldenDiff(Object? actual, Object? expected,
    {String path = r'$', double rel = 1e-12}) {
  if (expected is String) {
    if (actual is num && _tagged.contains(expected)) {
      return _numDiff(actual.toDouble(), _untag(expected), path, rel);
    }
    return actual == expected
        ? null
        : '$path: expected "$expected", got "$actual"';
  }
  if (expected is num) {
    if (actual is! num) return '$path: expected number $expected, got $actual';
    return _numDiff(actual.toDouble(), expected.toDouble(), path, rel);
  }
  if (expected is List) {
    if (actual is! List) return '$path: expected list, got $actual';
    if (actual.length != expected.length) {
      return '$path: expected length ${expected.length}, got ${actual.length}';
    }
    for (var i = 0; i < expected.length; i++) {
      final d = goldenDiff(actual[i], expected[i], path: '$path[$i]', rel: rel);
      if (d != null) return d;
    }
    return null;
  }
  if (expected is Map) {
    if (actual is! Map) return '$path: expected map, got $actual';
    for (final k in expected.keys) {
      if (!actual.containsKey(k)) return '$path.$k: missing';
      final d = goldenDiff(actual[k], expected[k], path: '$path.$k', rel: rel);
      if (d != null) return d;
    }
    for (final k in actual.keys) {
      if (!expected.containsKey(k)) return '$path.$k: unexpected key';
    }
    return null;
  }
  return actual == expected ? null : '$path: expected $expected, got $actual';
}

/// Fails the test with a readable message when [actual] differs from [expected].
void expectGolden(Object? actual, Object? expected, {double rel = 1e-12}) {
  final d = goldenDiff(actual, expected, rel: rel);
  if (d != null) fail(d);
}

/// Golden inputs decode ints and doubles differently (`10` vs `10.0`);
/// calculators take doubles, so normalise every number.
Map<String, Object?> normalizeInput(Map<String, dynamic> raw) => {
      for (final e in raw.entries)
        e.key: e.value is num ? (e.value as num).toDouble() : e.value,
    };
