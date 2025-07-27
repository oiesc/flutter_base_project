import 'dart:io';

import 'package:dio/dio.dart';

import '../constants/app_config.dart';

class AppHttp {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: Duration(milliseconds: AppConfig.connectionTimeout),
      receiveTimeout: Duration(milliseconds: AppConfig.receiveTimeout),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    ),
  );

  void _configBaseUrl(bool useBaseUrl) {
    if (useBaseUrl) {
      _dio.options.baseUrl = AppConfig.apiBaseUrl;
    }
  }

  /// Performs a POST request
  ///
  /// @param path The endpoint path
  ///
  /// @param useBaseUrl Whether to use the base URL from AppConfig, set false to use a full URL
  ///
  /// @param data The request body data
  ///
  /// @param queryParameters Optional query parameters
  ///
  /// @param options Additional request options
  ///
  /// @param cancelToken Optional cancel token to cancel the request
  ///
  /// @param onSendProgress Optional callback for upload progress
  ///
  /// @param onReceiveProgress Optional callback for download progress
  Future<Response<T>> post<T>(
    String path, {
    bool useBaseUrl = true,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    _configBaseUrl(useBaseUrl);
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a POST request
  ///
  /// @param path The endpoint path
  ///
  /// @param useBaseUrl Whether to use the base URL from AppConfig, set false to use a full URL
  ///
  /// @param data The request body data
  ///
  /// @param queryParameters Optional query parameters
  ///
  /// @param options Additional request options
  ///
  /// @param cancelToken Optional cancel token to cancel the request
  ///
  /// @param onReceiveProgress Optional callback for download progress
  Future<Response<T>> get<T>(
    String path, {
    bool useBaseUrl = true,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    _configBaseUrl(useBaseUrl);
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a POST request
  ///
  /// @param path The endpoint path
  ///
  /// @param useBaseUrl Whether to use the base URL from AppConfig, set false to use a full URL
  ///
  /// @param data The request body data
  ///
  /// @param queryParameters Optional query parameters
  ///
  /// @param options Additional request options
  ///
  /// @param cancelToken Optional cancel token to cancel the request
  ///
  /// @param onSendProgress Optional callback for upload progress
  ///
  /// @param onReceiveProgress Optional callback for download progress
  Future<Response<T>> put<T>(
    String path, {
    bool useBaseUrl = true,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    _configBaseUrl(useBaseUrl);
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Performs a POST request
  ///
  /// @param path The endpoint path
  ///
  /// @param useBaseUrl Whether to use the base URL from AppConfig, set false to use a full URL
  ///
  /// @param data The request body data
  ///
  /// @param queryParameters Optional query parameters
  ///
  /// @param options Additional request options
  ///
  /// @param cancelToken Optional cancel token to cancel the request
  Future<Response<T>> delete<T>(
    String path, {
    bool useBaseUrl = true,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) {
    _configBaseUrl(useBaseUrl);
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
