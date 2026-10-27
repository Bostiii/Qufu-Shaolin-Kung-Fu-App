import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qufu_shaolin_app/core/config/theme/theme_provider.dart';

class ThemeSlider extends ConsumerWidget {
  const ThemeSlider({super.key});

  static const double _width = 76;
  static const double _height = 38;
  static const double _knob = 30;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = theme.iconTheme.color ?? theme.colorScheme.onSurface;
    final notifier = ref.read(themeModeProvider.notifier);

    return GestureDetector(
      onTap: () => notifier.setDark(!isDark),
      onHorizontalDragEnd: (d) {
        final v = d.primaryVelocity ?? 0;
        if (v > 0) notifier.setDark(true);   // swipe right -> moon
        if (v < 0) notifier.setDark(false);  // swipe left  -> sun
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: _width,
        height: _height,
        padding: const EdgeInsets.all((_height - _knob) / 2),
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(_height / 2),
          border: Border.all(color: iconColor.withOpacity(0.25)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Icons at both ends of the track
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: Icon(Icons.light_mode_outlined,
                      size: 18, color: iconColor.withOpacity(isDark ? 0.8 : 0)),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Icon(Icons.dark_mode_outlined,
                      size: 18, color: iconColor.withOpacity(isDark ? 0 : 0.8)),
                ),
              ],
            ),
            // Sliding knob with the active icon
            AnimatedAlign(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: _knob,
                height: _knob,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    key: ValueKey(isDark),
                    size: 18,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}