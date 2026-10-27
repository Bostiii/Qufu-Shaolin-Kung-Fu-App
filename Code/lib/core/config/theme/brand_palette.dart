import 'package:flutter/material.dart';

/// Brand colours + logo asset used by the splash and welcome screens.
///
/// Values follow the proposed palette (logo red #DC1E1E). If you change the
/// palette in colors.dart / app_theme.dart, update the values here as well.
class BrandPalette {
  const BrandPalette({
    required this.hero,
    required this.glowA,
    required this.glowB,
    required this.glint,
    required this.ring,
    required this.watermark,
    required this.logoAsset,
    required this.sheet,
    required this.card,
    required this.outline,
    required this.text,
    required this.muted,
    required this.accent,
    required this.primary,
    required this.onPrimary,
    required this.isDark,
  });

  /// Base fill of the hero / splash background. Must match the native splash colour.
  final Color hero;
  final Color glowA;
  final Color glowB;

  /// Colour of the light sweep that glides over the logo.
  final Color glint;

  /// Colour of the expanding rings and the loading line.
  final Color ring;

  /// Colour of the big faint "武" behind the logo on the welcome screen.
  final Color watermark;

  final String logoAsset;

  // Bottom sheet (welcome screen)
  final Color sheet;
  final Color card;
  final Color outline;
  final Color text;
  final Color muted;
  final Color accent;
  final Color primary;
  final Color onPrimary;
  final bool isDark;

  /// Width / height of the full logo PNG (200 x 165).
  static const double logoAspect = 200 / 165;

  static const light = BrandPalette(
    hero: Color(0xFFDC1E1E),
    glowA: Color(0xFFFF6A58),
    glowB: Color(0xFF8E0D10),
    glint: Color(0xFFFFD98A),
    ring: Color(0xFFFFFFFF),
    watermark: Color(0x14FFFFFF),
    logoAsset: 'assets/images/logo/logo_cn_white.png',
    sheet: Color(0xFFFAF7F2),
    card: Color(0xFFF3EEE6),
    outline: Color(0xFFE2DAD0),
    text: Color(0xFF1C1917),
    muted: Color(0xFF5F5750),
    accent: Color(0xFF9A6B12),
    primary: Color(0xFFDC1E1E),
    onPrimary: Color(0xFFFFFFFF),
    isDark: false,
  );

  static const dark = BrandPalette(
    hero: Color(0xFF121110),
    glowA: Color(0xFFE8453C),
    glowB: Color(0xFF6E1210),
    glint: Color(0xFFFFD08A),
    ring: Color(0xFFE8453C),
    watermark: Color(0x14E8453C),
    logoAsset: 'assets/images/logo/logo_cn_red.png',
    sheet: Color(0xFF1C1A19),
    card: Color(0xFF262322),
    outline: Color(0xFF3A3532),
    text: Color(0xFFF2EDE8),
    muted: Color(0xFFB3A9A0),
    accent: Color(0xFFD9A94A),
    primary: Color(0xFFE8453C),
    onPrimary: Color(0xFF121110),
    isDark: true,
  );

  static BrandPalette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}
