import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Qufu Shaolin Kung Fu School'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get navSchedule;

  /// No description provided for @navNews.
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get navNews;

  /// No description provided for @navStyles.
  ///
  /// In en, this message translates to:
  /// **'Styles'**
  String get navStyles;

  /// No description provided for @navInfo.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get navInfo;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageChinese.
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get languageChinese;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboardingTitle;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeTitle;

  /// No description provided for @welcomeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your school in your pocket: schedule, news, guides and more.'**
  String get welcomeSubtitle;

  /// No description provided for @welcomeGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get welcomeGetStarted;

  /// No description provided for @welcomeLogin.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get welcomeLogin;

  /// No description provided for @newStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'New students'**
  String get newStudentTitle;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @scheduleNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get scheduleNow;

  /// No description provided for @scheduleFreeTime.
  ///
  /// In en, this message translates to:
  /// **'Free time'**
  String get scheduleFreeTime;

  /// No description provided for @scheduleGate.
  ///
  /// In en, this message translates to:
  /// **'Gate'**
  String get scheduleGate;

  /// No description provided for @scheduleLegendMartial.
  ///
  /// In en, this message translates to:
  /// **'Martial arts'**
  String get scheduleLegendMartial;

  /// No description provided for @scheduleLegendOptional.
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get scheduleLegendOptional;

  /// No description provided for @scheduleLegendTraining.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get scheduleLegendTraining;

  /// No description provided for @scheduleLegendCulture.
  ///
  /// In en, this message translates to:
  /// **'Culture'**
  String get scheduleLegendCulture;

  /// No description provided for @scheduleLegendMeals.
  ///
  /// In en, this message translates to:
  /// **'Meals'**
  String get scheduleLegendMeals;

  /// No description provided for @scheduleLegendFree.
  ///
  /// In en, this message translates to:
  /// **'Blank = free time'**
  String get scheduleLegendFree;

  /// No description provided for @classTaiChiOptional.
  ///
  /// In en, this message translates to:
  /// **'Tai Chi (optional)'**
  String get classTaiChiOptional;

  /// No description provided for @classBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get classBreakfast;

  /// No description provided for @classShaolin.
  ///
  /// In en, this message translates to:
  /// **'Shaolin'**
  String get classShaolin;

  /// No description provided for @classWingChun.
  ///
  /// In en, this message translates to:
  /// **'Wing Chun'**
  String get classWingChun;

  /// No description provided for @classQigong.
  ///
  /// In en, this message translates to:
  /// **'Qigong'**
  String get classQigong;

  /// No description provided for @classTakedownsChinNa.
  ///
  /// In en, this message translates to:
  /// **'Takedowns / Chin Na'**
  String get classTakedownsChinNa;

  /// No description provided for @classJumpAndRoll.
  ///
  /// In en, this message translates to:
  /// **'Jump & Roll'**
  String get classJumpAndRoll;

  /// No description provided for @classConditioning.
  ///
  /// In en, this message translates to:
  /// **'Conditioning'**
  String get classConditioning;

  /// No description provided for @classLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get classLunch;

  /// No description provided for @classSanda.
  ///
  /// In en, this message translates to:
  /// **'Sanda'**
  String get classSanda;

  /// No description provided for @classMountainClimbing.
  ///
  /// In en, this message translates to:
  /// **'Mountain Climbing'**
  String get classMountainClimbing;

  /// No description provided for @classDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get classDinner;

  /// No description provided for @classMandarin.
  ///
  /// In en, this message translates to:
  /// **'Mandarin'**
  String get classMandarin;

  /// No description provided for @classCalligraphyTcm.
  ///
  /// In en, this message translates to:
  /// **'Calligraphy / TCM'**
  String get classCalligraphyTcm;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsEmpty;

  /// No description provided for @notificationsInDevelopment.
  ///
  /// In en, this message translates to:
  /// **'(In development)'**
  String get notificationsInDevelopment;

  /// No description provided for @scheduleSeasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Schedule time'**
  String get scheduleSeasonLabel;

  /// No description provided for @scheduleSeasonSummer.
  ///
  /// In en, this message translates to:
  /// **'Summer time'**
  String get scheduleSeasonSummer;

  /// No description provided for @scheduleSeasonWinter.
  ///
  /// In en, this message translates to:
  /// **'Winter time'**
  String get scheduleSeasonWinter;

  /// No description provided for @scheduleSeasonSummerHint.
  ///
  /// In en, this message translates to:
  /// **'Standard timetable.'**
  String get scheduleSeasonSummerHint;

  /// No description provided for @scheduleSeasonWinterHint.
  ///
  /// In en, this message translates to:
  /// **'Winter time: classes after lunch start 30 minutes earlier. Gate closing times stay the same.'**
  String get scheduleSeasonWinterHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
