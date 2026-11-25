/// User-tunable defaults that feed several calculators
/// (`fee` -> pnl/size/scale, `lev` -> size, `risk` -> size, `mmr` -> pnl/size/liq).
///
/// Defaults are taken from `settings` in `golden/calculators.json`.
class Settings {
  const Settings({
    this.fee = 0.05,
    this.lev = 10.0,
    this.risk = 1.0,
    this.mmr = 0.5,
  });

  /// Taker fee, percent per side.
  final double fee;

  /// Default leverage.
  final double lev;

  /// Default risk per trade, percent of balance.
  final double risk;

  /// Maintenance margin rate, percent.
  final double mmr;

  Settings copyWith({double? fee, double? lev, double? risk, double? mmr}) =>
      Settings(
        fee: fee ?? this.fee,
        lev: lev ?? this.lev,
        risk: risk ?? this.risk,
        mmr: mmr ?? this.mmr,
      );
}
