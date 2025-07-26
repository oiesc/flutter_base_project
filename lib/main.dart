import 'package:flutter/material.dart';

import 'app/app.dart';
import 'global/constants/app_config.dart';
import 'global/settings/app_settings_store.dart';
import 'global/utils/app_info.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppInfo.initialize();

  if (AppConfig.debugMode) {
    AppConfig.printConfig();
  }

  // Initialize app settings
  final settingsStore = AppSettingsStore();
  await settingsStore.initialize();

  runApp(App(settingsStore: settingsStore));
}
