import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:qufu_shaolin_app/features/schedule/data/datasources/schedule_local_data.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/providers/schedule_providers.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_grid.dart';

/// Debug builds only: pick any day / time to test the red line and the
/// "now" card. Not shown in release builds.
class ScheduleDebugPanel extends ConsumerWidget {
  const ScheduleDebugPanel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = ref.watch(scheduleNowProvider);
    final testing = ref.watch(scheduleTestTimeProvider) != null;
    final locale = Localizations.localeOf(context).toString();
    final day = now.weekday - 1;
    final minute = (now.hour * 60 + now.minute).clamp(
      ScheduleLocalData.startMinute,
      ScheduleLocalData.endMinute,
    );

    void apply(int d, int m) => ref
        .read(scheduleTestTimeProvider.notifier)
        .setTime(DateTime.utc(2026, 1, 5 + d, m ~/ 60, m % 60));

    return Row(
      children: [
        DropdownButton<int>(
          value: day,
          underline: const SizedBox.shrink(),
          items: [
            for (var i = 0; i < 7; i++)
              DropdownMenuItem(
                value: i,
                child: Text(DateFormat.E(locale).format(DateTime(2026, 1, 5 + i))),
              ),
          ],
          onChanged: (v) => apply(v ?? day, minute),
        ),
        Expanded(
          child: Slider(
            min: ScheduleLocalData.startMinute.toDouble(),
            max: ScheduleLocalData.endMinute.toDouble(),
            divisions: (ScheduleLocalData.endMinute - ScheduleLocalData.startMinute) ~/ 5,
            value: minute.toDouble(),
            onChanged: (v) => apply(day, v.round()),
          ),
        ),
        Text(formatMinutes(minute)),
        TextButton(
          onPressed: testing
              ? () => ref.read(scheduleTestTimeProvider.notifier).setTime(null)
              : null,
          child: const Text('Live'),
        ),
      ],
    );
  }
}
