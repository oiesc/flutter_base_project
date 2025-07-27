import '../../../../global/app_core/domain/models/either.dart';
import '../../../../global/app_core/failures/app_failure.dart';
import '../../infrastructure/repositories/home_repository.dart';
import '../models/home_image.dart';

/// **Home Use Case**
///
/// This use case orchestrates business logic for the Home feature.
/// It acts as an intermediary between the presentation layer and the repository,
/// implementing domain-specific business rules and validations.
///
/// **Responsibilities:**
/// - Encapsulate business logic for home-related operations
/// - Coordinate data flow between presentation and infrastructure layers
/// - Handle business-specific error scenarios
/// - Ensure data integrity and validation
///
/// **Usage Example:**
/// ```dart
/// final homeUsecase = HomeUsecase(homeRepository);
/// final result = await homeUsecase.loadHomeData();
///
/// result.fold(
///   (failure) => print('Error: ${failure.message}'),
///   (homeImage) => print('Success: ${homeImage.url}'),
/// );
/// ```
///
/// **Design Pattern:** Clean Architecture Use Case
/// **Layer:** Domain Layer
class HomeUsecase {
  final HomeRepository homeRepository;

  HomeUsecase(this.homeRepository);

  /// Loads home data by fetching a random dog image
  ///
  /// Returns an [Either] containing:
  /// - [Left]: [AppGenericFailure] if the operation fails
  /// - [Right]: [HomeImage] if the operation succeeds
  ///
  /// This method handles any unexpected errors that might occur
  /// during the repository call and wraps them in a generic failure.
  Future<Either<AppGenericFailure, HomeImage>> loadHomeData() async {
    try {
      final data = await homeRepository.loadHomeData();

      // Use fold to handle the Either result
      return data.fold(
        (failure) => Left(failure), // Return the original failure
        (homeImage) {
          // Validate the home image data
          if (homeImage.url.isEmpty) {
            return Left(AppGenericFailure(message: 'Received empty image URL'));
          }
          return Right(homeImage); // Return success with valid data
        },
      );
    } catch (error) {
      return Left(AppGenericFailure(message: 'Failed to load home data', error: error));
    }
  }
}
