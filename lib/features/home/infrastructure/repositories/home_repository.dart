import '../../../../global/app_core/domain/models/either.dart';
import '../../../../global/app_core/failures/app_failure.dart';
import '../../../../global/utils/app_utils.dart';
import '../../domain/models/home_image.dart';
import '../../external/datasources/home_datasource.dart';

/// **Home Repository**
/// 
/// This repository implements the data access layer for the Home feature.
/// It serves as an abstraction between the domain layer and external data sources,
/// handling data transformation, caching strategies, and error management.
/// 
/// **Responsibilities:**
/// - Coordinate data retrieval from multiple data sources
/// - Transform raw data into domain models
/// - Handle data source-specific errors and convert them to domain failures
/// - Implement caching and data persistence strategies
/// - Ensure data consistency across different sources
/// 
/// **Usage Example:**
/// ```dart
/// final homeRepository = HomeRepository(homeDatasource);
/// final result = await homeRepository.loadHomeData();
/// 
/// result.fold(
///   (failure) => handleError(failure),
///   (homeImage) => displayImage(homeImage),
/// );
/// ```
/// 
/// **Design Pattern:** Repository Pattern
/// **Layer:** Infrastructure Layer
class HomeRepository {
  final HomeDatasource _homeDatasource;

  HomeRepository(this._homeDatasource);

  /// Loads home data by fetching and transforming external data
  /// 
  /// This method:
  /// 1. Fetches raw data from the datasource
  /// 2. Transforms it into a domain model ([HomeImage])
  /// 3. Handles various error scenarios with proper logging
  /// 
  /// Returns an [Either] containing:
  /// - [Left]: [AppGenericFailure] if parsing or network operation fails
  /// - [Right]: [HomeImage] if the operation succeeds
  /// 
  /// **Error Handling:**
  /// - [FormatException]: When JSON parsing fails
  /// - [Exception]: For any other unexpected errors
  Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
    try {
      final response = await _homeDatasource.getHomeImage();
      return Right(HomeImage.fromJson(response));
    } on FormatException catch (e) {
      final String errorMessage = 'Failed to parse home image data';
      AppLogger.error(errorMessage, e);
      return Left(AppGenericFailure(message: errorMessage, error: e));
    } on Exception catch (e) {
      final String errorMessage = 'Failed to load home data';
      AppLogger.error(errorMessage, e);
      return Left(AppGenericFailure(message: errorMessage, error: e));
    }
  }
}
