import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qufu_shaolin_app/features/schedule/data/datasources/schedule_local_data.dart';
import 'package:qufu_shaolin_app/features/schedule/domain/entities/schedule_slot.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/class_label.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/widgets/schedule_colors.dart';
import 'package:qufu_shaolin_app/l10n/app_localizations.dart';

String formatMinutes(int minutes) =>
    '${(minutes ~/ 60).toString().padLeft(2, '0')}:${(minutes % 60).toString().padLeft(2, '0')}';

/// Weekly timetable grid, Monday to Sunday, with a red line for the current time.
/// The time column on the left stays fixed, the days scroll sideways.
class ScheduleGrid extends StatefulWidget {
  const ScheduleGrid({super.key, required this.slots, required this.now});

  final List<ScheduleSlot> slots;

  /// School time (see schoolNow()).
  final DateTime now;

  @override
  State<ScheduleGrid> createState() => _ScheduleGridState();
}

class _ScheduleGridState extends State<ScheduleGrid> {
  static const double _axisW = 44;
  static const double _dayW = 112;
  static const double _hourH = 72;
  static const double _pad = 10;
  static const double _headerH = 40;
  static const double _footerH = 34;
  static const int _start = ScheduleLocalData.startMinute;
  static const int _end = ScheduleLocalData.endMinute;

  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    // Start with today's column in view.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final today = widget.now.weekday - 1;
      _scroll.jumpTo(
        (today * _dayW - 8).clamp(0.0, _scroll.position.maxScrollExtent).toDouble(),
      );
    });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  double _y(int minute) => _pad + (minute - _start) / 60 * _hourH;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();

    final line = cs.outline.withValues(alpha: 0.45);
    final muted = cs.onSurfaceVariant;
    final red = ScheduleColors.nowLine(brightness);

    final dayNames = [
      for (var i = 0; i < 7; i++) DateFormat.E(locale).format(DateTime(2026, 1, 5 + i)),
    ];
    final today = widget.now.weekday - 1;
    final minute = widget.now.hour * 60 + widget.now.minute;
    final inRange = minute >= _start && minute <= _end;
    final bodyH = _pad * 2 + (_end - _start) / 60 * _hourH;
    final border = BorderSide(color: line, width: 0.5);

    // ── fixed time column ────────────────────────────────────────────
    final axis = SizedBox(
      width: _axisW,
      child: Column(
        children: [
          const SizedBox(height: _headerH),
          Container(
            height: bodyH,
            decoration: BoxDecoration(border: Border(top: border)),
            child: Stack(
              children: [
                for (var h = _start ~/ 60; h <= _end ~/ 60; h++)
                  Positioned(
                    top: _y(h * 60) - 7,
                    left: 6,
                    child: Text(
                      formatMinutes(h * 60),
                      style: TextStyle(fontSize: 11, color: muted),
                    ),
                  ),
                if (inRange)
                  Positioned(
                    top: _y(minute) - 9,
                    left: 2,
                    right: 2,
                    child: Container(
                      height: 18,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        formatMinutes(minute),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            height: _footerH,
            padding: const EdgeInsets.only(left: 6),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(border: Border(top: border)),
            child: Text(l10n.scheduleGate, style: TextStyle(fontSize: 11, color: muted)),
          ),
        ],
      ),
    );

    // ── scrolling days ───────────────────────────────────────────────
    final days = SizedBox(
      width: 7 * _dayW,
      child: Column(
        children: [
          // header
          Row(
            children: [
              for (var d = 0; d < 7; d++)
                Container(
                  width: _dayW,
                  height: _headerH,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border(left: border)),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: d == today ? cs.primary.withValues(alpha: 0.16) : null,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      dayNames[d],
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: d == today ? cs.primary : cs.onSurface,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          // body
          Container(
            height: bodyH,
            decoration: BoxDecoration(border: Border(top: border)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                for (var h = _start ~/ 60; h <= _end ~/ 60; h++)
                  Positioned(
                    top: _y(h * 60),
                    left: 0,
                    right: 0,
                    child: SizedBox(height: 0.5, child: ColoredBox(color: line)),
                  ),
                for (var d = 0; d < 7; d++)
                  Positioned(
                    left: d * _dayW,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(width: 0.5, child: ColoredBox(color: line)),
                  ),
                for (var d = 5; d < 7; d++)
                  Positioned(
                    left: d * _dayW,
                    width: _dayW,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Text(
                          l10n.scheduleFreeTime,
                          style: TextStyle(fontSize: 14, letterSpacing: 2, color: muted),
                        ),
                      ),
                    ),
                  ),
                for (final slot in widget.slots)
                  Positioned(
                    left: slot.day * _dayW + 3,
                    width: _dayW - 6,
                    top: _y(slot.start) + 1,
                    height: (slot.end - slot.start) / 60 * _hourH - 2,
                    child: Column(
                      spacing: 1,
                      children: [
                        for (final item in slot.items)
                          Expanded(child: _ClassChip(item: item, brightness: brightness)),
                      ],
                    ),
                  ),
                if (inRange) ...[
                  Positioned(
                    top: _y(minute) - 1,
                    left: 0,
                    right: 0,
                    child: SizedBox(height: 2, child: ColoredBox(color: red)),
                  ),
                  Positioned(
                    top: _y(minute) - 4,
                    left: today * _dayW - 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(color: red, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ],
            ),
          ),
          // footer: gate closing time
          Row(
            children: [
              for (var d = 0; d < 7; d++)
                Container(
                  width: _dayW,
                  height: _footerH,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: Border(left: border, top: border)),
                  child: Text(
                    ScheduleLocalData.gateClose[d],
                    style: TextStyle(fontSize: 12, color: muted),
                  ),
                ),
            ],
          ),
        ],
      ),
    );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: line),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          axis,
          Expanded(
            child: SingleChildScrollView(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              child: days,
            ),
          ),
        ],
      ),
    );
  }
}

class _ClassChip extends StatelessWidget {
  const _ClassChip({required this.item, required this.brightness});

  final ClassItem item;
  final Brightness brightness;

  @override
  Widget build(BuildContext context) {
    final style = ScheduleColors.of(item.kind, brightness);
    final label = item.id.label(AppLocalizations.of(context)!);

    return CustomPaint(
      foregroundPainter:
          item.kind == ClassKind.optional ? _DashedBorderPainter(style.fg) : null,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: style.bg,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          label,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11.5, height: 1.15, color: style.fg),
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(5)));
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color.withValues(alpha: 0.7);
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(metric.extractPath(d, d + 3), paint);
        d += 6;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter old) => old.color != color;
}
