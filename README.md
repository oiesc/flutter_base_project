# Flutter Base Project

A Flutter base project built with **Clean Architecture**, **MVVM**, and **custom state management**. This project serves as a template for future Flutter projects, providing a scalable and well-organized structure.

## 🏗️ Architecture

This project implements an architecture based on Clean Architecture with MVVM, organized by features, ensuring:

- **Separation of responsibilities**
- **Testability**
- **Scalability**
- **Maintainability**
- **Code reusability**

### 📁 Folder Structure

```
lib/
├── app/                          # Main application configuration
│   └── app.dart                  # Main app widget
├── features/                     # Feature modules
│   └── home/                     # Example feature (Home)
│       ├── domain/               # Domain layer
│       │   ├── enums/           # Enumerations
│       │   ├── failures/        # Failure classes
│       │   ├── models/          # Domain models
│       │   └── usecases/        # Use cases
│       ├── infrastructure/       # Infrastructure layer
│       │   ├── repositories/    # Repository implementations
│       │   └── settings/        # Specific configurations
│       ├── utils/               # Feature utilities
│       └── presentation/        # Presentation layer
│           ├── stores/          # State management stores
│           ├── components/      # Reusable components
│           ├── pages/           # Feature pages
│           ├── mixins/          # Reusable mixins
│           └── widgets/         # Specific widgets
└── global/                      # Shared modules
    ├── app_core/               # Application core
    │   ├── failures/           # Global failure classes
    │   └── store/              # State management system
    ├── constants/              # Global constants
    ├── l10n/                   # Internationalization
    ├── themes/                 # Application themes
    ├── router/                 # Route configuration
    ├── utils/                  # Global utilities
    └── pages/                  # Global pages
```

## 🎯 Key Features

### ✅ Custom State Management
- **BaseStore**: Base class for stores with state pattern
- **AppState**: Standardized states (Idle, Loading, Success, Error)
- **Reactive UI**: Reactive interface based on ChangeNotifier

### ✅ Internationalization (i18n)
- Support for multiple languages (EN/PT)
- Automatic translation code generation
- Flexible configuration via l10n.yaml

### ✅ Theme System
- Light and dark themes
- Automatic mode based on system
- Persistent configuration
- Consistent design system

### ✅ Navigation
- **GoRouter** for declarative navigation
- Typed and organized routes
- 404 error handling

### ✅ Environment Configuration
- Configuration using --dart-define-from-file (no external dependencies)
- Multiple environments (Development, Staging, Production)
- VS Code launch configurations for each environment
- Type-safe and compile-time checked configuration

### ✅ Clean Architecture
- Clean Architecture by features
- Dependency inversion
- Native testability

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.8.1+
- Dart 3.0+
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
- **Pages**: Application screens
- **Widgets**: Visual components
- **Stores**: State managers (MVVM ViewModels)
- **Components**: Reusable components

### 🎯 Domain Layer
- **Models**: Domain entities
- **UseCases**: Business rules
- **Enums**: Enumerations
- **Failures**: Error handling

### 🔧 Infrastructure Layer
- **Repositories**: Data access implementations
- **Settings**: Feature-specific settings
- **Data Sources**: Data sources (API, Local, etc.)

## 📦 Main Dependencies

```yaml
dependencies:
  flutter_localizations: # Internationalization
  intl: ^0.20.2          # Date/number formatting
  go_router: ^14.6.2     # Navigation
  get_it: ^8.0.2         # Dependency injection
  shared_preferences: ^2.3.3  # Local persistence
  dio: ^5.7.0            # HTTP client
  logger: ^2.5.0         # Logging
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

### BaseStore
```dart
class ExampleStore extends BaseStore<ExampleData> {
  Future<void> loadData() async {
    await execute(() async {
      // Your logic here
      return await repository.getData();
    });
  }
}
```

### UI Usage
```dart
class ExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: exampleStore,
      builder: (context, child) {
        return exampleStore.state.when(
          idle: () => Text('Idle'),
          loading: () => CircularProgressIndicator(),
          success: (data) => Text('Data: $data'),
          error: (error) => Text('Error: ${error.message}'),
        );
      },
    );
  }
}
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

## 🧪 Testing

### Test Structure
```
test/
├── app/                    # Main app tests
├── features/               # Feature tests
│   └── home/
│       ├── domain/
│       ├── infrastructure/
│       └── presentation/
└── global/                 # Global module tests
```

### Running Tests
```bash
# All tests
flutter test

# Specific tests
flutter test test/features/home/
```

## 📝 Creating a New Feature

1. **Create folder structure:**
```bash
lib/features/new_feature/
├── domain/
├── infrastructure/
├── utils/
└── presentation/
```

2. **Implement layers:**
   - Domain: Models, UseCases, Failures
   - Infrastructure: Repositories, Settings
   - Presentation: Pages, Stores, Widgets

3. **Add routes:**
```dart
// route_paths.dart
static const String newFeature = '/new-feature';

// app_router.dart
GoRoute(
  path: RoutePaths.newFeature,
  builder: (context, state) => const NewFeaturePage(),
),
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

**Developed with ❤️ using Flutter**
