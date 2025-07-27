import 'package:go_router/go_router.dart';

import '../../global/modules/base_module.dart';
import '../../global/router/route_paths.dart';
import 'pages/settings_page.dart';

class SettingsModule extends BaseModule {
  SettingsModule(super.getIt);

  @override
  void registerDependencies() {
    // Register your settings feature dependencies here
    // Example:
    // getIt.registerLazySingleton<SettingsRepository>(() => SettingsRepositoryImpl());
    // getIt.registerLazySingleton<SettingsUseCase>(() => SettingsUseCase(getIt()));
  }

  @override
  List<RouteBase> get routes => [
        GoRoute(
          path: RoutePaths.settings,
          name: 'settings',
          builder: (context, state) => const SettingsPage(),
        ),
        // Add more settings-related routes here
      ];
}
