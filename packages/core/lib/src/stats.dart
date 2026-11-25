/// Statistics helpers (`golden/stats.json`, `golden/mc.json`).
///
/// TODO(port): `pctl`, `pStreak`, `tradeResult`, `journalStats`, `mcRun`.
/// Expected behaviour (see the matching cases in the golden files):
///
/// * `pctl(sortedValues, p)`          -> linear-interpolated percentile, 0 for empty
/// * `pStreak(q, k, n)`               -> probability of a k-long losing streak in n trades
/// * `tradeResult(side, en, ex, qty, fee, risk)` -> (pnl, r-multiple, ...)
/// * `journalStats(trades)`           -> n, wins, losses, wr, net, pf, avg_win, avg_loss,
///                                       exp, avg_r, best, worst, mdd, eq[], streak
/// * `mcRun(start, w, rr, risk, n, sims, seed)` -> (idxs, cols, finals, mdds)
double pctl(List<double> sortedValues, double p) =>
    throw UnimplementedError('pctl is not ported yet');
