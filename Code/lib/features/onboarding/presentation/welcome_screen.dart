import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:qufu_shaolin_app/core/extensions/l10n_extension.dart';
import 'package:qufu_shaolin_app/core/config/theme/brand_palette.dart';
import 'package:qufu_shaolin_app/core/widgets/aurora_background.dart';
import 'package:qufu_shaolin_app/features/splash/presentation/splash_screen.dart';

/// Welcome screen shown right after the splash.
///
/// The logo starts exactly where the splash left it (screen centre, same size)
/// and glides up into the hero area while a bottom sheet slides in and its
/// content fades in one piece after the other.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
    required this.onLogin,
  });

  final VoidCallback onGetStarted;
  final VoidCallback onLogin;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // Decorative, deliberately bilingual (not translated).
  static const _styles = <(String, String)>[
    ('太极', 'Tai Chi'),
    ('少林', 'Shaolin'),
    ('咏春', 'Wing Chun'),
    ('散打', 'Sanda'),
  ];

  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1700),
  );

  late final Animation<double> _move = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.08, 0.55, curve: Curves.easeInOutCubic),
  );
  late final Animation<double> _sheet = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.10, 0.60, curve: Curves.easeOutCubic),
  );
  late final Animation<double> _watermark = CurvedAnimation(
    parent: _c,
    curve: const Interval(0.30, 0.85, curve: Curves.easeOut),
  );
  late final List<Animation<double>> _stagger = List.generate(5, (i) {
    final start = 0.40 + i * 0.08;
    return CurvedAnimation(
      parent: _c,
      curve: Interval(start, math.min(1.0, start + 0.35), curve: Curves.easeOutCubic),
    );
  });

  @override
  void initState() {
    super.initState();
    _c.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) _c.value = 1;
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  Widget _in(int i, Widget child) {
    final a = _stagger[i];
    return FadeTransition(
      opacity: a,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero).animate(a),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = BrandPalette.of(context);
    final l10n = context.l10n;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: p.sheet,
        systemNavigationBarIconBrightness: p.isDark ? Brightness.light : Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: p.hero,
        body: AuroraBackground(
          palette: p,
          child: Column(
            children: [
              // ── Hero ────────────────────────────────────────────────
              Expanded(child: _Hero(palette: p, move: _move, watermark: _watermark)),

              // ── Bottom sheet ────────────────────────────────────────
              SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                    .animate(_sheet),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(
                    24,
                    30,
                    24,
                    20 + MediaQuery.paddingOf(context).bottom,
                  ),
                  decoration: BoxDecoration(
                    color: p.sheet,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
                    border: p.isDark ? Border(top: BorderSide(color: p.outline)) : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: p.isDark ? 0.45 : 0.14),
                        blurRadius: 36,
                        offset: const Offset(0, -10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _in(
                        0,
                        Text(
                          l10n.welcomeTitle,
                          style: TextStyle(
                            fontSize: 36,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.8,
                            color: p.text,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _in(
                        1,
                        Text(
                          l10n.welcomeSubtitle,
                          style: TextStyle(fontSize: 16, height: 1.45, color: p.muted),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _in(
                        2,
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final (zh, en) in _styles) _StyleChip(zh: zh, en: en, palette: p),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      _in(
                        3,
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              widget.onGetStarted();
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: p.primary,
                              foregroundColor: p.onPrimary,
                              minimumSize: const Size.fromHeight(58),
                              shape: const StadiumBorder(),
                              textStyle: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(l10n.welcomeGetStarted),
                                const SizedBox(width: 8),
                                const Icon(Icons.arrow_forward_rounded, size: 22),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      _in(
                        4,
                        SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: widget.onLogin,
                            style: TextButton.styleFrom(
                              foregroundColor: p.muted,
                              minimumSize: const Size.fromHeight(48),
                              textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            child: Text(l10n.welcomeLogin),
                          ),
                        ),
                      ),
                    ],
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

class _Hero extends StatelessWidget {
  const _Hero({required this.palette, required this.move, required this.watermark});

  final BrandPalette palette;
  final Animation<double> move;
  final Animation<double> watermark;

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.sizeOf(context);
    final top = MediaQuery.paddingOf(context).top;
    final startW = SplashScreen.logoWidth(screen);

    return LayoutBuilder(
      builder: (context, box) {
        final areaH = math.max(0.0, box.maxHeight - top);
        // Final logo width: limited by hero width and height.
        final finalW = math.min(
          startW,
          math.min(box.maxWidth * 0.58, areaH * 0.78 * BrandPalette.logoAspect),
        );
        // Splash centres the logo on the screen; the hero centres it in its area.
        final dy = screen.height / 2 - (top + areaH / 2);

        return Stack(
          children: [
            // Faint "武" (martial) watermark behind the logo
            Positioned(
              left: 0,
              right: 0,
              top: top,
              bottom: 0,
              child: FadeTransition(
                opacity: watermark,
                child: Center(
                  child: Text(
                    '武',
                    style: TextStyle(
                      fontSize: math.min(box.maxWidth * 0.95, areaH * 1.15),
                      height: 1,
                      fontWeight: FontWeight.w900,
                      color: palette.watermark,
                    ),
                  ),
                ),
              ),
            ),

            // Logo: glides from the splash position into the hero
            Positioned(
              left: 0,
              right: 0,
              top: top,
              bottom: 0,
              child: Center(
                child: AnimatedBuilder(
                  animation: move,
                  builder: (context, child) {
                    final m = move.value;
                    return Transform.translate(
                      offset: Offset(0, dy * (1 - m)),
                      child: Transform.scale(
                        scale: _lerp(startW / finalW, 1, m),
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(palette.logoAsset, width: finalW, fit: BoxFit.contain),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

double _lerp(double a, double b, double t) => a + (b - a) * t;

class _StyleChip extends StatelessWidget {
  const _StyleChip({required this.zh, required this.en, required this.palette});

  final String zh;
  final String en;
  final BrandPalette palette;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(
        color: palette.card,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: palette.outline),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            zh,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: palette.accent,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            en,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: palette.text,
            ),
          ),
        ],
      ),
    );
  }
}
