import 'package:get_it/get_it.dart';

import '../../network/app_http.dart';

class AppNetworkModule {
  final GetIt _it;

  AppNetworkModule(this._it);

  void register() {
    _it.registerFactory<AppHttp>(() => AppHttp());
  }
}
