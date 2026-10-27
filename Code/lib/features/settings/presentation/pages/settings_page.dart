import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_season.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/providers/schedule_season_provider.dart';
import 'package:qufu_shaolin_app/features/settings/presentation/providers/locale_provider.dart';
import 'package:qufu_shaolin_app/features/settings/presentation/widgets/theme_slider.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final current = Localizations.localeOf(context).languageCode;
    final season = ref.watch(scheduleSeasonProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(l10n.languageLabel, style: theme.textTheme.titleMedium),
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
          ListTile(
            leading: const Icon(Icons.brightness_6_outlined),
            title: Text(l10n.theme),
            trailing: const ThemeSlider(),
          ),
          const SizedBox(height: 16),
          Text(l10n.scheduleSeasonLabel, style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          SegmentedButton<ScheduleSeason>(
            segments: [
              ButtonSegment(
                value: ScheduleSeason.summer,
                icon: const Icon(Icons.wb_sunny_outlined),
                label: Text(l10n.scheduleSeasonSummer),
              ),
              ButtonSegment(
                value: ScheduleSeason.winter,
                icon: const Icon(Icons.ac_unit),
                label: Text(l10n.scheduleSeasonWinter),
              ),
            ],
            selected: {season},
            onSelectionChanged: (selection) => ref
                .read(scheduleSeasonProvider.notifier)
                .setSeason(selection.first),
          ),
          const SizedBox(height: 8),
          Text(
            season == ScheduleSeason.winter
                ? l10n.scheduleSeasonWinterHint
                : l10n.scheduleSeasonSummerHint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
