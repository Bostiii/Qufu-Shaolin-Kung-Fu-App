import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qufu_shaolin_app/features/schedule/data/datasources/schedule_local_data.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/providers/schedule_season_provider.dart';

/// Slots of the selected season (summer / winter, set in Settings).
final scheduleSlotsProvider = Provider<List<ScheduleSlot>>(
  (ref) => ScheduleLocalData.slotsFor(ref.watch(scheduleSeasonProvider)),
);

/// Wall-clock time at the school (China, UTC+8, no daylight saving),
/// whatever the phone's time zone is. The returned DateTime is flagged UTC but
/// its fields (weekday, hour, minute) are the school's local time.
DateTime schoolNow() => DateTime.now().toUtc().add(const Duration(hours: 8));

final _schoolClockProvider = StreamProvider<DateTime>((ref) async* {
  yield schoolNow();
  yield* Stream<DateTime>.periodic(const Duration(seconds: 15), (_) => schoolNow());
});

/// Debug only: lets you test other days / times. null = live time.
class ScheduleTestTime extends Notifier<DateTime?> {
  @override
  DateTime? build() => null;

  void setTime(DateTime? value) => state = value;
}

final scheduleTestTimeProvider =
    NotifierProvider<ScheduleTestTime, DateTime?>(ScheduleTestTime.new);

/// The time the schedule uses: the test time if set, otherwise live school time.
final scheduleNowProvider = Provider<DateTime>((ref) {
  final test = ref.watch(scheduleTestTimeProvider);
  if (test != null) return test;
  return ref.watch(_schoolClockProvider).value ?? schoolNow();
});
