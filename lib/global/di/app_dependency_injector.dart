import 'package:get_it/get_it.dart';

import '../../features/home/home_module.dart';
import '../../features/settings/settings_module.dart';
import '../modules/module_manager.dart';
import 'shared_modules/app_network_module.dart';
import 'shared_modules/app_settings_module.dart';
import 'shared_modules/app_storage_module.dart';

class AppDependencyInjector {
  static GetIt get _it => GetIt.I;

  static void setup() {
    // Register global modules first
    AppStorageModule(_it).register();
    AppNetworkModule(_it).register();
    AppSettingsModule(_it).register();

    // Register feature modules
    _registerFeatureModules();
  }

  static void _registerFeatureModules() {
    final moduleManager = ModuleManager();

    // Register all feature modules
    moduleManager.registerModule(HomeModule(_it));
    moduleManager.registerModule(SettingsModule(_it));

    // Add more feature modules here as you create them
    // moduleManager.registerModule(UserModule(_it));
    // moduleManager.registerModule(AuthModule(_it));
  }
}
