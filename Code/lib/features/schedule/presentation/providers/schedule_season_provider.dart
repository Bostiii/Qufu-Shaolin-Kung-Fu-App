import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qufu_shaolin_app/core/storage/storage_providers.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_season.dart';

const _seasonKey = 'schedule_season';

/// Summer / winter timetable, saved on the phone. Default: summer.
class ScheduleSeasonNotifier extends Notifier<ScheduleSeason> {
  @override
  ScheduleSeason build() {
    final saved = ref.read(sharedPreferencesProvider).getString(_seasonKey);
    return saved == ScheduleSeason.winter.name
        ? ScheduleSeason.winter
        : ScheduleSeason.summer;
  }

  Future<void> setSeason(ScheduleSeason season) async {
    state = season;
    await ref.read(sharedPreferencesProvider).setString(_seasonKey, season.name);
  }
}

final scheduleSeasonProvider =
    NotifierProvider<ScheduleSeasonNotifier, ScheduleSeason>(ScheduleSeasonNotifier.new);
