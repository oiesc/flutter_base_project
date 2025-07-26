import 'package:flutter/material.dart';

import 'app_state.dart';

typedef ListenerDisposer = void Function();

abstract interface class Store<ResultType> {
  AppState<ResultType> get state;

  void updateState(AppState<ResultType> state);

  ListenerDisposer addListener(
    void Function(AppState<ResultType> state) listener,
  );

  void dispose();
}

abstract class StoreBuilder<StoreType extends Store<ResultType>, ResultType>
    extends StatefulWidget {
  const StoreBuilder({required this.store, required this.builder, super.key});

  final StoreType store;
  final Widget Function(BuildContext context, AppState<ResultType> state)
  builder;
}
