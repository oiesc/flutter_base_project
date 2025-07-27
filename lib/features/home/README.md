# Home Feature Documentation

This document provides comprehensive guidance on the Home feature implementation, following Clean Architecture principles with complete separation of concerns across different layers. The Home feature serves as a **reference implementation** for building new features in this project.

## 🏗️ Architecture Overview

The Home feature demonstrates a complete Clean Architecture implementation with four distinct layers:

```
📁 home/
├── 📁 domain/                # Business Logic Layer
│   ├── 📁 models/           # Domain entities (HomeImage)
│   └── 📁 usecases/         # Business use cases (HomeUsecase)
├── 📁 infrastructure/       # Data Access Layer
│   └── 📁 repositories/     # Data repositories (HomeRepository)
├── 📁 external/             # External Data Layer
│   ├── 📁 datasources/      # External API sources (HomeDatasource)
│   └── 📁 settings/         # API configuration (HomeEndpoints)
└── 📁 presentation/         # Presentation Layer
    ├── 📁 stores/           # State management (HomeStore)
    ├── 📁 pages/            # UI pages
    └── 📁 widgets/          # UI components
```

## 🎯 Feature Overview

The Home feature provides:
- **Random Dog Image Display**: Fetches and displays random dog images from Dog CEO API
- **Real API Integration**: Demonstrates external API consumption
- **Complete Error Handling**: Proper error management across all layers
- **Reactive State Management**: Custom ValueStore implementation
- **Loading States**: Proper loading and error state management
- **Clean Architecture**: Textbook implementation of Clean Architecture principles

## 🔧 Core Components

### 1. HomeStore (Presentation Layer)

**Purpose:** Manages UI state and coordinates business logic execution through use cases.

**Implementation:**
```dart
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

**Key Features:**
- Extends `ValueStore<HomeImage>` for reactive state management
- Handles loading, success, and error states automatically
- Provides clean interface between UI and business logic
- Uses Either pattern for functional error handling

**UI Integration:**
```dart
ValueStoreBuilder<HomeStore, HomeImage>(
  store: homeStore,
  builder: (context, state) {
    return state.when(
      idle: () => Text('Ready to load'),
      loading: () => CircularProgressIndicator(),
      success: (homeImage) => Image.network(homeImage.url),
      error: (failure) => Text('Error: ${failure.message}'),
    );
  },
)
```

### 2. HomeUsecase (Domain Layer)

**Purpose:** Orchestrates business logic for home-related operations, implementing domain rules.

**Implementation:**
```dart
class HomeUsecase {
  final HomeRepository homeRepository;
  HomeUsecase(this.homeRepository);

  Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
    try {
      final data = await homeRepository.loadHomeData();
      data.fold((failure) => failure, (homeImage) {
        if (homeImage.url.isEmpty) {
          return Left(AppGenericFailure(message: 'Received empty image URL'));
        }
        return Right(homeImage);
      });
      return data;
    } catch (error) {
      return Left(AppGenericFailure(
        message: 'Failed to load home data', 
        error: error
      ));
    }
  }
}
```

**Key Features:**
- Implements business logic validation (empty URL check)
- Handles unexpected errors from repository layer
- Returns Either<Failure, Success> for functional error handling
- No external dependencies - pure business logic

### 3. HomeRepository (Infrastructure Layer)

**Purpose:** Abstracts data access and transforms external data into domain models.

**Key Features:**
- Coordinates data retrieval from external data sources
- Transforms raw JSON data into domain models (HomeImage)
- Handles data source-specific errors (FormatException, network errors)
- Provides logging for debugging and monitoring

**Error Handling:**
- FormatException: When JSON parsing fails
- Network errors: When API calls fail
- Validation errors: When data doesn't meet expectations

### 4. HomeDatasource (External Layer)

**Purpose:** Handles direct communication with external APIs and services.

**Key Features:**
- Makes HTTP requests to Dog CEO API
- Validates response format and structure
- Handles network-specific errors (timeouts, connectivity)
- Logs network operations for debugging

**API Integration:**
- **Endpoint**: `https://dog.ceo/api/breeds/image/random`
- **Method**: GET
- **Response**: JSON with status and message (image URL)
- **Error Handling**: Network timeouts, invalid responses, API errors

### 5. HomeImage (Domain Model)

**Purpose:** Represents the core business entity for dog images.

**Implementation:**
```dart
class HomeImage {
  final String status;
  final String url;

  HomeImage({required this.status, required this.url});

  factory HomeImage.fromJson(Map<String, dynamic> json) {
    return HomeImage(
      status: json['status']?.toString() ?? 'unknown',
      url: json['message']?.toString() ?? '',
    );
  }
}
```

**Key Features:**
- Pure domain model with no external dependencies
- Factory constructor for JSON transformation
- Null-safe field handling with default values
- Immutable data structure

### 3. HomeRepository (Infrastructure Layer)

**Purpose:** Manages data access and transformation between external sources and domain models.

**Key Features:**
- Abstracts data source complexity from domain layer
- Transforms raw data into domain models
- Handles data validation and error conversion
- Can implement caching strategies

**Usage Example:**
```dart
// Direct repository usage (typically used by use cases)
final homeRepository = HomeRepository(homeDatasource);
final result = await homeRepository.loadHomeData();

result.fold(
  (failure) => {
    // Handle data access errors
    if (failure.message.contains('parse')) {
      print('Data format error');
    } else {
      print('Network or service error');
    }
  },
  (homeImage) => {
    // Use the domain model
    displayImage(homeImage.url);
  },
);
```

### 4. HomeDatasource (External Layer)

**Purpose:** Handles direct communication with external APIs and data sources.

**Key Features:**
- Executes HTTP requests
- Validates response structure
- Handles network-specific errors
- Provides logging for network operations

**Usage Example:**
```dart
// Direct datasource usage (typically used by repositories)
final homeDatasource = HomeDatasource(appHttp);

try {
  final Map<String, dynamic> rawData = await homeDatasource.getHomeImage();
  print('Raw API response: $rawData');
} catch (e) {
  print('Network error occurred: $e');
}
```

## 🔄 Data Flow

The data flows through the layers following Clean Architecture principles:

```
📱 Presentation Layer (UI/Store)
        ↓ (User interaction)
🎯 Domain Layer (UseCase)
        ↓ (Business logic)
🔧 Infrastructure Layer (Repository)
        ↓ (Data transformation)
🌐 External Layer (DataSource)
        ↓ (HTTP request)
🔗 External API (Dog CEO API)
```

### Step-by-Step Flow:

1. **User Interaction**: User taps refresh or page loads
2. **Store Action**: `HomeStore.loadData()` is called
3. **State Update**: Store updates to `LoadingState`
4. **UseCase Execution**: Store calls `HomeUsecase.loadHomeData()`
5. **Business Logic**: UseCase validates and processes the request
6. **Repository Call**: UseCase calls `HomeRepository.loadHomeData()`
7. **Data Source**: Repository calls `HomeDatasource.getHomeImage()`
8. **API Request**: DataSource makes HTTP GET to Dog CEO API
9. **Response Processing**: Raw JSON is transformed to HomeImage
10. **Result Propagation**: Either<Failure, HomeImage> flows back up
11. **State Update**: Store updates to `SuccessState` or `ErrorState`
12. **UI Update**: UI automatically rebuilds based on new state

## ⚠️ Error Handling Strategy

Each layer handles specific types of errors following the principle of handling errors at the appropriate level:

### 🎯 Domain Layer (UseCase)
**Handles:**
- Business logic validation errors (empty URL validation)
- Unexpected runtime errors from lower layers
- Domain rule violations

**Implementation:**
```dart
Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
  try {
    final data = await homeRepository.loadHomeData();
    // Business validation
    data.fold((failure) => failure, (homeImage) {
      if (homeImage.url.isEmpty) {
        return Left(AppGenericFailure(message: 'Received empty image URL'));
      }
      return Right(homeImage);
    });
    return data;
  } catch (error) {
    return Left(AppGenericFailure(message: 'Failed to load home data', error: error));
  }
}
```

### 🔧 Infrastructure Layer (Repository)
**Handles:**
- Data transformation errors (`FormatException`)
- Data validation errors
- Service integration errors

**Error Types:**
- JSON parsing failures
- Data format inconsistencies
- Model transformation errors

### 🌐 External Layer (DataSource)
**Handles:**
- Network connectivity issues (`DioException`)
- API response validation
- HTTP status code errors
- Request timeout errors

**Error Types:**
- Connection timeouts
- Server errors (4xx, 5xx)
- Network unavailability
- Invalid response format

### 📱 Presentation Layer (Store)
**Handles:**
- UI state transitions (idle → loading → success/error)
- User interaction errors
- Store state validation

**State Management:**
```dart
Future<void> loadData() async {
  updateState(const LoadingState());  // Loading state
  final result = await _homeUsecase.loadHomeData();

  result.fold(
    (failure) => updateState(ErrorState<HomeImage>(failure)),    // Error state
    (data) => updateState(SuccessState<HomeImage>(data)),        // Success state
  );
}
```

## Integration Examples

### Complete Integration Setup

```dart
// 1. Initialize dependencies
final appHttp = AppHttp(); // Your HTTP client
final homeDatasource = HomeDatasource(appHttp);
final homeRepository = HomeRepository(homeDatasource);
final homeUsecase = HomeUsecase(homeRepository);
final homeStore = HomeStore(homeUsecase);

// 2. Use in a widget with mixin
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomePageMixin {
  late final HomeStore homeStore;
  
  @override
  void initState() {
    super.initState();
    homeStore = GetIt.instance<HomeStore>();
    // Load data when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeStore.loadData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<StoreState<HomeImage>>(
        valueListenable: homeStore,
        builder: (context, state, _) {
          return state.when(
            idle: () => Center(child: Text('Tap to load image')),
            loading: () => Center(child: CircularProgressIndicator()),
            success: (homeImage) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(homeImage.url),
                  Text('Status: ${homeImage.status}'),
                ],
              ),
            ),
            error: (failure) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${failure.message}'),
                  ElevatedButton(
                    onPressed: () => homeStore.loadData(),
                    child: Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeStore.loadData(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
```

### Dependency Injection with GetIt

```dart
// Register dependencies
void setupHomeDependencies() {
  final getIt = GetIt.instance;
  
  // Register datasource
  getIt.registerLazySingleton<HomeDatasource>(
    () => HomeDatasource(getIt<AppHttp>()),
  );
  
  // Register repository
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(getIt<HomeDatasource>()),
  );
  
  // Register use case
  getIt.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(getIt<HomeRepository>()),
  );
  
  // Register store
  getIt.registerLazySingleton<HomeStore>(
    () => HomeStore(getIt<HomeUsecase>()),
  );
}

// Using in mixin
mixin HomePageMixin<T extends StatefulWidget> on State<T> {
  late final HomeStore homeStore;
  
  @override
  void initState() {
    super.initState();
    homeStore = GetIt.instance<HomeStore>();
    // Automatically load data when mixin is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      homeStore.loadData();
    });
  }
  
  @override
  void dispose() {
    // Clean up if needed
    super.dispose();
  }
}
```

## 🧪 Testing Implementation

The Home feature includes comprehensive unit tests demonstrating testing best practices:

### Test Structure
```
test/features/home/
└── presentation/
    └── stores/
        └── home_store_test.dart
```

### Store Testing Example
```dart
void main() {
  group('HomeStore', () {
    late HomeStore homeStore;

    setUp(() {
      homeStore = HomeStore();
    });

    tearDown(() {
      homeStore.dispose();
    });

    test('initial state should be idle', () {
      expect(homeStore.state, isA<IdleState>());
    });

    test('loadHomeData should update state to success', () async {
      // Act
      await homeStore.loadHomeData();

      // Assert
      expect(homeStore.state, isA<SuccessState<HomeData>>());
      
      final successState = homeStore.state as SuccessState<HomeData>;
      expect(successState.data.title, 'Welcome to Flutter Base Project');
      expect(successState.data.isActive, true);
    });
  });
}
```

### Testing Best Practices Demonstrated:

1. **Proper Setup/Teardown**: Initialize and dispose of stores
2. **State Verification**: Test all state transitions
3. **Isolated Testing**: Each layer tested independently
4. **Mock Dependencies**: Use mocked dependencies for unit tests
5. **Comprehensive Coverage**: Test success and failure scenarios

### Running Tests
```bash
# Run all home feature tests
flutter test test/features/home/

# Run specific test file
flutter test test/features/home/presentation/stores/home_store_test.dart

# Run with coverage
flutter test --coverage test/features/home/
```

## 🛠️ Implementation Best Practices

### 1. Dependency Injection
The Home feature demonstrates proper dependency injection patterns:

```dart
// Typical dependency setup (usually in main.dart or dependency injection file)
void setupHomeDependencies() {
  final getIt = GetIt.instance;
  
  // Register from external to presentation layers
  getIt.registerLazySingleton<HomeDatasource>(
    () => HomeDatasource(getIt<AppHttp>()),
  );
  
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepository(getIt<HomeDatasource>()),
  );
  
  getIt.registerLazySingleton<HomeUsecase>(
    () => HomeUsecase(getIt<HomeRepository>()),
  );
  
  getIt.registerLazySingleton<HomeStore>(
    () => HomeStore(getIt<HomeUsecase>()),
  );
}
```

### 2. Error Handling Patterns
```dart
// Either pattern for functional error handling
Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
  try {
    final data = await homeRepository.loadHomeData();
    // Business validation before returning
    return data.fold(
      (failure) => Left(failure),
      (homeImage) {
        if (homeImage.url.isEmpty) {
          return Left(AppGenericFailure(message: 'Empty URL received'));
        }
        return Right(homeImage);
      },
    );
  } catch (error) {
    return Left(AppGenericFailure(message: 'Unexpected error', error: error));
  }
}
```

### 3. State Management Patterns
```dart
// Reactive state management with ValueStore
class HomeStore extends ValueStore<HomeImage> {
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

### 4. API Integration Patterns
```dart
// Clean API integration with proper error handling
Future<Map<String, dynamic>> getHomeImage() async {
  try {
    final response = await _appHttp.get(HomeEndpoints.randomDogImage);
    
    if (response.data == null) {
      throw Exception('Empty response received from API');
    }
    
    return response.data;
  } on DioException catch (e) {
    throw Exception('Network error: ${e.message}');
  } catch (e) {
    throw Exception('Unexpected error during API call: $e');
  }
}
```

## 🔧 Configuration

### API Endpoints
```dart
// external/settings/home_endpoints.dart
class HomeEndpoints {
  static const String randomDogImage = 'https://dog.ceo/api/breeds/image/random';
}
```

### Environment Configuration
The Dog CEO API doesn't require API keys, but for APIs that do:

```json
// env/development.json
{
  "DOG_API_BASE_URL": "https://dog.ceo/api",
  "API_TIMEOUT": "30000"
}
```

## 📋 Common Patterns Demonstrated

### 1. Model Transformation
```dart
factory HomeImage.fromJson(Map<String, dynamic> json) {
  return HomeImage(
    status: json['status']?.toString() ?? 'unknown',
    url: json['message']?.toString() ?? '',
  );
}
```

### 2. Repository Pattern
```dart
class HomeRepository {
  final HomeDatasource _homeDatasource;
  HomeRepository(this._homeDatasource);

  Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
    try {
      final rawData = await _homeDatasource.getHomeImage();
      final homeImage = HomeImage.fromJson(rawData);
      return Right(homeImage);
    } on FormatException catch (e) {
      return Left(AppGenericFailure(message: 'Invalid data format', error: e));
    } catch (error) {
      return Left(AppGenericFailure(message: 'Repository error', error: error));
    }
  }
}
```

### 3. UseCase Pattern
```dart
class HomeUsecase {
  final HomeRepository homeRepository;
  HomeUsecase(this.homeRepository);

  Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
    // Business logic goes here
    return await homeRepository.loadHomeData();
  }
}
```

## 🎯 Key Takeaways

1. **Layer Separation**: Each layer has a clear, single responsibility
2. **Error Handling**: Errors are handled at the appropriate layer
3. **State Management**: Reactive state updates with proper loading states
4. **Testing**: Comprehensive unit testing for all components
5. **Dependency Injection**: Proper IoC container usage
6. **API Integration**: Clean external service integration
7. **Business Logic**: Domain rules are enforced in the UseCase layer
8. **Data Transformation**: Raw data is properly transformed to domain models

This Home feature serves as a **reference implementation** for all future features in the project. Follow the same patterns and structure when implementing new features to maintain consistency and quality across the codebase.
