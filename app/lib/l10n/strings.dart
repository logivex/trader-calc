import 'package:flutter/widgets.dart';

/// Minimal fa/en string table for the skeleton. Replace with ARB + gen-l10n
/// once the copy stabilises (Phase 5). The core's own result strings stay
/// English (they are the golden reference); the UI localises around them.
class S {
  const S(this.locale);

  final Locale locale;

  bool get isFa => locale.languageCode == 'fa';

  String _t(String fa, String en) => isFa ? fa : en;

  String get appName => 'Logivex Trader Calc';

  String groupTitle(String key) => switch (key) {
        'position' => _t('پوزیشن', 'Position'),
        'risk' => _t('ریسک', 'Risk'),
        'plan' => _t('برنامه‌ریزی', 'Planning'),
        'levels' => _t('سطوح قیمتی', 'Price levels'),
        _ => key,
      };

  String readyCount(int ready, int total) =>
      _t('$ready از $total آماده', '$ready of $total ready');
  String get navCalculators => _t('ماشین‌حساب‌ها', 'Calculators');
  String get navScientific => _t('علمی', 'Scientific');
  String get navSimulator => _t('شبیه‌ساز', 'Simulator');
  String get navJournal => _t('ژورنال', 'Journal');
  String get navSettings => _t('تنظیمات', 'Settings');
  String get notPorted =>
      _t('هسته‌ی این ماشین‌حساب هنوز پورت نشده است.', 'This calculator core is not ported yet.');
  String get ready => _t('هسته آماده است', 'Core ready');

  String calcTitle(String id) => (isFa ? _calcFa : _calcEn)[id] ?? id;

  static const _calcFa = {
    'quick': 'سود و زیان سریع',
    'pnl': 'سود/زیان فیوچرز',
    'size': 'حجم پوزیشن',
    'rr': 'ریسک به ریوارد',
    'scale': 'خروج پله‌ای',
    'dca': 'میانگین‌گیری (DCA)',
    'liq': 'قیمت لیکوئید',
    'fund': 'هزینه‌ی فاندینگ',
    'comp': 'سود مرکب',
    'dd': 'ریکاوری دراودان',
    'kelly': 'کلی و لبه‌ی آماری',
    'fib': 'فیبوناچی',
    'pivot': 'پیوت پوینت',
  };

  static const _calcEn = {
    'quick': 'Quick P/L',
    'pnl': 'Futures PnL',
    'size': 'Position size',
    'rr': 'Risk / Reward',
    'scale': 'Scale-out plan',
    'dca': 'Average entry (DCA)',
    'liq': 'Liquidation price',
    'fund': 'Funding cost',
    'comp': 'Compounding',
    'dd': 'Drawdown recovery',
    'kelly': 'Kelly & edge',
    'fib': 'Fibonacci',
    'pivot': 'Pivot points',
  };
}
