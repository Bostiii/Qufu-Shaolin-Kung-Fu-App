/// Colour group of a class in the schedule grid.
enum ClassKind { martial, optional, training, culture, meal }

/// Every class / activity on the timetable. The visible name comes from l10n.
enum ClassId {
  taiChiOptional,
  breakfast,
  shaolin,
  wingChun,
  qigong,
  takedownsChinNa,
  jumpAndRoll,
  conditioning,
  lunch,
  sanda,
  mountainClimbing,
  dinner,
  mandarin,
  calligraphyTcm,
}

class ClassItem {
  const ClassItem(this.id, this.kind);

  final ClassId id;
  final ClassKind kind;
}

/// One time block on one day. Several [items] = students choose one of them.
class ScheduleSlot {
  const ScheduleSlot({
    required this.day,
    required this.start,
    required this.end,
    required this.items,
  });

  /// 0 = Monday ... 6 = Sunday.
  final int day;

  /// Minutes after midnight.
  final int start;
  final int end;
  final List<ClassItem> items;

  bool contains(int minute) => minute >= start && minute < end;
}
