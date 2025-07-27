import '../../../../global/app_core/app_core.dart';
import '../../domain/models/home_image.dart';
import '../../domain/usecases/home_usecase.dart';

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
