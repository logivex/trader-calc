import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/strings.dart';
import 'shell/adaptive_shell.dart';
import 'theme/app_theme.dart';

/// Persisted later (Phase 5: settings storage). For now: in-memory defaults.
final localeProvider = StateProvider<Locale>((ref) => const Locale('fa'));
final themeModeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

class TraderCalcApp extends ConsumerWidget {
  const TraderCalcApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final mode = ref.watch(themeModeProvider);
    return MaterialApp(
      title: S(locale).appName,
      debugShowCheckedModeBanner: false,
      locale: locale,
      supportedLocales: const [Locale('fa'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      themeMode: mode,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      home: const AdaptiveShell(),
    );
  }
}
