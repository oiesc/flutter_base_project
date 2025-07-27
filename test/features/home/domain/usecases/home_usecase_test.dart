import 'package:flutter_base_project/features/home/domain/models/home_image.dart';
import 'package:flutter_base_project/features/home/domain/usecases/home_usecase.dart';
import 'package:flutter_base_project/features/home/infrastructure/repositories/home_repository.dart';
import 'package:flutter_base_project/global/app_core/domain/models/either.dart';
import 'package:flutter_base_project/global/app_core/failures/app_failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_usecase_test.mocks.dart';

// Generate mock classes
@GenerateMocks([HomeRepository])
void main() {
  // Provide dummy values for Mockito
  setUpAll(() {
    provideDummy<Either<AppGenericFailure, HomeImage>>(
      Left(AppGenericFailure(message: 'Dummy failure')),
    );
  });

  group('HomeUsecase', () {
    late HomeUsecase homeUsecase;
    late MockHomeRepository mockHomeRepository;

    setUp(() {
      mockHomeRepository = MockHomeRepository();
      homeUsecase = HomeUsecase(mockHomeRepository);
    });

    group('loadHomeData', () {
      test('should return Right when repository returns valid data', () async {
        // Arrange
        final expectedHomeImage = HomeImage(
          status: 'success',
          url: 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg',
        );
        
        when(mockHomeRepository.loadHomeData())
            .thenAnswer((_) async => Right(expectedHomeImage));

        // Act
        final result = await homeUsecase.loadHomeData();

        // Assert
        result.fold(
          (failure) => fail('Expected success but got failure: ${failure.message}'),
          (homeImage) {
            expect(homeImage.status, 'success');
            expect(homeImage.url, 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg');
          },
        );
        verify(mockHomeRepository.loadHomeData()).called(1);
      });

      test('should return Left when repository returns failure', () async {
        // Arrange
        final expectedFailure = AppGenericFailure(message: 'Network error');
        
        when(mockHomeRepository.loadHomeData())
            .thenAnswer((_) async => Left(expectedFailure));

        // Act
        final result = await homeUsecase.loadHomeData();

        // Assert
        result.fold(
          (failure) => expect(failure.message, 'Network error'),
          (homeImage) => fail('Expected failure but got success'),
        );
        verify(mockHomeRepository.loadHomeData()).called(1);
      });

      test('should return Left when repository returns HomeImage with empty URL', () async {
        // Arrange
        final homeImageWithEmptyUrl = HomeImage(
          status: 'success',
          url: '', // Empty URL should trigger validation error
        );
        
        when(mockHomeRepository.loadHomeData())
            .thenAnswer((_) async => Right(homeImageWithEmptyUrl));

        // Act
        final result = await homeUsecase.loadHomeData();

        // Assert
        result.fold(
          (failure) => expect(failure.message, 'Received empty image URL'),
          (homeImage) => fail('Expected validation failure but got success'),
        );
        verify(mockHomeRepository.loadHomeData()).called(1);
      });

      test('should return Left when repository throws exception', () async {
        // Arrange
        when(mockHomeRepository.loadHomeData())
            .thenThrow(Exception('Connection timeout'));

        // Act
        final result = await homeUsecase.loadHomeData();

        // Assert
        result.fold(
          (failure) {
            expect(failure.message, 'Failed to load home data');
            expect(failure.error, isA<Exception>());
          },
          (homeImage) => fail('Expected exception handling but got success'),
        );
        verify(mockHomeRepository.loadHomeData()).called(1);
      });
    });
  });
}
