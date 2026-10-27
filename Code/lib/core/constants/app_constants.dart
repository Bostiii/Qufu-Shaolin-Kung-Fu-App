/// General app-wide constants.
class AppConstants {
  AppConstants._();

  static const String packageName = 'com.bostiii.qufu_shaolin_app';
  static const String appVersion = '0.1.0'; // keep in sync with pubspec.yaml

  // Languages
  static const String defaultLanguageCode = 'en';
  static const List<String> supportedLanguageCodes = ['en', 'zh'];

  // Validation
  static const int minPasswordLength = 8;
  static const int maxNameLength = 50;
  static const String emailPattern = r'^[^@\s]+@[^@\s]+\.[^@\s]+$';

  // Lists / paging
  static const int newsPageSize = 20;
  static const int maxNotificationsStored = 100;

  // Retry
  static const int maxRetryCount = 3;
  static const Duration retryDelay = Duration(seconds: 2);
}
