import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:qufu_shaolin_app/core/config/theme/brand_palette.dart';
import 'package:qufu_shaolin_app/core/widgets/aurora_background.dart';

/// Animated splash screen (light + dark).
///
/// Light: white logo on the primary red. Dark: red logo on a dark background.
/// Timeline (~2.8 s): aurora fades in -> logo blooms out of the centre
/// (blur-to-sharp + soft radial reveal) with an expanding ring -> a gold light
/// sweep glides over the logo -> thin loading line -> [onFinished].
///
/// [ready] lets you wait for real start-up work (e.g. load saved language,
/// check if onboarding is done). The splash only ends when the animation AND
/// [ready] are both done.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.onFinished, this.ready});

  final VoidCallback onFinished;
  final Future<void>? ready;

  /// Max logo width. The welcome screen uses the same maths so the logo
  /// glides from here to its place without a jump.
  static double logoWidth(Size screen) => math.min(screen.width * 0.62, 320.0);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  );

  late final Animation<double> _bg =
      CurvedAnimation(parent: _c, curve: const Interval(0.0, 0.35, curve: Curves.easeOut));
  late final Animation<double> _fade =
      CurvedAnimation(parent: _c, curve: const Interval(0.08, 0.35, curve: Curves.easeOut));
  late final Animation<double> _reveal =
      CurvedAnimation(parent: _c, curve: const Interval(0.08, 0.62, curve: Curves.easeOutCubic));
  late final Animation<double> _ring =
      CurvedAnimation(parent: _c, curve: const Interval(0.12, 0.80, curve: Curves.easeOutCubic));
  late final Animation<double> _glint =
      CurvedAnimation(parent: _c, curve: const Interval(0.62, 0.92, curve: Curves.easeInOut));
  late final Animation<double> _line =
      CurvedAnimation(parent: _c, curve: const Interval(0.35, 1.0, curve: Curves.easeInOutCubic));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _run());
  }

  Future<void> _run() async {
    if (!mounted) return;
    final palette = BrandPalette.of(context);

    // Make sure the logo is decoded before the animation starts (no pop-in).
    await precacheImage(AssetImage(palette.logoAsset), context);
    if (!mounted) return;

    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final Future<void> anim;
    if (reduceMotion) {
      _c.value = 1;
      anim = Future<void>.delayed(const Duration(milliseconds: 500));
    } else {
      anim = _c.forward();
    }

    await Future.wait<void>([anim, widget.ready ?? Future<void>.value()]);
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (!mounted) return;
    widget.onFinished();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = BrandPalette.of(context);
    final size = MediaQuery.sizeOf(context);
    final logoW = SplashScreen.logoWidth(size);
    final bottom = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: p.hero,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: p.hero,
        body: AuroraBackground(
          palette: p,
          intensity: _bg,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Expanding rings behind the logo
              Positioned.fill(
                child: CustomPaint(
                  painter: _RingsPainter(progress: _ring, color: p.ring, baseRadius: logoW * 0.28),
                ),
              ),

              // Logo
              Center(
                child: AnimatedBuilder(
                  animation: _c,
                  builder: (context, _) => _AnimatedLogo(
                    asset: p.logoAsset,
                    width: logoW,
                    reveal: _reveal.value,
                    opacity: _fade.value,
                    glint: _glint.value,
                    glintColor: p.glint,
                  ),
                ),
              ),

              // Loading line
              Positioned(
                left: 0,
                right: 0,
                bottom: bottom + 48,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _line,
                    builder: (context, _) => _LoadingLine(progress: _line.value, color: p.ring),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Logo with: radial ink-bloom reveal, blur-to-sharp, scale + rise, and a glint sweep.
class _AnimatedLogo extends StatelessWidget {
  const _AnimatedLogo({
    required this.asset,
    required this.width,
    required this.reveal,
    required this.opacity,
    required this.glint,
    required this.glintColor,
  });

  final String asset;
  final double width;
  final double reveal;
  final double opacity;
  final double glint;
  final Color glintColor;

  @override
  Widget build(BuildContext context) {
    Widget logo = Image.asset(asset, width: width, fit: BoxFit.contain);

    // 1) Radial reveal mask (soft edge grows from the centre)
    logo = ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) => RadialGradient(
        radius: 0.05 + reveal * 1.2,
        colors: const [Colors.white, Colors.white, Colors.transparent],
        stops: const [0.0, 0.65, 1.0],
      ).createShader(rect),
      child: logo,
    );

    // 2) Glint: a soft band of warm light that sweeps across the logo
    if (glint > 0 && glint < 1) {
      final x = -0.25 + glint * 1.5; // band centre moves from left to right
      double s(double v) => v.clamp(0.0, 1.0);
      logo = ShaderMask(
        blendMode: BlendMode.srcATop,
        shaderCallback: (rect) => LinearGradient(
          begin: const Alignment(-1, -0.4),
          end: const Alignment(1, 0.4),
          colors: [
            glintColor.withValues(alpha: 0),
            glintColor.withValues(alpha: 0.9),
            glintColor.withValues(alpha: 0),
          ],
          stops: [s(x - 0.18), s(x), s(x + 0.18)],
        ).createShader(rect),
        child: logo,
      );
    }

    // 3) Blur-to-sharp
    final sigma = (1 - reveal) * 14;
    if (sigma > 0.05) {
      logo = ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma, tileMode: TileMode.decal),
        child: logo,
      );
    }

    // 4) Scale, rise and fade
    return Opacity(
      opacity: opacity.clamp(0.0, 1.0),
      child: Transform.translate(
        offset: Offset(0, 14 * (1 - reveal)),
        child: Transform.scale(scale: 0.9 + 0.1 * reveal, child: logo),
      ),
    );
  }
}

class _RingsPainter extends CustomPainter {
  _RingsPainter({required this.progress, required this.color, required this.baseRadius})
      : super(repaint: progress);

  final Animation<double> progress;
  final Color color;
  final double baseRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress.value;
    if (t <= 0 || t >= 1) return;
    final center = size.center(Offset.zero);

    for (var i = 0; i < 2; i++) {
      final local = ((t - i * 0.15) / (1 - i * 0.15)).clamp(0.0, 1.0);
      if (local <= 0) continue;
      final radius = baseRadius + local * baseRadius * 3.6;
      final alpha = (1 - local) * (i == 0 ? 0.30 : 0.16);
      canvas.drawCircle(
        center,
        radius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..color = color.withValues(alpha: alpha),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _RingsPainter old) =>
      old.color != color || old.baseRadius != baseRadius;
}

class _LoadingLine extends StatelessWidget {
  const _LoadingLine({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    const width = 72.0;
    return Opacity(
      opacity: progress <= 0 ? 0 : 1,
      child: Container(
        width: width,
        height: 3,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.22),
          borderRadius: BorderRadius.circular(2),
        ),
        alignment: Alignment.centerLeft,
        child: Container(
          width: width * progress,
          height: 3,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.9),
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }
}
