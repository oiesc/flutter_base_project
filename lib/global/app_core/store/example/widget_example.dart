// ignore_for_file: unintended_html_in_doc_comment

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../store_imports.dart';
import 'store_example.dart';

/// Widget example demonstrating how to use the StoreExample with ValueStoreBuilder.
///
/// This widget shows three different ways to consume store state:
/// 1. Using `whenDefault` for simplified state handling
/// 2. Using `when` for complete state handling
/// 3. Using custom state pattern matching
///
/// The widget properly manages the store lifecycle including:
/// - Adding listeners in initState
/// - Disposing listeners and store in dispose
/// - Handling state changes with proper UI updates
class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  /// Store instance - you may want to use GetIt for dependency injection:
  /// final store = GetIt.I<StoreExample>();
  ///
  /// For this example, we create a local instance
  final store = StoreExample();

  /// Listener disposal function - holds reference to the store listener
  /// so it can be properly disposed when the widget is destroyed
  void Function()? disposeL;

  @override
  void initState() {
    super.initState();

    /// Register a listener to the store to monitor state changes
    /// The listener will be called whenever the store state changes
    disposeL = store.addListener((state) {
      debugPrint('State changed: $state');
    });

    /// Trigger an initial action to demonstrate store functionality
    /// This will change the store state from idle to loading/success/error
    store.isLoggedUser();
  }

  @override
  void dispose() {
    /// Dispose the listener to prevent memory leaks
    /// Always call this to clean up the listener registration
    disposeL?.call();

    /// Dispose the store to clean up resources
    /// This is important to avoid memory leaks, especially if the store
    /// is holding onto resources like streams, subscriptions, or timers
    ///
    /// Note: Don't call store.dispose() here if you're using dependency
    /// injection and the store should persist across multiple widgets.
    /// In that case, dispose it in the module or service locator.
    store.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// EXAMPLE 1: Simplified state handling with whenDefault
        ///
        /// Use this pattern when you only care about success state and
        /// want to show a default UI for all other states (idle, loading, error).
        /// This is the most common pattern for simple use cases.
        ValueStoreBuilder<StoreExample, bool>(
          store: store,
          builder: (context, state) {
            return state.whenDefault(
              success: (success) => Text('Success: $success'),
              whenDefault: () => const Text('Default state (idle/loading/error)'),
            );
          },
        ),

        const SizedBox(height: 20),

        /// EXAMPLE 2: Complete state handling with when
        ///
        /// Use this pattern when you need to handle all possible states
        /// explicitly. This gives you full control over the UI for each state.
        /// Required when you need different UI for loading vs error vs idle.
        ValueStoreBuilder<StoreExample, bool>(
          store: store,
          builder: (context, state) {
            return state.when(
              idle: () {
                return const Text('Idle - waiting for action');
              },
              loading: () {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              },
              success: (success) {
                return Text('Success: $success');
              },
              error: (error) {
                return Text('Error: $error');
              },
            );
          },
        ),

        const SizedBox(height: 20),

        /// EXAMPLE 3: Custom state pattern matching
        ///
        /// Use this pattern when you need more flexibility or want to
        /// access the raw state object. You can check state types directly
        /// and extract data as needed. Useful for complex UI logic.
        ValueStoreBuilder<StoreExample, bool>(
          store: store,
          builder: (context, state) {
            return Column(
              children: [
                Text('Current state: ${state.runtimeType}'),
                const SizedBox(height: 8),

                // Pattern matching on state types
                if (state is LoadingState) const CircularProgressIndicator(),
                if (state is SuccessState<bool>) Text('Success data: ${state.data}'),
                if (state is ErrorState) Text('Error details: ${(state as ErrorState).error.message}'),

                const Text('My custom page with default widgets and some based on state'),
              ],
            );
          },
        ),
      ],
    );
  }
}
