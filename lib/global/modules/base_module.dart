import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

/// Base module class that all feature modules should extend
abstract class BaseModule {
  final GetIt _getIt;

  BaseModule(this._getIt);

  /// Register dependencies for this module
  void registerDependencies();

  /// Register routes for this module
  List<RouteBase> get routes;

  /// Initialize the module (register dependencies)
  void register() {
    registerDependencies();
  }

  /// Getter for GetIt instance
  GetIt get getIt => _getIt;
}
