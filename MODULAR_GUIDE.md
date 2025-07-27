# Sistema Modular - Guia de Uso

Este projeto implementa um sistema modular inspirado no package Modular, permitindo que cada feature gerencie suas próprias rotas e dependências de forma organizada.

## Estrutura Base

### BaseModule
Classe abstrata que define a interface para todos os módulos de feature:

```dart
abstract class BaseModule {
  void registerDependencies(); // Registra dependências do GetIt
  List<RouteBase> get routes;  // Define rotas da feature
}
```

### ModuleManager
Gerencia todos os módulos registrados e coleta rotas/dependências:

```dart
final moduleManager = ModuleManager();
moduleManager.registerModule(HomeModule(getIt));
```

## Como Criar um Novo Módulo

### 1. Criar a classe do módulo

```dart
// lib/features/exemplo/exemplo_module.dart
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../global/modules/base_module.dart';

class ExemploModule extends BaseModule {
  ExemploModule(GetIt getIt) : super(getIt);

  @override
  void registerDependencies() {
    // Registre as dependências da feature
    getIt.registerLazySingleton<ExemploRepository>(
      () => ExemploRepositoryImpl(),
    );
    getIt.registerLazySingleton<ExemploUseCase>(
      () => ExemploUseCase(getIt()),
    );
  }

  @override
  List<RouteBase> get routes => [
    GoRoute(
      path: '/exemplo',
      name: 'exemplo',
      builder: (context, state) => const ExemploPage(),
    ),
    GoRoute(
      path: '/exemplo/detalhes/:id',
      name: 'exemplo-detalhes',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ExemploDetalhesPage(id: id);
      },
    ),
  ];
}
```

### 2. Registrar o módulo

No arquivo `lib/global/di/app_dependency_injector.dart`, adicione o módulo:

```dart
static void _registerFeatureModules() {
  final moduleManager = ModuleManager();
  
  moduleManager.registerModule(HomeModule(_it));
  moduleManager.registerModule(SettingsModule(_it));
  moduleManager.registerModule(ExemploModule(_it)); // Novo módulo
}
```

### 3. Definir constantes de rotas (opcional)

No arquivo `lib/global/router/route_paths.dart`:

```dart
class RoutePaths {
  static const String home = '/';
  static const String settings = '/settings';
  static const String exemplo = '/exemplo'; // Nova rota
}
```

## Vantagens do Sistema

### ✅ Organização
- Cada feature gerencia suas próprias rotas e dependências
- Código modular e fácil de manter

### ✅ Desacoplamento
- Features podem ser desenvolvidas independentemente
- Fácil remoção ou adição de features

### ✅ Reutilização
- Dependências ficam encapsuladas no módulo
- Fácil testing com mocks

### ✅ Escalabilidade
- Adicionar novas features é simples
- Não precisa modificar arquivos centrais

## Exemplo de Uso

### Registrando dependências complexas:

```dart
@override
void registerDependencies() {
  // Data sources
  getIt.registerLazySingleton<ExemploRemoteDataSource>(
    () => ExemploRemoteDataSourceImpl(getIt<Dio>()),
  );
  
  getIt.registerLazySingleton<ExemploLocalDataSource>(
    () => ExemploLocalDataSourceImpl(getIt<AppStorage>()),
  );
  
  // Repository
  getIt.registerLazySingleton<ExemploRepository>(
    () => ExemploRepositoryImpl(
      remoteDataSource: getIt(),
      localDataSource: getIt(),
    ),
  );
  
  // Use cases
  getIt.registerLazySingleton<GetExemploUseCase>(
    () => GetExemploUseCase(getIt()),
  );
  
  getIt.registerLazySingleton<CreateExemploUseCase>(
    () => CreateExemploUseCase(getIt()),
  );
  
  // Blocs/Controllers
  getIt.registerFactory<ExemploCubit>(
    () => ExemploCubit(
      getExemploUseCase: getIt(),
      createExemploUseCase: getIt(),
    ),
  );
}
```

### Definindo rotas com parâmetros:

```dart
@override
List<RouteBase> get routes => [
  GoRoute(
    path: '/exemplo',
    name: 'exemplo-lista',
    builder: (context, state) => const ExemploListaPage(),
    routes: [
      GoRoute(
        path: '/detalhes/:id',
        name: 'exemplo-detalhes',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ExemploDetalhesPage(id: id);
        },
      ),
      GoRoute(
        path: '/criar',
        name: 'exemplo-criar',
        builder: (context, state) => const ExemploCriarPage(),
      ),
    ],
  ),
];
```

## Navegação

Com as rotas definidas nos módulos, a navegação funciona normalmente:

```dart
// Ir para uma página
context.push('/exemplo');
context.pushNamed('exemplo-detalhes', pathParameters: {'id': '123'});

// Voltar
context.pop();

// Substituir
context.go('/exemplo');
```

## Testing

Para testes, você pode facilmente mockar as dependências:

```dart
setUp(() {
  // Limpar módulos existentes
  ModuleManager().clear();
  GetIt.I.reset();
  
  // Registrar mocks
  GetIt.I.registerLazySingleton<ExemploRepository>(
    () => MockExemploRepository(),
  );
});
```
