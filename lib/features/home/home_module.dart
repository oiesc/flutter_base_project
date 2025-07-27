import 'package:go_router/go_router.dart';

import '../../global/modules/base_module.dart';
import '../../global/network/app_http.dart';
import '../../global/router/route_paths.dart';
import 'domain/usecases/home_usecase.dart';
import 'external/datasources/home_datasource.dart';
import 'infrastructure/repositories/home_repository.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/stores/home_store.dart';

class HomeModule extends BaseModule {
  HomeModule(super.getIt);

  @override
  void registerDependencies() {
    // Data Sources
    getIt.registerLazySingleton<HomeDatasource>(
      () => HomeDatasource(getIt<AppHttp>()),
    );

    // Repository
    getIt.registerLazySingleton<HomeRepository>(
      () => HomeRepository(getIt<HomeDatasource>()),
    );

    // Use Cases
    getIt.registerLazySingleton<HomeUsecase>(
      () => HomeUsecase(getIt<HomeRepository>()),
    );

    // Stores
    getIt.registerLazySingleton<HomeStore>(
      () => HomeStore(getIt<HomeUsecase>()),
    );
  }

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: RoutePaths.home,
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    // Add more home-related routes here
    // GoRoute(
    //   path: '/home/details',
    //   name: 'home-details',
    //   builder: (context, state) => const HomeDetailsPage(),
    // ),
  ];
}
