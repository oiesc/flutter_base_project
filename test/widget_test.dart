import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/app.dart';
import 'package:flutter_base_project/global/settings/app_settings_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Initialize settings store for testing
    final settingsStore = AppSettingsStore();
    await settingsStore.initialize();

    // Build our app and trigger a frame.
    await tester.pumpWidget(App(settingsStore: settingsStore));

    // Wait for the app to finish loading
    await tester.pumpAndSettle();

    // Verify that the app loads without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
