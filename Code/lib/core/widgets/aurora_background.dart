import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:qufu_shaolin_app/core/config/theme/brand_palette.dart';

/// Soft, slowly drifting "aurora" glow on top of the base hero colour.
///
/// At [intensity] == 0 only the flat base colour is drawn, which is exactly the
/// colour of the native splash screen, so the hand-over is seamless.
class AuroraBackground extends StatefulWidget {
  const AuroraBackground({
    super.key,
    required this.palette,
    this.intensity = const AlwaysStoppedAnimation<double>(1),
    this.child,
  });

  final BrandPalette palette;
  final Animation<double> intensity;
  final Widget? child;

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drift = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 18),
  )..repeat();

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: _AuroraPainter(widget.palette, _drift, widget.intensity),
        child: widget.child ?? const SizedBox.expand(),
      ),
    );
  }
}

class _AuroraPainter extends CustomPainter {
  _AuroraPainter(this.palette, this.drift, this.intensity)
      : super(repaint: Listenable.merge([drift, intensity]));

  final BrandPalette palette;
  final Animation<double> drift;
  final Animation<double> intensity;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = palette.hero);

    final t = drift.value * 2 * math.pi;
    final k = intensity.value.clamp(0.0, 1.0);
    if (k <= 0) return;

    void blob(Offset center, double radius, Color color, double alpha) {
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [
            color.withValues(alpha: alpha * k),
            color.withValues(alpha: 0),
          ],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      canvas.drawCircle(center, radius, paint);
    }

    final w = size.width;
    final h = size.height;

    blob(
      Offset(w * (0.22 + 0.08 * math.sin(t)), h * (0.26 + 0.05 * math.cos(t))),
      w * 0.95,
      palette.glowA,
      palette.isDark ? 0.45 : 0.55,
    );
    blob(
      Offset(w * (0.86 - 0.08 * math.cos(t)), h * (0.78 + 0.05 * math.sin(t))),
      w * 1.05,
      palette.glowB,
      0.65,
    );
    blob(
      Offset(w * 0.5, h * 0.42),
      w * 0.7 * (1 + 0.04 * math.sin(t * 2)),
      palette.glowA,
      palette.isDark ? 0.22 : 0.28,
    );
  }

  @override
  bool shouldRepaint(covariant _AuroraPainter old) => old.palette != palette;
}
