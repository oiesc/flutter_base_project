import 'package:flutter/widgets.dart';

/// Environment configuration using --dart-define
class AppConfig {
  // Private constructor
  AppConfig._();

  /// Environment type
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'development',
  );

  /// API Base URL
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api-dev.example.com',
  );

  /// API Key
  static const String apiKey = String.fromEnvironment(
    'API_KEY',
    defaultValue: 'dev_api_key',
  );

  /// Debug mode flag
  static const bool debugMode = bool.fromEnvironment(
    'DEBUG_MODE',
    defaultValue: true,
  );

  /// Analytics enabled flag
  static const bool analyticsEnabled = bool.fromEnvironment(
    'ANALYTICS_ENABLED',
  );

  /// App name override
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Flutter Base Project',
  );

  /// Connection timeout in milliseconds
  static const int connectionTimeout = int.fromEnvironment(
    'CONNECTION_TIMEOUT',
    defaultValue: 30000,
  );

  /// Receive timeout in milliseconds
  static const int receiveTimeout = int.fromEnvironment(
    'RECEIVE_TIMEOUT',
    defaultValue: 30000,
  );

  // Convenience getters
  /// Check if running in development
  static bool get isDevelopment => environment == 'development';

  /// Check if running in staging
  static bool get isStaging => environment == 'staging';

  /// Check if running in production
  static bool get isProduction => environment == 'production';

  /// Get all config as a map for debugging
  static Map<String, dynamic> get all => {
    'environment': environment,
    'apiBaseUrl': apiBaseUrl,
    'apiKey': apiKey.replaceRange(4, null, '*' * (apiKey.length - 4)),
    'debugMode': debugMode,
    'analyticsEnabled': analyticsEnabled,
    'appName': appName,
    'connectionTimeout': connectionTimeout,
    'receiveTimeout': receiveTimeout,
  };

  /// Print all configuration (for debugging)
  static void printConfig() {
    debugPrint('=== App Configuration ===');
    all.forEach((key, value) {
      debugPrint('$key: $value');
    });
    debugPrint('========================');
  }
}
