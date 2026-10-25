import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qufu_shaolin_app/features/settings/presentation/providers/locale_provider.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.languageLabel,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'en', label: Text(l10n.languageEnglish)),
              ButtonSegment(value: 'zh', label: Text(l10n.languageChinese)),
            ],
            selected: {current},
            onSelectionChanged: (selection) => ref
                .read(localeProvider.notifier)
                .setLocale(Locale(selection.first)),
          ),
        ],
      ),
    );
  }
}
