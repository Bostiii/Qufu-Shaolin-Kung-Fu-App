import 'package:flutter/material.dart';

/// Basic theme for Phase 1. Final colors, fonts and icons come in Phase 6.
class AppTheme {
  static const _seed = Color(0xFF8B1A1A); // deep red

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: _seed),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: Brightness.dark,
        ),
      );
}
