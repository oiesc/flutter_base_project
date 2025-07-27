import 'package:get_it/get_it.dart';

import 'modules/app_network_module.dart';
import 'modules/app_storage_module.dart';

class AppDependencyInjector {
  static GetIt get _it => GetIt.I;

  static void setup() {
    AppStorageModule(_it).register();
    AppNetworkModule(_it).register();
  }
}
