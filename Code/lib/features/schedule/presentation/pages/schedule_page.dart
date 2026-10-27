import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:qufu_shaolin_app/core/common/widgets/notification_bell_button.dart';

import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_season.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/providers/schedule_season_provider.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_debug_panel.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_grid.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_legend.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_now_card.dart';

import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class SchedulePage extends ConsumerWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final slots = ref.watch(scheduleSlotsProvider);
    final now = ref.watch(scheduleNowProvider);
    final season = ref.watch(scheduleSeasonProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navSchedule),
        actions: const [NotificationBellButton()],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        children: [
          ScheduleNowCard(now: now, slots: slots),
          const SizedBox(height: 12),
          if (kDebugMode) ...[
            const ScheduleDebugPanel(),
            const SizedBox(height: 4),
          ],
          ScheduleGrid(slots: slots, now: now),
          const SizedBox(height: 14),
          const ScheduleLegend(),
          if (season == ScheduleSeason.winter) ...[
            const SizedBox(height: 12),
            Text(
              l10n.scheduleSeasonWinterHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
