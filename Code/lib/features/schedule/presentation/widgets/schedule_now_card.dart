import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/class_label.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_colors.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_grid.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

/// "Now, Tue 08:45 - Takedowns / Chin Na · Wing Chun" or "Free time".
class ScheduleNowCard extends StatelessWidget {
  const ScheduleNowCard({super.key, required this.now, required this.slots});

  final DateTime now;
  final List<ScheduleSlot> slots;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final day = now.weekday - 1;
    final minute = now.hour * 60 + now.minute;
    final current = [
      for (final s in slots)
        if (s.day == day && s.contains(minute))
          for (final i in s.items) i.id.label(l10n),
    ];
    final dayName = DateFormat.E(locale).format(DateTime(2026, 1, 5 + day));

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.schedule_rounded,
            size: 22,
            color: ScheduleColors.nowLine(theme.brightness),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l10n.scheduleNow} · $dayName ${formatMinutes(minute)}',
                  style: theme.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  current.isEmpty ? l10n.scheduleFreeTime : current.join(' · '),
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
