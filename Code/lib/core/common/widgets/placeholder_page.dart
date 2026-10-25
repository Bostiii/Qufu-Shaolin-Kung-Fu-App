import 'package:flutter/material.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

/// Temporary page used by every feature until its real UI is built.
class PlaceholderPage extends StatelessWidget {
  const PlaceholderPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(l10n.comingSoon)),
    );
  }
}
