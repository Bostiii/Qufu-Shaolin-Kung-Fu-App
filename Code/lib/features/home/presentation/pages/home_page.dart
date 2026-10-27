import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qufu_shaolin_app/core/common/widgets/notification_bell_button.dart';
import 'package:qufu_shaolin_app/core/config/router/app_router.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        // Long title: shrink it a little so bell + settings fit next to it.
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(l10n.appTitle),
        ),
        actions: [
          const NotificationBellButton(),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: l10n.settingsTitle,
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.waving_hand),
            title: Text(l10n.onboardingTitle),
            onTap: () => context.push(AppRoutes.onboarding),
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: Text(l10n.newStudentTitle),
            onTap: () => context.push(AppRoutes.newStudent),
          ),
        ],
      ),
    );
  }
}
