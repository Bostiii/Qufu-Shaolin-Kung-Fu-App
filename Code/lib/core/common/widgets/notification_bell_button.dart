import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qufu_shaolin_app/core/config/router/app_router.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

/// Notification bell for the top app bar (right corner).
/// Put it in `AppBar(actions: [...])`. Not used on splash, welcome and settings.
class NotificationBellButton extends StatelessWidget {
  const NotificationBellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.notifications_outlined),
      tooltip: AppLocalizations.of(context)!.notificationsTitle,
      onPressed: () => context.push(AppRoutes.notifications),
    );
  }
}
