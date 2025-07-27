# Modular System - Usage Guide

This project implements a modular system inspired by the Modular package, allowing each feature to manage its own routes and dependencies in an organized way.

## Base Structure

### BaseModule
Abstract class that defines the interface for all feature modules:

```dart
abstract class BaseModule {
  void registerDependencies(); // Register GetIt dependencies
  List<RouteBase> get routes;  // Define feature routes
}
```

### ModuleManager
Manages all registered modules and collects routes/dependencies:

```dart
final moduleManager = ModuleManager();
moduleManager.registerModule(HomeModule(getIt));
```

## How to Create a New Module

### 1. Create the module class

```dart
// lib/features/example/example_module.dart
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../global/modules/base_module.dart';

class ExampleModule extends BaseModule {
  ExampleModule(GetIt getIt) : super(getIt);

  @override
  void registerDependencies() {
    // Register feature dependencies
    getIt.registerLazySingleton<ExampleRepository>(
      () => ExampleRepositoryImpl(),
    );
    getIt.registerLazySingleton<ExampleUseCase>(
      () => ExampleUseCase(getIt()),
    );
  }

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/example',
      name: 'example',
      builder: (context, state) => const ExamplePage(),
    ),
    GoRoute(
      path: '/example/details/:id',
      name: 'example-details',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ExampleDetailsPage(id: id);
      },
    ),
  ];
}
```

### 2. Register the module

In the file `lib/global/di/app_dependency_injector.dart`, add the module:

```dart
static void _registerFeatureModules() {
  final moduleManager = ModuleManager();
  
  moduleManager.registerModule(HomeModule(_it));
  moduleManager.registerModule(SettingsModule(_it));
  moduleManager.registerModule(ExampleModule(_it)); // New module
}
```

### 3. Define route constants (optional)

In the file `lib/global/router/route_paths.dart`:

```dart
class RoutePaths {
  static const String home = '/';
  static const String settings = '/settings';
  static const String example = '/example'; // New route
}
```

## System Advantages

### ✅ Organization
- Each feature manages its own routes and dependencies
- Modular and easy to maintain code

### ✅ Decoupling
- Features can be developed independently
- Easy removal or addition of features

### ✅ Reusability
- Dependencies are encapsulated in the module
- Easy testing with mocks

### ✅ Scalability
- Adding new features is simple
- No need to modify central files

## Usage Example

### Registering complex dependencies:

```dart
@override
void registerDependencies() {
  // Data sources
  getIt.registerLazySingleton<ExampleRemoteDataSource>(
    () => ExampleRemoteDataSourceImpl(getIt<Dio>()),
  );
  
  getIt.registerLazySingleton<ExampleLocalDataSource>(
    () => ExampleLocalDataSourceImpl(getIt<AppStorage>()),
  );
  
  // Repository
  getIt.registerLazySingleton<ExampleRepository>(
    () => ExampleRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );
  
  // Use cases
  getIt.registerLazySingleton<GetExampleUseCase>(
    () => GetExampleUseCase(getIt()),
  );
  
  getIt.registerLazySingleton<CreateExampleUseCase>(
    () => CreateExampleUseCase(getIt()),
  );
  
  // Stores/Controllers
  getIt.registerFactory<ExampleStore>(
    () => ExampleStore(
      getExampleUseCase: getIt(),
      createExampleUseCase: getIt(),
    ),
  );
}
```

### Defining routes with parameters:

```dart
@override
List<RouteBase> get routes => [
  GoRoute(
    path: '/example',
    name: 'example-list',
    builder: (context, state) => const ExampleListPage(),
    routes: [
      GoRoute(
        path: '/details/:id',
        name: 'example-details',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ExampleDetailsPage(id: id);
        },
      ),
      GoRoute(
        path: '/create',
        name: 'example-create',
        builder: (context, state) => const ExampleCreatePage(),
      ),
    ],
  ),
];
```

## Navigation

With routes defined in modules, navigation works normally:

```dart
// Go to a page
context.push('/example');
context.pushNamed('example-details', pathParameters: {'id': '123'});

// Go back
context.pop();

// Replace
context.go('/example');
```

## Testing

For tests, you can easily mock dependencies:

```dart
setUp(() {
  // Clear existing modules
  ModuleManager().clear();
  GetIt.I.reset();
  
  // Register mocks
  GetIt.I.registerLazySingleton<ExampleRepository>(
    () => MockExampleRepository(),
  );
});
```
