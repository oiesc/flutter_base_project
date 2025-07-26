import '../../../../global/app_core/failures/app_failure.dart';
import '../../../../global/app_core/store/store_imports.dart';
import '../../domain/models/home_data.dart';

/// Store for managing Home page state using ValueStore
class HomeStore extends ValueStore<HomeData> {
  HomeStore() : super(null);

  /// Load initial home data
  Future<void> loadHomeData() async {
    try {
      updateState(const LoadingState<HomeData>());
      
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      
      final homeData = HomeData(
        title: 'Welcome to Flutter Base Project',
        description: 'This is an example of our custom state management system',
        lastUpdated: DateTime.now(),
      );
      
      updateState(SuccessState<HomeData>(homeData));
    } catch (error) {
      updateState(ErrorState<HomeData>(
        AppGenericFailure(
          message: 'Failed to load home data: $error',
          error: error,
        ),
      ));
    }
  }

  /// Refresh home data
  Future<void> refreshData() async {
    try {
      // Don't show loading for refresh, keep current data
      await Future.delayed(const Duration(milliseconds: 500));
      
      final currentData = state.foldSuccess(
        success: (data) => data,
        orElse: () => HomeData(
          title: 'Default Title',
          description: 'Default Description',
          lastUpdated: DateTime.now(),
        ),
      );

      final refreshedData = currentData.copyWith(
        lastUpdated: DateTime.now(),
      );
      
      updateState(SuccessState<HomeData>(refreshedData));
    } catch (error) {
      updateState(ErrorState<HomeData>(
        AppGenericFailure(
          message: 'Failed to refresh data: $error',
          error: error,
        ),
      ));
    }
  }

  /// Update home data status
  Future<void> toggleStatus() async {
    final currentData = state.foldSuccessState();
    if (currentData != null) {
      final updatedData = currentData.data.copyWith(
        isActive: !currentData.data.isActive,
      );
      updateState(SuccessState<HomeData>(updatedData));
    }
  }
}
