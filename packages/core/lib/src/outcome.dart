/// Semantic colour of a result cell. The UI maps each tone to a design token.
enum Tone {
  /// Profit / good.
  pos,

  /// Loss / bad.
  neg,

  /// Caution.
  warn,

  /// Highlight / key figure.
  acc,

  /// Plain.
  neu;

  /// Parses the short names used in the golden files (`"pos"`, `"neg"`, ...).
  static Tone parse(String s) => Tone.values.firstWhere(
        (t) => t.name == s,
        orElse: () => throw FormatException('Unknown tone: $s'),
      );
}

/// One formatted result cell. [text] is the **English reference string**;
/// it must match the golden files exactly. Localisation happens in the UI layer.
class Cell {
  const Cell(this.text, this.tone);

  final String text;
  final Tone tone;

  @override
  String toString() => 'Cell($text, ${tone.name})';

  @override
  bool operator ==(Object other) =>
      other is Cell && other.text == text && other.tone == tone;

  @override
  int get hashCode => Object.hash(text, tone);
}

/// What a calculator returns. Mirrors the three shapes in `calculators.json`:
/// a list of cells (+ ctx), a validation message string, or a raised error.
sealed class CalcOutcome {
  const CalcOutcome();
}

/// Successful run. [ctx] carries the extras the UI needs (verdict, chart data...).
/// Values are plain JSON-like data: num, String, List, Map.
final class CalcCells extends CalcOutcome {
  const CalcCells(this.cells, [this.ctx = const {}]);

  final List<Cell> cells;
  final Map<String, Object?> ctx;
}

/// Input validation message shown to the user (English reference text).
final class CalcMessage extends CalcOutcome {
  const CalcMessage(this.message);

  final String message;
}

/// The reference core raised (ZeroDivisionError, ValueError, OverflowError).
/// The UI shows a generic "can't calculate" message.
final class CalcRaised extends CalcOutcome {
  const CalcRaised(this.kind);

  final String kind;
}
