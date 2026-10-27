/// Keys for local storage (shared_preferences / offline cache).
/// One place for all keys avoids typos and duplicates.
class StorageKeys {
  StorageKeys._();

  // Settings
  static const String languageCode = 'language_code';
  static const String themeMode = 'theme_mode';
  static const String notificationsEnabled = 'notifications_enabled';

  // Onboarding / user
  static const String onboardingDone = 'onboarding_done';
  static const String studentType = 'student_type';
  static const String tutorialDone = 'tutorial_done';
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userId = 'user_id';

  // Offline cache of live data
  static const String cacheSchedule = 'cache_schedule';
  static const String cacheNews = 'cache_news';
  static const String cacheCleaningDuty = 'cache_cleaning_duty';
  static const String cacheMastersOnDuty = 'cache_masters_on_duty';
  static const String cacheLastUpdated = 'cache_last_updated';
}
