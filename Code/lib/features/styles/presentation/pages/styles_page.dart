import 'package:flutter/material.dart';
import 'package:qufu_shaolin_app/core/common/widgets/placeholder_page.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class StylesPage extends StatelessWidget {
  const StylesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlaceholderPage(title: AppLocalizations.of(context)!.navStyles);
  }
}
