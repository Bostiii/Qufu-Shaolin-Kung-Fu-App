import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

extension ClassIdLabel on ClassId {
  String label(AppLocalizations l10n) => switch (this) {
        ClassId.taiChiOptional => l10n.classTaiChiOptional,
        ClassId.breakfast => l10n.classBreakfast,
        ClassId.shaolin => l10n.classShaolin,
        ClassId.wingChun => l10n.classWingChun,
        ClassId.qigong => l10n.classQigong,
        ClassId.takedownsChinNa => l10n.classTakedownsChinNa,
        ClassId.jumpAndRoll => l10n.classJumpAndRoll,
        ClassId.conditioning => l10n.classConditioning,
        ClassId.lunch => l10n.classLunch,
        ClassId.sanda => l10n.classSanda,
        ClassId.mountainClimbing => l10n.classMountainClimbing,
        ClassId.dinner => l10n.classDinner,
        ClassId.mandarin => l10n.classMandarin,
        ClassId.calligraphyTcm => l10n.classCalligraphyTcm,
      };
}
