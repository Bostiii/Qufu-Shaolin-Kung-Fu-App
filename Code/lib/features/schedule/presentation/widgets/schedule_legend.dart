import 'package:flutter/material.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_colors.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

class ScheduleLegend extends StatelessWidget {
  const ScheduleLegend({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final muted = theme.colorScheme.onSurfaceVariant;

    final entries = <(ClassKind, String)>[
      (ClassKind.martial, l10n.scheduleLegendMartial),
      (ClassKind.optional, l10n.scheduleLegendOptional),
      (ClassKind.training, l10n.scheduleLegendTraining),
      (ClassKind.culture, l10n.scheduleLegendCulture),
      (ClassKind.meal, l10n.scheduleLegendMeals),
    ];

    return Wrap(
      spacing: 14,
      runSpacing: 8,
      children: [
        for (final (kind, label) in entries)
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: ScheduleColors.of(kind, theme.brightness).bg,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: ScheduleColors.of(kind, theme.brightness).fg.withValues(alpha: 0.6),
                    width: kind == ClassKind.optional ? 1 : 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Text(label, style: theme.textTheme.bodySmall?.copyWith(color: muted)),
            ],
          ),
        Text(l10n.scheduleLegendFree, style: theme.textTheme.bodySmall?.copyWith(color: muted)),
      ],
    );
  }
}
