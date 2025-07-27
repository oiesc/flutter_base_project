import 'package:go_router/go_router.dart';

import '../../global/modules/base_module.dart';

// Exemplo de como seria um módulo completo de autenticação
class AuthModule extends BaseModule {
  AuthModule(super.getIt);

  @override
  void registerDependencies() {
    // Data Sources
    // getIt.registerLazySingleton<AuthRemoteDataSource>(
    //   () => AuthRemoteDataSourceImpl(getIt<Dio>()),
    // );
    
    // getIt.registerLazySingleton<AuthLocalDataSource>(
    //   () => AuthLocalDataSourceImpl(getIt<AppStorage>()),
    // );
    
    // Repository
    // getIt.registerLazySingleton<AuthRepository>(
    //   () => AuthRepositoryImpl(
    //     remoteDataSource: getIt(),
    //     localDataSource: getIt(),
    //   ),
    // );
    
    // Use Cases
    // getIt.registerLazySingleton<LoginUseCase>(
    //   () => LoginUseCase(getIt()),
    // );
    
    // getIt.registerLazySingleton<LogoutUseCase>(
    //   () => LogoutUseCase(getIt()),
    // );
    
    // getIt.registerLazySingleton<GetCurrentUserUseCase>(
    //   () => GetCurrentUserUseCase(getIt()),
    // );
    
    // Controllers/Blocs
    // getIt.registerFactory<AuthCubit>(
    //   () => AuthCubit(
    //     loginUseCase: getIt(),
    //     logoutUseCase: getIt(),
    //     getCurrentUserUseCase: getIt(),
    //   ),
    // );
  }

  @override
  List<RouteBase> get routes => [
        // Exemplo de rotas de autenticação
        // GoRoute(
        //   path: '/login',
        //   name: 'login',
        //   builder: (context, state) => const LoginPage(),
        // ),
        // GoRoute(
        //   path: '/register',
        //   name: 'register',
        //   builder: (context, state) => const RegisterPage(),
        // ),
        // GoRoute(
        //   path: '/forgot-password',
        //   name: 'forgot-password',
        //   builder: (context, state) => const ForgotPasswordPage(),
        // ),
      ];
}
