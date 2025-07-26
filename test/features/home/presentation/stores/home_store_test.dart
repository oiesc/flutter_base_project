import 'package:flutter_base_project/features/home/domain/models/home_data.dart';
import 'package:flutter_base_project/features/home/presentation/stores/home_store.dart';
import 'package:flutter_base_project/global/app_core/store/app_state.dart';
import 'package:flutter_test/flutter_test.dart';

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

    test('toggleStatus should toggle isActive field', () async {
      // Arrange
      await homeStore.loadHomeData();
      final initialState = homeStore.state as SuccessState<HomeData>;
      final initialActiveState = initialState.data.isActive;

      // Act
      await homeStore.toggleStatus();

      // Assert
      expect(homeStore.state, isA<SuccessState<HomeData>>());
      final finalState = homeStore.state as SuccessState<HomeData>;
      expect(finalState.data.isActive, !initialActiveState);
    });

    test('refreshData should update lastUpdated timestamp', () async {
      // Arrange
      await homeStore.loadHomeData();
      final initialState = homeStore.state as SuccessState<HomeData>;
      final initialTimestamp = initialState.data.lastUpdated;

      // Wait a bit to ensure different timestamp
      await Future.delayed(const Duration(milliseconds: 10));

      // Act
      await homeStore.refreshData();

      // Assert
      expect(homeStore.state, isA<SuccessState<HomeData>>());
      final finalState = homeStore.state as SuccessState<HomeData>;
      expect(finalState.data.lastUpdated.isAfter(initialTimestamp), true);
    });
  });
}
