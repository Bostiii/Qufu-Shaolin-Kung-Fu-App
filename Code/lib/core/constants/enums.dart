import 'package:flutter/material.dart';

/// Old or new student (chosen in onboarding, decides the tutorial).
enum StudentType { newStudent, oldStudent }

/// Supported app languages. Add more here later.
enum AppLanguage {
  en(Locale('en'), 'English'),
  zh(Locale('zh'), '中文');

  const AppLanguage(this.locale, this.label);

  final Locale locale;
  final String label;

  String get code => locale.languageCode;

  static AppLanguage fromCode(String? code) => AppLanguage.values.firstWhere(
        (l) => l.code == code,
        orElse: () => AppLanguage.en,
      );
}

/// Martial arts styles taught / presented in the app.
/// The first four are the main styles from the README,
/// the others come from the school's style texts.
enum MartialArtStyle {
  taiChi,
  shaolin,
  wingChun,
  sanda,
  mantis,
  baji,
  xingyi,
  bagua,
  qigong,
}

/// Bottom navigation tabs.
enum AppTab { home, schedule, news, styles, school }

/// Theme choice in settings.
enum AppThemeOption { system, light, dark }

/// Authentication state.
enum AuthStatus { unknown, signedOut, signedIn }

/// Generic loading state for live data screens.
enum LoadStatus { initial, loading, success, empty, error, offline }

/// Types of notifications.
enum NotificationType { news, event, scheduleChange, dutyChange, general }

/// Media types bundled in the app.
enum MediaType { photo, video }

/// Weekdays for the schedule (Monday first).
enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }
