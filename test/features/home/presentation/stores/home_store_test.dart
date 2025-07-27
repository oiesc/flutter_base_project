import 'package:flutter_base_project/features/home/domain/models/home_image.dart';
import 'package:flutter_base_project/features/home/domain/usecases/home_usecase.dart';
import 'package:flutter_base_project/features/home/infrastructure/repositories/home_repository.dart';
import 'package:flutter_base_project/features/home/presentation/stores/home_store.dart';
import 'package:flutter_base_project/global/app_core/domain/models/either.dart';
import 'package:flutter_base_project/global/app_core/failures/app_failure.dart';
import 'package:flutter_base_project/global/app_core/store/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_store_test.mocks.dart';

// Generate mock classes
@GenerateMocks([HomeUsecase, HomeRepository])
void main() {
  // Provide dummy values for Mockito
  setUpAll(() {
    provideDummy<Either<AppGenericFailure, HomeImage>>(
      Left(AppGenericFailure(message: 'Dummy failure')),
    );
  });
  group('HomeStore', () {
    late HomeStore homeStore;
    late MockHomeUsecase mockHomeUsecase;

    setUp(() {
      mockHomeUsecase = MockHomeUsecase();
      homeStore = HomeStore(mockHomeUsecase);
    });

    tearDown(() {
      homeStore.dispose();
    });

    test('initial state should be idle', () {
      expect(homeStore.state, isA<IdleState>());
    });

    test('loadData should update state to loading and then success when usecase succeeds', () async {
      // Arrange
      final expectedHomeImage = HomeImage(
        status: 'success',
        url: 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg',
      );
      
      when(mockHomeUsecase.loadHomeData())
          .thenAnswer((_) async => Right(expectedHomeImage));

      // Act
      final future = homeStore.loadData();
      
      // Assert loading state
      expect(homeStore.state, isA<LoadingState>());
      
      // Wait for completion
      await future;
      
      // Assert success state
      expect(homeStore.state, isA<SuccessState<HomeImage>>());
      final successState = homeStore.state as SuccessState<HomeImage>;
      expect(successState.data.status, 'success');
      expect(successState.data.url, 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg');
    });

    test('loadData should update state to error when usecase fails', () async {
      // Arrange
      final failure = AppGenericFailure(message: 'Network error');
      when(mockHomeUsecase.loadHomeData())
          .thenAnswer((_) async => Left(failure));

      // Act
      await homeStore.loadData();

      // Assert
      expect(homeStore.state, isA<ErrorState<HomeImage>>());
      final errorState = homeStore.state as ErrorState<HomeImage>;
      expect(errorState.error.message, 'Network error');
    });

    test('multiple loadData calls should handle state correctly', () async {
      // Arrange
      final expectedHomeImage = HomeImage(
        status: 'success',
        url: 'https://images.dog.ceo/breeds/hound-afghan/n02088094_1007.jpg',
      );
      
      when(mockHomeUsecase.loadHomeData())
          .thenAnswer((_) async => Right(expectedHomeImage));

      // Act - call loadData multiple times
      await homeStore.loadData();
      await homeStore.loadData();

      // Assert - should end up in success state
      expect(homeStore.state, isA<SuccessState<HomeImage>>());
      verify(mockHomeUsecase.loadHomeData()).called(2);
    });
  });
}
