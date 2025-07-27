import 'package:get_it/get_it.dart';

import '../../settings/app_settings_store.dart';

class AppSettingsModule {
  final GetIt _it;

  AppSettingsModule(this._it);

  void register() {
    _it.registerSingleton<AppSettingsStore>(AppSettingsStore());
  }
}
