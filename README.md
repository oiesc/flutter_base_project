# Flutter Base Project

A Flutter base project built with **Clean Architecture**, **Custom State Management**, and **Feature-Based Organization**. This project serves as a robust template for future Flutter projects, providing a scalable, well-organized, and production-ready structure with real-world implementation examples.

## 🏗️ Architecture

This project implements Clean Architecture organized by features, ensuring:

- **Separation of responsibilities** across layers
- **Testability** with proper dependency injection
- **Scalability** through modular feature organization
- **Maintainability** with clear code structure
- **Code reusability** via shared global modules

The project includes a fully functional **Home feature** that demonstrates:
- API integration with external services (Dog CEO API)
- Custom state management using ValueStore
- Error handling across all layers
- Clean Architecture implementation with Domain, Infrastructure, and Presentation layers

### 📁 Folder Structure

```
lib/
├── app/                          # Main application configuration
│   └── app.dart                  # Main app widget
├── features/                     # Feature modules
│   ├── home/                     # Home feature (Complete implementation)
│   │   ├── domain/               # Domain layer
│   │   │   ├── models/          # Domain models (HomeImage)
│   │   │   └── usecases/        # Use cases (HomeUsecase)
│   │   ├── infrastructure/       # Infrastructure layer
│   │   │   └── repositories/    # Repository implementations (HomeRepository)
│   │   ├── external/            # External data layer
│   │   │   ├── datasources/     # External API data sources (HomeDatasource)
│   │   │   └── settings/        # API endpoints configuration
│   │   └── presentation/        # Presentation layer
│   │       ├── stores/          # State management (HomeStore)
│   │       ├── pages/           # UI pages
│   │       └── widgets/         # Feature-specific widgets
│   └── settings/                # Settings feature
│       └── pages/               # Settings pages
└── global/                      # Shared modules
    ├── app_core/               # Application core
    │   ├── domain/             # Core domain models (Either)
    │   ├── failures/           # Global failure classes
    │   └── store/              # State management system (ValueStore, AppState)
    ├── constants/              # Global constants (AppConfig)
    ├── l10n/                   # Internationalization (Generated)
    ├── network/                # HTTP client configuration (AppHttp)
    ├── services/               # Global services
    │   └── app_storage/        # Local storage service (AppStorage)
    ├── settings/               # Global settings management (AppSettingsStore)
    ├── themes/                 # Application themes
    ├── router/                 # Route configuration (GoRouter)
    └── utils/                  # Global utilities (AppLogger, AppInfo)
```

## 🎯 Key Features

### ✅ Complete Home Feature Implementation
- **Dog Image API Integration**: Real API integration with Dog CEO API
- **Clean Architecture**: Complete implementation across all layers
- **Error Handling**: Comprehensive error handling at each layer
- **State Management**: Custom ValueStore implementation with reactive UI
- **Testing**: Unit tests for all layers with proper mocking

### ✅ Custom State Management System
- **ValueStore**: Custom state management extending ValueNotifier
- **AppState**: Type-safe state pattern (Idle, Loading, Success, Error)
- **Reactive UI**: Automatic UI updates with ListenableBuilder
- **Error State Handling**: Structured error management with AppGenericFailure

### ✅ HTTP Client & Networking
- **AppHttp**: Dio-based HTTP client with global configuration
- **Environment-based configuration**: Different settings per environment
- **Automatic timeout configuration**: Configurable request/response timeouts
- **Error handling**: Network-specific error handling and transformations

### ✅ Local Storage
- **AppStorage**: Unified storage interface using SharedPreferences
- **Type-safe operations**: Strongly typed storage methods
- **Centralized key management**: Organized storage keys in AppStorageKeys
- **Easy data persistence**: Simple API for data storage and retrieval

### ✅ App Information
- **AppInfo**: Package information utilities powered by package_info_plus
- **Version management**: Access to app version and build numbers
- **Environment info**: Runtime environment configuration access
- **App metadata**: Centralized app information management

### ✅ Logging System
- **AppLogger**: Centralized logging system using logger package
- **Environment-based levels**: Different log levels per environment
- **Structured logging**: Consistent log formatting and categorization
- **Debug utilities**: Enhanced debugging capabilities

### ✅ Clean Architecture Implementation
- **Domain Layer**: Business logic, use cases, and domain models
- **Infrastructure Layer**: Data access, repositories, and external APIs
- **Presentation Layer**: UI components, state management, and user interactions
- **External Layer**: API data sources and external service integrations
- **Proper Dependency Inversion**: Interfaces and implementations properly separated

### ✅ Settings Management
- **AppSettingsStore**: Global settings using ValueStore pattern
- **Theme persistence**: Automatic theme mode storage and retrieval
- **Locale preferences**: Language selection with persistence
- **Type-safe operations**: Strongly typed settings management
- **Reactive updates**: Automatic UI updates when settings change

### ✅ Environment Configuration
- **Dart Define from File**: No external dependencies for environment config
- **Multiple environments**: Development, Staging, Production configurations
- **VS Code integration**: Launch configurations for each environment
- **Type-safe access**: Compile-time checked configuration values
- **AppConfig utility**: Centralized environment configuration access

### ✅ Either Pattern Implementation
- **Functional Error Handling**: Custom Either<Left, Right> implementation
- **Railway-oriented programming**: Clean error handling flow
- **Type safety**: Compile-time error checking
- **Fold operations**: Pattern matching for success/failure cases

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.8.1+
- Dart 3.8+
- VS Code (recommended for launch configurations)

### Installation

1. **Clone the repository:**
```bash
git clone <your-repository>
cd flutter_base_project
```

2. **Install dependencies:**
```bash
flutter pub get
```

3. **Generate localization files:**
```bash
flutter gen-l10n
```

4. **Run the project:**

**Using VS Code (Recommended):**
- Open the project in VS Code
- Go to Run and Debug (Ctrl+Shift+D)
- Select the desired environment:
  - `Development` - Debug mode with development settings
  - `Staging` - Debug mode with staging settings
  - `Production` - Debug mode with production settings
  - `Development (Profile)` - Profile mode
  - `Production (Release)` - Release mode

**Using command line:**
```bash
# Development
flutter run --dart-define-from-file=env/development.json

# Staging
flutter run --dart-define-from-file=env/staging.json

# Production
flutter run --dart-define-from-file=env/production.json
```

### 🏗️ Build

```bash
# Development APK
flutter build apk --dart-define-from-file=env/development.json

# Production APK
flutter build apk --dart-define-from-file=env/production.json

# Web build
flutter build web --dart-define-from-file=env/production.json
```

## 🏛️ Architecture Layers

### 📱 Presentation Layer
- **Pages**: Application screens and navigation destinations
- **Widgets**: Custom UI components and feature-specific widgets
- **Stores**: State management using ValueStore pattern (HomeStore)
- **Components**: Reusable UI components across features

### 🎯 Domain Layer
- **Models**: Domain entities and business objects (HomeImage)
- **UseCases**: Business logic implementation (HomeUsecase)
- **Either Pattern**: Functional error handling with Left/Right pattern
- **Failures**: Domain-specific error definitions

### 🔧 Infrastructure Layer
- **Repositories**: Data access abstractions and implementations (HomeRepository)
- **Settings**: Feature-specific configuration and constants
- **Data transformation**: Converting external data to domain models

### 🌐 External Layer
- **Data Sources**: External API integrations (HomeDatasource)
- **HTTP Client**: Network communication setup and configuration
- **API Endpoints**: External service endpoint definitions

## 📦 Main Dependencies

```yaml
dependencies:
  flutter_localizations: # Internationalization
  intl: ^0.20.2          # Date/number formatting
  go_router: ^14.6.2     # Navigation
  get_it: ^8.0.2         # Dependency injection
  shared_preferences: ^2.3.3  # Local persistence
  path_provider: ^2.1.5  # File system paths
  dio: ^5.7.0            # HTTP client
  logger: ^2.5.0         # Logging
  package_info_plus: ^8.1.1 # App information
  json_annotation: ^4.9.0    # JSON serialization
  cupertino_icons: ^1.0.8    # iOS style icons

dev_dependencies:
  flutter_lints: ^5.0.0      # Linting rules
  build_runner: ^2.4.13      # Code generation
  json_serializable: ^6.8.0  # JSON code generation
  mockito: ^5.4.4            # Mocking for tests
```

## 🌍 Environment Configuration

This project uses `--dart-define-from-file` for environment configuration, eliminating the need for external libraries.

### Configuration Structure

```
env/
├── development.json    # Development settings
├── staging.json       # Staging settings
├── production.json    # Production settings
└── local.example.json # Local development example
```

### Available Configurations

- **ENVIRONMENT**: Current environment (development/staging/production)
- **API_BASE_URL**: API base URL
- **API_KEY**: API key
- **DEBUG_MODE**: Enable debug mode
- **ANALYTICS_ENABLED**: Enable analytics
- **APP_NAME**: App name (can vary by environment)
- **CONNECTION_TIMEOUT**: Connection timeout (ms)
- **RECEIVE_TIMEOUT**: Receive timeout (ms)

### Usage in Code

```dart
import 'package:flutter_base_project/global/constants/app_config.dart';

// Check environment
if (AppConfig.isDevelopment) {
  print('Running in development');
}

// Use configurations
final apiUrl = AppConfig.apiBaseUrl;
final timeout = AppConfig.connectionTimeout;

// Debug - print all configurations
AppConfig.printConfig();
```

## 🔧 Global Services

### HTTP Client (AppHttp)

```dart
import 'package:flutter_base_project/global/network/app_http.dart';

final http = AppHttp();

// GET request
final response = await http.get('/users');

// POST request with data
final response = await http.post('/users', data: {
  'name': 'John Doe',
  'email': 'john@example.com',
});
```

### Local Storage (AppStorage)

```dart
import 'package:flutter_base_project/global/services/app_storage/app_storage.dart';
import 'package:flutter_base_project/global/services/app_storage/app_storage_keys.dart';

final storage = AppStorage.i;

// Store data
await storage.setString(AppStorageKeys.userToken, 'your_token');
await storage.setBool(AppStorageKeys.isFirstLaunch, false);

// Retrieve data
final token = storage.getString(AppStorageKeys.userToken);
final isFirstLaunch = storage.getBool(AppStorageKeys.isFirstLaunch);
```

### App Information (AppInfo)

```dart
import 'package:flutter_base_project/global/utils/app_info.dart';

// Get app information
final appName = AppInfo.appName;
final version = AppInfo.version;
final buildNumber = AppInfo.buildNumber;
final fullVersion = AppInfo.fullVersion; // "1.0.0+1"
```

### VS Code Launch Configurations

The project includes pre-configured launch configurations in `.vscode/launch.json`:

- **Development**: Debug mode with development settings
- **Staging**: Debug mode with staging settings  
- **Production**: Debug mode with production settings
- **Development (Profile)**: Profile mode for performance testing
- **Production (Release)**: Release mode for final testing

## 🎨 Design System

### Colors
- **Primary**: #6366F1 (Indigo)
- **Secondary**: #06B6D4 (Cyan)
- **Success**: #10B981 (Emerald)
- **Warning**: #F59E0B (Amber)
- **Error**: #EF4444 (Red)

### Spacing
- **Small**: 8px
- **Medium**: 16px
- **Large**: 24px
- **Extra Large**: 32px

### Border Radius
- **Small**: 4px
- **Medium**: 8px
- **Large**: 16px
- **Extra Large**: 24px

## 🔄 State Management

### ValueStore Pattern
```dart
// Custom ValueStore implementation
class HomeStore extends ValueStore<HomeImage> {
  final HomeUsecase _homeUsecase;
  
  HomeStore(this._homeUsecase) : super(const IdleState());

  Future<void> loadData() async {
    updateState(const LoadingState());
    final result = await _homeUsecase.loadHomeData();

    result.fold(
      (failure) => updateState(ErrorState<HomeImage>(failure)),
      (data) => updateState(SuccessState<HomeImage>(data)),
    );
  }
}
```

### UI Integration
```dart
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueStoreBuilder<HomeStore, HomeImage>(
      store: homeStore,
      builder: (context, state) {
        return state.when(
          idle: () => Text('Ready to load'),
          loading: () => CircularProgressIndicator(),
          success: (homeImage) => Image.network(homeImage.url),
          error: (error) => Text('Error: ${error.message}'),
        );
      },
    );
  }
}
```

### State Types
- **IdleState**: Initial state before any operations
- **LoadingState**: Operation in progress
- **SuccessState<T>**: Operation completed successfully with data
- **ErrorState**: Operation failed with error information

## ⚙️ Settings Management

### AppSettingsStore Usage
```dart
import 'package:flutter_base_project/global/settings/app_settings_store.dart';

final settingsStore = AppSettingsStore();

// Initialize settings
await settingsStore.initialize();

// Change theme mode
await settingsStore.setThemeMode(AppThemeMode.dark);

// Change locale
await settingsStore.setLocale(const Locale('pt', 'BR'));

// Listen to changes
ListenableBuilder(
  listenable: settingsStore,
  builder: (context, child) {
    return settingsStore.state.when(
      success: (settings) => YourWidget(settings: settings),
      // ... other states
    );
  },
);
```

## 🌍 Internationalization

### Adding New Translations

1. **Edit ARB files:**
```json
// lib/global/l10n/app_en.arb
{
  "newKey": "New text in English"
}

// lib/global/l10n/app_pt.arb
{
  "newKey": "Novo texto em português"
}
```

2. **Regenerate files:**
```bash
flutter gen-l10n
```

3. **Use in UI:**
```dart
Text(AppLocalizations.of(context)!.newKey)
```

## 🎨 Themes

### Customizing Colors
```dart
// lib/global/themes/app_theme.dart
class AppColors {
  static const Color primary = Color(0xFF6366F1);
  // Add your colors here
}
```

### Using Themes
```dart
// Primary color
color: Theme.of(context).colorScheme.primary

// Headline text
style: Theme.of(context).textTheme.headlineSmall
```

## 🚦 Navigation

### Defining Routes
```dart
// lib/global/router/route_paths.dart
class RoutePaths {
  static const String newPage = '/new-page';
}
```

### Navigating
```dart
// Go to a page
context.push(RoutePaths.newPage);

// Go back
context.pop();

// Replace
context.go(RoutePaths.home);
```

## 🧪 Testing Strategy

### Test Coverage
The project includes comprehensive testing for the Home feature:

```
test/
├── features/
│   └── home/
│       ├── domain/
│       │   └── usecases/          # Use case unit tests
│       ├── infrastructure/
│       │   └── repositories/      # Repository unit tests
│       ├── external/
│       │   └── datasources/       # Data source unit tests
│       └── presentation/
│           └── stores/            # Store unit tests
└── global/                        # Global module tests
```

### Running Tests
```bash
# Run all tests
flutter test

# Run specific feature tests
flutter test test/features/home/

# Run with coverage
flutter test --coverage
lcov --summary coverage/lcov.info
```

### Test Examples
```dart
// Store testing with mocked dependencies
void main() {
  group('HomeStore Tests', () {
    late HomeStore homeStore;
    late MockHomeUsecase mockUsecase;
    
    setUp(() {
      mockUsecase = MockHomeUsecase();
      homeStore = HomeStore(mockUsecase);
    });
    
    test('should update state to success when loadData succeeds', () async {
      // Arrange
      final homeImage = HomeImage(status: 'success', url: 'test-url');
      when(mockUsecase.loadHomeData())
          .thenAnswer((_) async => Right(homeImage));
      
      // Act
      await homeStore.loadData();
      
      // Assert
      expect(homeStore.state, isA<SuccessState<HomeImage>>());
    });
  });
}
```

## 📝 Creating a New Feature

Follow the Home feature as a reference for implementing new features:

### 1. Create Feature Structure
```bash
lib/features/new_feature/
├── domain/
│   ├── models/              # Domain entities
│   └── usecases/           # Business logic
├── infrastructure/
│   └── repositories/       # Data access layer
├── external/
│   ├── datasources/        # External API integration
│   └── settings/           # API endpoints
└── presentation/
    ├── stores/             # State management
    ├── pages/              # UI screens
    └── widgets/            # Feature widgets
```

### 2. Implement Domain Layer
```dart
// Domain Model
class FeatureModel {
  final String id;
  final String name;
  
  FeatureModel({required this.id, required this.name});
  
  factory FeatureModel.fromJson(Map<String, dynamic> json) {
    return FeatureModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

// Use Case
class FeatureUsecase {
  final FeatureRepository repository;
  FeatureUsecase(this.repository);
  
  Future<Either<AppGenericFailure, FeatureModel>> loadData() async {
    try {
      return await repository.loadData();
    } catch (error) {
      return Left(AppGenericFailure(
        message: 'Failed to load feature data', 
        error: error
      ));
    }
  }
}
```

### 3. Implement Infrastructure Layer
```dart
// Repository
class FeatureRepository {
  final FeatureDatasource datasource;
  FeatureRepository(this.datasource);
  
  Future<Either<AppGenericFailure, FeatureModel>> loadData() async {
    try {
      final rawData = await datasource.fetchData();
      final model = FeatureModel.fromJson(rawData);
      return Right(model);
    } on FormatException catch (e) {
      return Left(AppGenericFailure(
        message: 'Invalid data format', 
        error: e
      ));
    } catch (error) {
      return Left(AppGenericFailure(
        message: 'Repository error', 
        error: error
      ));
    }
  }
}
```

### 4. Implement External Layer
```dart
// Data Source
class FeatureDatasource {
  final AppHttp http;
  FeatureDatasource(this.http);
  
  Future<Map<String, dynamic>> fetchData() async {
    try {
      final response = await http.get('/api/feature-endpoint');
      if (response.data == null) {
        throw Exception('Empty response received');
      }
      return response.data;
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
```

### 5. Implement Presentation Layer
```dart
// Store
class FeatureStore extends ValueStore<FeatureModel> {
  final FeatureUsecase usecase;
  FeatureStore(this.usecase) : super(const IdleState());
  
  Future<void> loadData() async {
    updateState(const LoadingState());
    final result = await usecase.loadData();
    
    result.fold(
      (failure) => updateState(ErrorState<FeatureModel>(failure)),
      (data) => updateState(SuccessState<FeatureModel>(data)),
    );
  }
}

// Page
class FeaturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ValueStoreBuilder<FeatureStore, FeatureModel>(
      store: featureStore,
      builder: (context, state) {
        return state.when(
          idle: () => Text('Ready'),
          loading: () => CircularProgressIndicator(),
          success: (data) => Text('Data: ${data.name}'),
          error: (error) => Text('Error: ${error.message}'),
        );
      },
    );
  }
}
```

### 6. Add Routes
```dart
// Add to route_paths.dart
static const String newFeature = '/new-feature';

// Add to app_router.dart
GoRoute(
  path: RoutePaths.newFeature,
  builder: (context, state) => const FeaturePage(),
),
```

### 7. Register Dependencies
```dart
// Add to dependency injection setup
void setupFeatureDependencies() {
  final getIt = GetIt.instance;
  
  getIt.registerLazySingleton<FeatureDatasource>(
    () => FeatureDatasource(getIt<AppHttp>()),
  );
  
  getIt.registerLazySingleton<FeatureRepository>(
    () => FeatureRepository(getIt<FeatureDatasource>()),
  );
  
  getIt.registerLazySingleton<FeatureUsecase>(
    () => FeatureUsecase(getIt<FeatureRepository>()),
  );
  
  getIt.registerLazySingleton<FeatureStore>(
    () => FeatureStore(getIt<FeatureUsecase>()),
  );
}
```

## 🤝 Contributing

1. Fork the project
2. Create your feature branch (`git checkout -b feature/MyFeature`)
3. Commit your changes (`git commit -m 'Add MyFeature'`)
4. Push to the branch (`git push origin feature/MyFeature`)
5. Open a Pull Request

## 📄 License

This project is under the MIT license. See the [LICENSE](LICENSE) file for more details.

## 🙋‍♂️ Support

If you encounter any problems or have questions:

1. Check the [existing Issues](https://github.com/your-user/flutter_base_project/issues)
2. Create a new Issue if necessary
3. Consult the Flutter documentation

---

**Developed by <a href="https://github.com/oiesc">Emanoel Aleixo</a> with ❤️ using Flutter**
