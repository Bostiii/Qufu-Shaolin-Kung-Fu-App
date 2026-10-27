import 'package:flutter/widgets.dart';

// ⚠️ Adjust THIS ONE import to where gen-l10n puts AppLocalizations in your project.
//   - Output in lib/l10n (non-synthetic):  package:qufu_shaolin_app/l10n/app_localizations.dart
//   - Older synthetic package:             package:flutter_gen/gen_l10n/app_localizations.dart
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
