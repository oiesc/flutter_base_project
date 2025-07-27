import 'package:dio/dio.dart';

import '../../../../global/network/app_http.dart';
import '../../../../global/utils/app_utils.dart';
import '../settings/home_endpoints.dart';

/// **Home Datasource**
/// 
/// This datasource handles direct communication with external APIs and data sources
/// for the Home feature. It's responsible for making HTTP requests, handling
/// network-specific errors, and returning raw data to the repository layer.
/// 
/// **Responsibilities:**
/// - Execute HTTP requests to external APIs
/// - Handle network-specific errors (timeouts, connectivity issues, etc.)
/// - Validate response format and structure
/// - Log network operations for debugging and monitoring
/// - Convert network errors into application-specific exceptions
/// 
/// **Usage Example:**
/// ```dart
/// final homeDatasource = HomeDatasource(appHttp);
/// try {
///   final Map<String, dynamic> data = await homeDatasource.getHomeImage();
///   print('Received data: $data');
/// } catch (e) {
///   print('Network error: $e');
/// }
/// ```
/// 
/// **Design Pattern:** Data Source Pattern
/// **Layer:** External/Infrastructure Layer
class HomeDatasource {
  final AppHttp _appHttp;

  HomeDatasource(this._appHttp);

  /// Fetches a random dog image from an external API
  /// 
  /// This method:
  /// 1. Makes an HTTP GET request to the dog API
  /// 2. Validates the response structure
  /// 3. Returns raw JSON data for further processing
  /// 
  /// Returns a [Map<String, dynamic>] containing the API response
  /// 
  /// **Throws:**
  /// - [Exception] with descriptive message for various error scenarios:
  ///   - Network connectivity issues
  ///   - Invalid response format
  ///   - Null response data
  ///   - API-specific errors
  /// 
  /// **Error Handling:**
  /// - [DioException]: Network-related errors (timeouts, no internet, etc.)
  /// - [Exception]: General errors for null or invalid response format
  Future<Map<String, dynamic>> getHomeImage() async {
    try {
      final response = await _appHttp.get(
        HomeEndpoints.homeImage,
        useBaseUrl: false,
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      if (response.data is! Map<String, dynamic>) {
        throw Exception('Invalid response format');
      }

      return response.data;
    } on DioException catch (e) {
      /// Handle Dio-specific errors here
      /// 
      /// Common DioException types:
      /// - DioExceptionType.connectionTimeout: Connection timeout
      /// - DioExceptionType.receiveTimeout: Receive timeout
      /// - DioExceptionType.badResponse: HTTP error status codes
      /// - DioExceptionType.connectionError: No internet connection
      final String errorMessage = 'Failed to fetch home image';
      AppLogger.error(errorMessage, e);
      throw Exception(errorMessage);
    } catch (e) {
      final String errorMessage = 'An unexpected error occurred while fetching home image';
      AppLogger.error(errorMessage, e);
      throw Exception('$errorMessage: $e');
    }
  }
}
