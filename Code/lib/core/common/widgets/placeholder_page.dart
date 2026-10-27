import 'package:flutter/material.dart';
import 'package:qufu_shaolin_app/core/common/widgets/notification_bell_button.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

/// Temporary page used by every feature until its real UI is built.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.title, this.showBell = true});

  final String title;

  /// Notification bell in the app bar (on every page except splash, welcome, settings).
  final bool showBell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [if (showBell) const NotificationBellButton()],
      ),
      body: Center(child: Text(l10n.comingSoon)),
    );
  }
}
