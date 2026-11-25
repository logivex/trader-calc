import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../features/calculators/calculators_home.dart';
import '../l10n/strings.dart';
import '../theme/tokens.dart';
import 'brand.dart';

/// Phone: bottom navigation. Desktop / tablet (>= 840 px): navigation rail
/// with the Logivex mark on top.
class AdaptiveShell extends ConsumerStatefulWidget {
  const AdaptiveShell({super.key});

  @override
  ConsumerState<AdaptiveShell> createState() => _AdaptiveShellState();
}

class _AdaptiveShellState extends ConsumerState<AdaptiveShell> {
  int _index = 0;

  static const _icons = <IconData>[
    Icons.calculate_outlined,
    Icons.functions_rounded,
    Icons.auto_graph_rounded,
    Icons.menu_book_outlined,
    Icons.tune_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    final s = S(ref.watch(localeProvider));
    final labels = [s.navCalculators, s.navScientific, s.navSimulator, s.navJournal, s.navSettings];
    final body = _index == 0
        ? const CalculatorsHome()
        : Center(child: Text(labels[_index])); // TODO: scientific / simulator / journal / settings

    return LayoutBuilder(
      builder: (context, box) {
        if (box.maxWidth >= 840) {
          final extended = box.maxWidth >= 1100;
          return Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: extended,
                  labelType: extended ? NavigationRailLabelType.none : NavigationRailLabelType.all,
                  selectedIndex: _index,
                  onDestinationSelected: (i) => setState(() => _index = i),
                  leading: Padding(
                    padding: const EdgeInsets.fromLTRB(Gap.md, Gap.lg, Gap.md, Gap.lg),
                    child: extended ? const BrandLockup() : const BrandMark(),
                  ),
                  destinations: [
                    for (var i = 0; i < labels.length; i++)
                      NavigationRailDestination(icon: Icon(_icons[i]), label: Text(labels[i])),
                  ],
                ),
                Expanded(child: SafeArea(child: body)),
              ],
            ),
          );
        }
        return Scaffold(
          body: SafeArea(child: body),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              for (var i = 0; i < labels.length; i++)
                NavigationDestination(icon: Icon(_icons[i]), label: labels[i]),
            ],
          ),
        );
      },
    );
  }
}
