import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

/// Wraps every page (except the splash) and gives it the bottom navigation bar.
///
/// [location] is the current path, [tabPaths] are the 5 tab paths in bar order.
/// On pages that are not a tab (welcome, onboarding, settings, ...) the bar is
/// still shown, but no tab is highlighted.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.location,
    required this.tabPaths,
  });

  final Widget child;
  final String location;
  final List<String> tabPaths;

  int? get _selected {
    for (var i = 0; i < tabPaths.length; i++) {
      final p = tabPaths[i];
      if (location == p || location.startsWith('$p/')) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final selected = _selected;
    final cs = Theme.of(context).colorScheme;

    // (outlined icon, filled icon, label)
    final items = <(IconData, IconData, String)>[
      (Icons.home_outlined, Icons.home, l10n.navHome),
      (Icons.calendar_month_outlined, Icons.calendar_month, l10n.navSchedule),
      (Icons.newspaper_outlined, Icons.newspaper, l10n.navNews),
      (Icons.sports_martial_arts_outlined, Icons.sports_martial_arts, l10n.navStyles),
      (Icons.school_outlined, Icons.school, l10n.navInfo),
    ];

    Widget bar = NavigationBar(
      selectedIndex: selected ?? 0,
      onDestinationSelected: (index) {
        HapticFeedback.selectionClick();
        context.go(tabPaths[index]);
      },
      destinations: [
        for (final (outlined, filled, label) in items)
          NavigationDestination(
            icon: Icon(outlined),
            // No tab selected (e.g. on the welcome page): keep the outlined icon.
            selectedIcon: Icon(selected == null ? outlined : filled),
            label: label,
          ),
      ],
    );

    if (selected == null) {
      // Make the bar look "nothing selected": no pill, unselected colours.
      bar = NavigationBarTheme(
        data: NavigationBarTheme.of(context).copyWith(
          indicatorColor: Colors.transparent,
          iconTheme: WidgetStatePropertyAll(IconThemeData(color: cs.onSurfaceVariant)),
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: cs.onSurfaceVariant),
          ),
        ),
        child: bar,
      );
    }

    return Scaffold(body: child, bottomNavigationBar: bar);
  }
}
