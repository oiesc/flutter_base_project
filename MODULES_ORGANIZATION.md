# Module Organization

This document explains the module organization in the project to avoid confusion.

## Current Structure

### 📁 `global/di/`
**Purpose**: Global Dependency Injection for the application
- `app_dependency_injector.dart` - Main DI configurator
- `modules/` - DI modules for global services
  - `app_network_module.dart` - Network configuration (Dio, etc.)
  - `app_storage_module.dart` - Local storage configuration
  - `app_settings_module.dart` - App settings configuration

### 📁 `global/modules/`
**Purpose**: Modular system for features
- `base_module.dart` - Abstract class for feature modules
- `module_manager.dart` - Feature modules manager
- `module_exports.dart` - Barrel export for modules

### 📁 `features/*/`
**Purpose**: Specific modules for each feature
- `home/home_module.dart` - Home feature module
- `settings/settings_module.dart` - Settings feature module
- `user/user_module.dart` - User feature module
- `auth/auth_module.dart` - Auth feature module

## Conceptual Differences

### DI Modules (`global/di/modules/`)
- **Scope**: Global/App-wide
- **Responsibility**: Configure shared services
- **Examples**: HTTP client, storage, global configurations
- **Pattern**: `App*Module` (ex: AppNetworkModule)

```dart
class AppNetworkModule {
  final GetIt _it;
  AppNetworkModule(this._it);
  
  void register() {
    _it.registerLazySingleton<Dio>(() => Dio());
  }
}
```

### Feature Modules (`global/modules/` + `features/*/`)
- **Scope**: Feature-specific
- **Responsibility**: Routes + feature dependencies
- **Examples**: Repositories, UseCases, Controllers for the feature
- **Pattern**: `*Module` (ex: HomeModule)

```dart
class HomeModule extends BaseModule {
  @override
  void registerDependencies() {
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  }
  
  @override
  List<RouteBase> get routes => [/* home routes */];
}
```

## Initialization Flow

1. **Global DI** - `AppDependencyInjector.setup()`
   - Register global services (network, storage, etc.)
   
2. **Feature Modules** - `_registerFeatureModules()`
   - Register feature modules via `ModuleManager`
   
3. **Router** - `AppRouter.initialize()`
   - Collect all routes from registered modules

## Separation Advantages

✅ **Conceptual clarity**: Global DI vs Feature modules
✅ **Well-defined responsibilities**: Each folder has a specific purpose
✅ **Scalability**: Easy to add new types of modules
✅ **Maintainability**: Isolated changes by context
✅ **Testing**: Independent mocking by module type

## How to Use

### Adding a global service:
1. Create module in `global/di/modules/app_*_module.dart`
2. Register in `AppDependencyInjector.setup()`

### Adding a new feature:
1. Create module in `features/*/feature_module.dart`
2. Register in `AppDependencyInjector._registerFeatureModules()`
