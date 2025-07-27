# Organização de Módulos

Este documento explica a organização dos módulos no projeto para evitar confusões.

## Estrutura Atual

### 📁 `global/di/`
**Propósito**: Dependency Injection global da aplicação
- `app_dependency_injector.dart` - Configurador principal de DI
- `modules/` - Módulos de DI para serviços globais
  - `app_network_module.dart` - Configuração de rede (Dio, etc.)
  - `app_storage_module.dart` - Configuração de storage local
  - `app_settings_module.dart` - Configuração de settings da app

### 📁 `global/modules/`
**Propósito**: Sistema modular para features
- `base_module.dart` - Classe abstrata para módulos de feature
- `module_manager.dart` - Gerenciador dos módulos de features
- `module_exports.dart` - Barrel export dos módulos

### 📁 `features/*/`
**Propósito**: Módulos específicos de cada feature
- `home/home_module.dart` - Módulo da feature home
- `settings/settings_module.dart` - Módulo da feature settings
- `user/user_module.dart` - Módulo da feature user
- `auth/auth_module.dart` - Módulo da feature auth

## Diferenças Conceituais

### DI Modules (`global/di/modules/`)
- **Escopo**: Global/App-wide
- **Responsabilidade**: Configurar serviços compartilhados
- **Exemplos**: HTTP client, storage, configurações globais
- **Padrão**: `App*Module` (ex: AppNetworkModule)

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
- **Escopo**: Feature-specific
- **Responsabilidade**: Rotas + dependências da feature
- **Exemplos**: Repositories, UseCases, Controllers da feature
- **Padrão**: `*Module` (ex: HomeModule)

```dart
class HomeModule extends BaseModule {
  @override
  void registerDependencies() {
    getIt.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl());
  }
  
  @override
  List<RouteBase> get routes => [/* rotas da home */];
}
```

## Fluxo de Inicialização

1. **DI Global** - `AppDependencyInjector.setup()`
   - Registra serviços globais (network, storage, etc.)
   
2. **Feature Modules** - `_registerFeatureModules()`
   - Registra módulos de features via `ModuleManager`
   
3. **Router** - `AppRouter.initialize()`
   - Coleta todas as rotas dos módulos registrados

## Vantagens da Separação

✅ **Clareza conceitual**: DI global vs Feature modules
✅ **Responsabilidades bem definidas**: Cada pasta tem um propósito específico
✅ **Escalabilidade**: Fácil adicionar novos tipos de módulos
✅ **Manutenibilidade**: Mudanças isoladas por contexto
✅ **Testing**: Mock independente por tipo de módulo

## Como Usar

### Adicionando um serviço global:
1. Criar módulo em `global/di/modules/app_*_module.dart`
2. Registrar em `AppDependencyInjector.setup()`

### Adicionando uma nova feature:
1. Criar módulo em `features/*/feature_module.dart`
2. Registrar em `AppDependencyInjector._registerFeatureModules()`
