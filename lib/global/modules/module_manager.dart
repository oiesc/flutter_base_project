import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import 'base_module.dart';

/// Module manager that handles all feature modules
class ModuleManager {
  static final ModuleManager _instance = ModuleManager._internal();
  factory ModuleManager() => _instance;
  ModuleManager._internal();

  final List<BaseModule> _modules = [];
  final GetIt _getIt = GetIt.I;

  /// Register a module
  void registerModule(BaseModule module) {
    _modules.add(module);
    module.register();
  }

  /// Get all routes from registered modules
  List<RouteBase> getAllRoutes() {
    final List<RouteBase> allRoutes = [];
    for (final module in _modules) {
      allRoutes.addAll(module.routes);
    }
    return allRoutes;
  }

  /// Get GetIt instance
  GetIt get getIt => _getIt;

  /// Clear all modules (useful for testing)
  void clear() {
    _modules.clear();
  }
}
