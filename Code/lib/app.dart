import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qufu_shaolin_app/core/config/router/app_router.dart';
import 'package:qufu_shaolin_app/core/config/theme/app_theme.dart';
import 'package:qufu_shaolin_app/core/config/theme/theme_provider.dart';

import 'package:qufu_shaolin_app/features/settings/presentation/providers/locale_provider.dart';

import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      routerConfig: ref.watch(routerProvider),
      locale: ref.watch(localeProvider),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
