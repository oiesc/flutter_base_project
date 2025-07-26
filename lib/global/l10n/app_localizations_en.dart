// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Flutter Base Project';

  @override
  String get appErrorInitializing => 'Error initializing app';

  @override
  String get appTryAgain => 'Try Again';

  @override
  String get appVersion => 'Version';

  @override
  String get appName => 'App Name';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'Settings';

  @override
  String get navPageNotFound => 'Page Not Found';

  @override
  String navPageNotFoundMessage(String path) {
    return 'Page not found: $path';
  }

  @override
  String get navGoHome => 'Go Home';

  @override
  String get homeWelcome => 'Welcome to Flutter Base Project';

  @override
  String get homeFeatureTitle => 'This is a Flutter base project with:';

  @override
  String get homeFeatureCleanArch => '• Clean Architecture with MVVM';

  @override
  String get homeFeatureStateManagement => '• Custom State Management Store';

  @override
  String get homeFeatureI18n => '• Internationalization (i18n)';

  @override
  String get homeFeatureTheme => '• Theme Management (Light/Dark)';

  @override
  String get homeFeatureNavigation => '• GoRouter for Navigation';

  @override
  String get homeFeatureStructure => '• Feature-based Structure';

  @override
  String get home => 'Home';

  @override
  String get welcome => 'Welcome to Flutter Base Project';

  @override
  String get settings => 'Settings';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsThemeSection => 'Theme';

  @override
  String get settingsLanguageSection => 'Language';

  @override
  String get settingsAppInfoSection => 'App Information';

  @override
  String get settingsThemeLight => 'Light';

  @override
  String get settingsThemeDark => 'Dark';

  @override
  String get settingsThemeSystem => 'System';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String settingsErrorLoading(String error) {
    return 'Error loading settings: $error';
  }

  @override
  String get settingsRetry => 'Retry';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';
}
