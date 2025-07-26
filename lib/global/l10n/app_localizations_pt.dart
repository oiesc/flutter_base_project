// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Projeto Base Flutter';

  @override
  String get appErrorInitializing => 'Erro ao inicializar aplicativo';

  @override
  String get appTryAgain => 'Tentar Novamente';

  @override
  String get appVersion => 'Versão';

  @override
  String get appName => 'Nome do App';

  @override
  String get navHome => 'Início';

  @override
  String get navSettings => 'Configurações';

  @override
  String get navPageNotFound => 'Página Não Encontrada';

  @override
  String navPageNotFoundMessage(String path) {
    return 'Página não encontrada: $path';
  }

  @override
  String get navGoHome => 'Ir para Início';

  @override
  String get homeWelcome => 'Bem-vindo ao Projeto Base Flutter';

  @override
  String get homeFeatureTitle => 'Este é um projeto base Flutter com:';

  @override
  String get homeFeatureCleanArch => '• Clean Architecture com MVVM';

  @override
  String get homeFeatureStateManagement => '• Sistema de Gerenciamento de Estado Customizado';

  @override
  String get homeFeatureI18n => '• Internacionalização (i18n)';

  @override
  String get homeFeatureTheme => '• Gerenciamento de Tema (Claro/Escuro)';

  @override
  String get homeFeatureNavigation => '• GoRouter para Navegação';

  @override
  String get homeFeatureStructure => '• Estrutura Baseada em Features';

  @override
  String get home => 'Início';

  @override
  String get welcome => 'Bem-vindo ao Projeto Base Flutter';

  @override
  String get settings => 'Configurações';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get settingsThemeSection => 'Tema';

  @override
  String get settingsLanguageSection => 'Idioma';

  @override
  String get settingsAppInfoSection => 'Informações do App';

  @override
  String get settingsThemeLight => 'Claro';

  @override
  String get settingsThemeDark => 'Escuro';

  @override
  String get settingsThemeSystem => 'Sistema';

  @override
  String get settingsLanguageEnglish => 'English';

  @override
  String get settingsLanguagePortuguese => 'Português';

  @override
  String settingsErrorLoading(String error) {
    return 'Erro ao carregar configurações: $error';
  }

  @override
  String get settingsRetry => 'Tentar Novamente';

  @override
  String get language => 'Idioma';

  @override
  String get theme => 'Tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Escuro';

  @override
  String get system => 'Sistema';
}
