import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trader_calc_app/app.dart';

void main() {
  testWidgets('shell renders, shows the Logivex brand and the calculator index', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: TraderCalcApp()));
    await tester.pumpAndSettle();

    // Phone-sized default surface -> bottom navigation.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.textContaining('LOGIVEX'), findsOneWidget);
    // First calculator row (Persian title).
    expect(find.text('سود و زیان سریع'), findsOneWidget);
  });
}
