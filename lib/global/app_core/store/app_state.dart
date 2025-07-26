import '../failures/app_failure.dart';

base class AppState<T> {
  const AppState();

  R when<R>({
    required R Function() idle,
    required R Function() loading,
    required R Function(T data) success,
    required R Function(AppGenericFailure error) error,
  }) {
    if (this is IdleState<T>) {
      return idle();
    } else if (this is LoadingState<T>) {
      return loading();
    } else if (this is SuccessState<T>) {
      return success((this as SuccessState<T>).data);
    } else if (this is ErrorState<T>) {
      return error((this as ErrorState<T>).error);
    } else {
      throw AssertionError();
    }
  }

  R whenDefault<R>({
    required R Function() whenDefault,
    R Function()? idle,
    R Function()? loading,
    R Function(T data)? success,
    R Function(Object error)? error,
  }) {
    if (this is IdleState<T>) {
      return idle?.call() ?? whenDefault();
    } else if (this is LoadingState<T>) {
      return loading?.call() ?? whenDefault();
    } else if (this is SuccessState<T>) {
      return success?.call((this as SuccessState<T>).data) ?? whenDefault();
    } else if (this is ErrorState<T>) {
      return error?.call((this as ErrorState<T>).error) ?? whenDefault();
    } else {
      return whenDefault();
    }
  }

  void whenSuccess(void Function(T data) success) {
    if (this is SuccessState<T>) {
      success((this as SuccessState<T>).data);
    }
  }

  void whenError(void Function(Object error) error) {
    if (this is ErrorState<T>) {
      error((this as ErrorState<T>).error);
    }
  }

  SuccessState<T>? foldSuccessState() {
    if (this is SuccessState<T>) {
      return this as SuccessState<T>;
    } else {
      return null;
    }
  }

  R foldSuccess<R>({
    required R Function(T data) success,
    required R Function() orElse,
  }) {
    if (this is SuccessState<T>) {
      return success((this as SuccessState<T>).data);
    } else {
      return orElse();
    }
  }

  void whenNonSuccess(void Function() nonSuccess) {
    if (this is! SuccessState<T>) {
      nonSuccess();
    }
  }
}

base class IdleState<T> extends AppState<T> {
  const IdleState();

  @override
  String toString() {
    return 'IdleState<$T>';
  }
}

base class LoadingState<T> extends AppState<T> {
  const LoadingState();

  @override
  String toString() {
    return 'LoadingState<$T>';
  }
}

final class LoadingMoreState<T> extends SuccessState<T> {
  const LoadingMoreState(super.data);
}

base class SuccessState<T> extends AppState<T> {
  const SuccessState(this.data);

  final T data;

  @override
  String toString() {
    return 'SuccessState<$T>{data: $data}';
  }
}

base class ErrorState<T> extends AppState<T> {
  const ErrorState(this.error);

  final AppGenericFailure error;

  @override
  String toString() {
    return 'ErrorState<$T>{message: ${error.message}, error: ${error.error?.runtimeType}}';
  }
}
