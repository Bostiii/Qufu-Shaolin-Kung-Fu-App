/// Texts that are NOT translated (names, URLs, fixed labels).
///
/// All translated UI texts belong in the ARB files
/// (app_en.arb / app_zh.arb) and are used with
/// AppLocalizations.of(context). Do not put them here.
class TextStrings {
  TextStrings._();

  // App
  static const String appName = 'Qufu Shaolin Kung Fu';
  static const String appNameZh = '曲阜少林功夫';

  // School
  static const String schoolName = 'Qufu Shaolin Kung Fu School';
  static const String schoolNameZh = '中国曲阜少林功夫学校';
  static const String schoolWebsite = 'https://www.shaolinskungfu.com';

  // Style names (original Chinese names, always shown as they are)
  static const String taiChiZh = '太极';
  static const String shaolinZh = '少林功夫';
  static const String wingChunZh = '咏春';
  static const String sandaZh = '散打';
  static const String mantisZh = '螳螂拳';
  static const String bajiZh = '八极';
  static const String xingyiZh = '形意';
  static const String baguaZh = '八卦';
  static const String qigongZh = '气功';

  // Formats
  static const String dateFormat = 'dd.MM.yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd.MM.yyyy HH:mm';

  // Misc
  static const String copyright = '© 2026 Bostiii';
  static const String emptyValue = '–';
}
