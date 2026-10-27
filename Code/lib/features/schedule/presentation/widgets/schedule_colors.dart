import 'package:flutter/material.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';

class KindStyle {
  const KindStyle(this.bg, this.fg);

  final Color bg;
  final Color fg;
}

/// Colours of the schedule blocks, for light and dark mode.
class ScheduleColors {
  ScheduleColors._();

  static KindStyle of(ClassKind kind, Brightness brightness) {
    final dark = brightness == Brightness.dark;
    switch (kind) {
      case ClassKind.martial:
      case ClassKind.optional:
        return dark
            ? const KindStyle(Color(0xFF4A1E1C), Color(0xFFFFB4AB))
            : const KindStyle(Color(0xFFFBE3E1), Color(0xFF8E1B16));
      case ClassKind.training:
        return dark
            ? const KindStyle(Color(0xFF14392F), Color(0xFF8FE0C8))
            : const KindStyle(Color(0xFFDDF1EC), Color(0xFF0F5C4D));
      case ClassKind.culture:
        return dark
            ? const KindStyle(Color(0xFF2C2757), Color(0xFFC8C2FF))
            : const KindStyle(Color(0xFFE9E5FA), Color(0xFF3F3590));
      case ClassKind.meal:
        return dark
            ? const KindStyle(Color(0xFF4A2E10), Color(0xFFFFC98A))
            : const KindStyle(Color(0xFFFDE8D0), Color(0xFF8A4A0B));
    }
  }

  /// The red "now" line.
  static Color nowLine(Brightness brightness) =>
      brightness == Brightness.dark ? const Color(0xFFFF5A4F) : const Color(0xFFE5231F);
}
