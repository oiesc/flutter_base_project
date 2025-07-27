import 'package:flutter/material.dart';

import 'app/app.dart';
import 'global/constants/app_config.dart';
import 'global/di/app_dependency_injector.dart';
import 'global/router/app_router.dart';
import 'global/settings/app_settings_store.dart';
import 'global/utils/app_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Setup dependency injection and register modules
  AppDependencyInjector.setup();

  // Initialize router with registered modules
  AppRouter.initialize();

  await AppInfo.initialize();

  if (AppConfig.debugMode) {
    AppConfig.printConfig();
  }

  // Initialize app settings
  final settingsStore = AppSettingsStore.instance;
  await settingsStore.initialize();

  runApp(App(settingsStore: settingsStore));
}
