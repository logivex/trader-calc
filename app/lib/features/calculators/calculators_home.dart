import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trader_core/trader_core.dart';

import '../../app.dart';
import '../../l10n/strings.dart';
import '../../theme/app_theme.dart';
import '../../theme/tokens.dart';

class _Group {
  const _Group(this.key, this.ids);

  final String key;
  final List<String> ids;
}

/// Calculators grouped by the question they answer, not as 13 identical tiles.
const _groups = <_Group>[
  _Group('position', ['quick', 'pnl', 'size', 'scale', 'dca']),
  _Group('risk', ['rr', 'liq', 'dd', 'kelly']),
  _Group('plan', ['fund', 'comp']),
  _Group('levels', ['fib', 'pivot']),
];

/// Home of the calculators: a quiet, typographic index.
class CalculatorsHome extends ConsumerWidget {
  const CalculatorsHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final s = S(ref.watch(localeProvider));
    final c = context.colors;
    final theme = Theme.of(context).textTheme;
    final total = _groups.fold<int>(0, (n, g) => n + g.ids.length);
    final ready = calculators.length;

    var index = 0;
    final children = <Widget>[
      Text(
        'LOGIVEX  ·  TRADER CALC',
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w600,
          letterSpacing: 2.2,
          color: c.textDim,
        ),
      ),
      const SizedBox(height: Gap.sm + 4),
      Text(
        s.navCalculators,
        style: theme.headlineMedium?.copyWith(fontWeight: FontWeight.w700, color: c.text),
      ),
      const SizedBox(height: Gap.xs),
      Text(s.readyCount(ready, total), style: theme.bodyMedium?.copyWith(color: c.textDim)),
      const SizedBox(height: Gap.xl),
    ];

    for (final g in _groups) {
      children.add(_GroupLabel(s.groupTitle(g.key)));
      for (final id in g.ids) {
        index++;
        children.add(
          _CalcRow(
            index: index.toString().padLeft(2, '0'),
            title: s.calcTitle(id),
            ready: calculators.containsKey(id),
          ),
        );
      }
      children.add(const SizedBox(height: Gap.lg + 4));
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(Gap.lg, Gap.xl, Gap.lg, Gap.xl),
          children: children,
        ),
      ),
    );
  }
}

class _GroupLabel extends StatelessWidget {
  const _GroupLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.xs),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: c.textDim,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _CalcRow extends StatelessWidget {
  const _CalcRow({required this.index, required this.title, required this.ready});

  final String index;
  final String title;
  final bool ready;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return InkWell(
      onTap: () {}, // TODO: open the calculator screen (Phase 3)
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: Gap.xs),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: c.outline)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 36,
              child: Text(
                index,
                style: numberStyle.copyWith(fontSize: 12, color: c.textDim),
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: c.text),
              ),
            ),
            _StatusDot(ready: ready),
          ],
        ),
      ),
    );
  }
}

/// Filled = ported and verified against the golden vectors. Hollow = not yet.
class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.ready});

  final bool ready;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: ready ? c.pos : null,
        border: ready ? null : Border.all(color: c.textDim.withValues(alpha: 0.7)),
      ),
    );
  }
}
