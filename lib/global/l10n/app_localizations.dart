import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en'), Locale('pt')];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Flutter Base Project'**
  String get appTitle;

  /// Error message when app fails to initialize
  ///
  /// In en, this message translates to:
  /// **'Error initializing app'**
  String get appErrorInitializing;

  /// Button text to retry an operation
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get appTryAgain;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// App name label
  ///
  /// In en, this message translates to:
  /// **'App Name'**
  String get appName;

  /// Home navigation label
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// Settings navigation label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Page not found title
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get navPageNotFound;

  /// Page not found message with path
  ///
  /// In en, this message translates to:
  /// **'Page not found: {path}'**
  String navPageNotFoundMessage(String path);

  /// Button to go to home page
  ///
  /// In en, this message translates to:
  /// **'Go Home'**
  String get navGoHome;

  /// Welcome message on home page
  ///
  /// In en, this message translates to:
  /// **'Welcome to Flutter Base Project'**
  String get homeWelcome;

  /// Title for feature list
  ///
  /// In en, this message translates to:
  /// **'This is a Flutter base project with:'**
  String get homeFeatureTitle;

  /// Clean architecture feature
  ///
  /// In en, this message translates to:
  /// **'• Clean Architecture with MVVM'**
  String get homeFeatureCleanArch;

  /// State management feature
  ///
  /// In en, this message translates to:
  /// **'• Custom State Management Store'**
  String get homeFeatureStateManagement;

  /// Internationalization feature
  ///
  /// In en, this message translates to:
  /// **'• Internationalization (i18n)'**
  String get homeFeatureI18n;

  /// Theme management feature
  ///
  /// In en, this message translates to:
  /// **'• Theme Management (Light/Dark)'**
  String get homeFeatureTheme;

  /// Navigation feature
  ///
  /// In en, this message translates to:
  /// **'• GoRouter for Navigation'**
  String get homeFeatureNavigation;

  /// Project structure feature
  ///
  /// In en, this message translates to:
  /// **'• Feature-based Structure'**
  String get homeFeatureStructure;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome to Flutter Base Project'**
  String get welcome;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Theme section title
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsThemeSection;

  /// Language section title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageSection;

  /// App information section title
  ///
  /// In en, this message translates to:
  /// **'App Information'**
  String get settingsAppInfoSection;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// Portuguese language option
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get settingsLanguagePortuguese;

  /// Error message when settings fail to load
  ///
  /// In en, this message translates to:
  /// **'Error loading settings: {error}'**
  String settingsErrorLoading(String error);

  /// Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get settingsRetry;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Theme selection label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
