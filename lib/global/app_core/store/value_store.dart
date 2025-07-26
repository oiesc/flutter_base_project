import 'package:flutter/material.dart';

import 'app_state.dart';
import 'store.dart';

class ValueStore<ResultType> implements Store<ResultType> {
  ValueStore(AppState<ResultType>? initialState) {
    _initialState = initialState ?? IdleState<ResultType>();
    _stateStore = ValueNotifier<AppState<ResultType>>(_initialState);
  }

  late final AppState<ResultType> _initialState;

  late final ValueNotifier<AppState<ResultType>> _stateStore;

  @override
  AppState<ResultType> get state => _stateStore.value;
  Listenable get listener => _stateStore;

  @visibleForTesting
  @protected
  @override
  void updateState(AppState<ResultType> state) {
    _stateStore.value = state;
  }

  @override
  ListenerDisposer addListener(
    void Function(AppState<ResultType> state) listener,
  ) {
    listenerFunction() => listener(_stateStore.value);
    _stateStore.addListener(listenerFunction);
    return () => _stateStore.removeListener(listenerFunction);
  }

  @mustCallSuper
  @override
  void dispose() {
    _stateStore.dispose();
  }
}

class ValueStoreBuilder<StoreType extends ValueStore<ResultType>, ResultType>
    extends StoreBuilder<StoreType, ResultType> {
  const ValueStoreBuilder({
    required super.store,
    required super.builder,
    super.key,
  });

  @override
  State<ValueStoreBuilder<StoreType, ResultType>> createState() => _ValueStoreBuilderState<StoreType, ResultType>();
}

class _ValueStoreBuilderState<StoreType extends ValueStore<ResultType>, ResultType>
    extends State<ValueStoreBuilder<StoreType, ResultType>> {
  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.store.listener,
      builder: (context, _) {
        return widget.builder(context, widget.store.state);
      },
    );
  }
}
