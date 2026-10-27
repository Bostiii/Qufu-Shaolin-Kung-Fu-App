import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_season.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';

/// The school timetable, bundled in the app (works offline).
/// Later this can be replaced / updated by the backend.
///
/// Saturday and Sunday have no classes = free time.
/// Gaps between slots are free time too.
class ScheduleLocalData {
  ScheduleLocalData._();

  /// Visible range of the grid (minutes after midnight): 06:00 - 21:00.
  static const int startMinute = 6 * 60;
  static const int endMinute = 21 * 60;

  /// Gate closing time per day, Monday to Sunday.
  static const List<String> gateClose = [
    '21:30', '21:30', '21:30', '21:30', '22:00', '22:00', '20:30',
  ];

  static final List<ScheduleSlot> summerSlots = _build(ScheduleSeason.summer);
  static final List<ScheduleSlot> winterSlots = _build(ScheduleSeason.winter);

  static List<ScheduleSlot> slotsFor(ScheduleSeason season) =>
      season == ScheduleSeason.winter ? winterSlots : summerSlots;

  static int _m(int h, [int mi = 0]) => h * 60 + mi;

  /// Winter: everything after lunch (from 13:00 on) is 30 minutes earlier.
  /// Lunch itself and the gate closing times do not move.
  static List<ScheduleSlot> _build(ScheduleSeason season) {
    const martial = ClassKind.martial;
    const training = ClassKind.training;
    final out = <ScheduleSlot>[];

    for (var d = 0; d < 5; d++) {
      final tuesday = d == 1;
      final thursday = d == 3;

      void add(int s, int e, List<ClassItem> items) {
        final shift = season == ScheduleSeason.winter && s >= _m(13) ? 30 : 0;
        out.add(ScheduleSlot(day: d, start: s - shift, end: e - shift, items: items));
      }

      add(_m(6), _m(7), const [ClassItem(ClassId.taiChiOptional, ClassKind.optional)]);
      add(_m(7), _m(7, 30), const [ClassItem(ClassId.breakfast, ClassKind.meal)]);

      // 08:30 - 09:50
      add(
        _m(8, 30),
        _m(9, 50),
        thursday
            ? const [ClassItem(ClassId.qigong, training)]
            : [
                ClassItem(tuesday ? ClassId.takedownsChinNa : ClassId.shaolin, martial),
                const ClassItem(ClassId.wingChun, martial),
              ],
      );

      // 10:20 - 11:30
      add(
        _m(10, 20),
        _m(11, 30),
        thursday
            ? const [ClassItem(ClassId.conditioning, training)]
            : tuesday
                ? const [
                    ClassItem(ClassId.wingChun, martial),
                    ClassItem(ClassId.jumpAndRoll, training),
                  ]
                : const [
                    ClassItem(ClassId.shaolin, martial),
                    ClassItem(ClassId.wingChun, martial),
                  ],
      );

      add(_m(12), _m(12, 30), const [ClassItem(ClassId.lunch, ClassKind.meal)]);

      // 15:00 - 16:30
      add(
        _m(15),
        _m(16, 30),
        thursday
            ? const [ClassItem(ClassId.mountainClimbing, training)]
            : const [
                ClassItem(ClassId.sanda, martial),
                ClassItem(ClassId.shaolin, martial),
                ClassItem(ClassId.wingChun, martial),
              ],
      );

      add(_m(16, 50), _m(17, 50), const [ClassItem(ClassId.taiChiOptional, ClassKind.optional)]);
      add(_m(18), _m(18, 30), const [ClassItem(ClassId.dinner, ClassKind.meal)]);

      // 19:00 - 20:00
      if (d <= 2) {
        add(_m(19), _m(20), const [ClassItem(ClassId.mandarin, ClassKind.culture)]);
      }
      if (thursday) {
        add(_m(19), _m(20), const [ClassItem(ClassId.calligraphyTcm, ClassKind.culture)]);
      }
    }
    return out;
  }
}
