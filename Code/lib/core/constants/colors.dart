import 'package:flutter/material.dart';

/// App color palette (based on the school logo red #DC1E1E).
///
/// NOTE: the palette is a proposal, the final choice is not confirmed yet.
/// Keep all colors here so changing the design (Phase 6) is a one-file job.
class AppColors {
  AppColors._();

  // ---------------------------------------------------------------------------
  // Light mode
  // ---------------------------------------------------------------------------
  static const Color lightPrimary = Color(0xFFDC1E1E);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFFAF7F2);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFF3EEE6);
  static const Color lightOutline = Color(0xFFE2DAD0);
  static const Color lightText = Color(0xFF1C1917);
  static const Color lightTextMuted = Color(0xFF5F5750);
  static const Color lightGold = Color(0xFF9A6B12);

  // ---------------------------------------------------------------------------
  // Dark mode
  // ---------------------------------------------------------------------------
  static const Color darkPrimary = Color(0xFFE8453C);
  static const Color darkOnPrimary = Color(0xFF121110);
  static const Color darkBackground = Color(0xFF121110);
  static const Color darkSurface = Color(0xFF1C1A19);
  static const Color darkCard = Color(0xFF262322);
  static const Color darkOutline = Color(0xFF3A3532);
  static const Color darkText = Color(0xFFF2EDE8);
  static const Color darkTextMuted = Color(0xFFB3A9A0);
  static const Color darkGold = Color(0xFFD9A94A);

  // ---------------------------------------------------------------------------
  // Brand (same in both modes)
  // ---------------------------------------------------------------------------
  static const Color brandRed = Color(0xFFDC1E1E);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // ---------------------------------------------------------------------------
  // Status colors
  // ---------------------------------------------------------------------------
  static const Color success = Color(0xFF2E7D4F);
  static const Color warning = Color(0xFFE0A100);
  static const Color error = Color(0xFFB3261E);
  static const Color info = Color(0xFF2B6CB0);
}
