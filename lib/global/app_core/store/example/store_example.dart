import '../app_state.dart';
import '../value_store.dart';

final class StoreExample extends ValueStore<bool> {
  StoreExample() : super(const IdleState());

  Future<void> isLoggedUser() async {
    updateState(const LoadingState());
    await Future.delayed(const Duration(seconds: 2));
    updateState(const SuccessState(true));
  }
}
