/// Spacing, radius, icon, button and layout sizes.
class AppSizes {
  AppSizes._();

  // Spacing (4-point grid)
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  // Screen padding
  static const double screenPadding = 20;
  static const double sectionSpacing = 32;
  static const double itemSpacing = 12;

  // Border radius
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 20;
  static const double radiusXl = 28;
  static const double radiusFull = 999;

  // Icons
  static const double iconSm = 16;
  static const double iconMd = 24;
  static const double iconLg = 32;
  static const double iconXl = 48;

  // Buttons and inputs
  static const double buttonHeight = 52;
  static const double buttonHeightSmall = 40;
  static const double inputHeight = 56;
  static const double minTapTarget = 48;

  // Cards and images
  static const double cardElevation = 0;
  static const double cardPadding = 16;
  static const double avatarSm = 40;
  static const double avatarMd = 64;
  static const double avatarLg = 96;
  static const double styleCardHeight = 180;
  static const double bannerHeight = 200;

  // Logo
  static const double logoSm = 48;
  static const double logoMd = 96;
  static const double logoLg = 160;

  // Navigation
  static const double bottomNavHeight = 64;
  static const double appBarHeight = 56;

  // Layout
  static const double maxContentWidth = 600;
  static const double dividerThickness = 1;

  // Animation durations
  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationMedium = Duration(milliseconds: 300);
  static const Duration animationSlow = Duration(milliseconds: 500);
  static const Duration splashDuration = Duration(milliseconds: 1500);
}
