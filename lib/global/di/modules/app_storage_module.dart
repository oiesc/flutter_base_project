import 'package:get_it/get_it.dart';

import '../../services/app_storage/app_storage.dart';

class AppStorageModule {
  final GetIt _it;

  AppStorageModule(this._it);

  void register() {
    _it.registerLazySingleton<AppStorage>(() => AppStorage());
  }
}
