import 'package:go_router/go_router.dart';

import '../../global/modules/base_module.dart';

class UserModule extends BaseModule {
  UserModule(super.getIt);

  @override
  void registerDependencies() {
    // Register your user feature dependencies here
    // Example:
    // getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl());
    // getIt.registerLazySingleton<GetUserUseCase>(() => GetUserUseCase(getIt()));
    // getIt.registerLazySingleton<UpdateUserUseCase>(() => UpdateUserUseCase(getIt()));
  }

  @override
  List<RouteBase> get routes => [
        // Add user-related routes here
        // GoRoute(
        //   path: '/user/profile',
        //   name: 'user-profile',
        //   builder: (context, state) => const UserProfilePage(),
        // ),
        // GoRoute(
        //   path: '/user/edit',
        //   name: 'user-edit',
        //   builder: (context, state) => const UserEditPage(),
        // ),
      ];
}
