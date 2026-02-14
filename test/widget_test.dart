import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rfw_poc/app.dart';
import 'package:get/get.dart';

void main() {
  testWidgets('Auth page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Initially, it shows a loading indicator.
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    // Wait for the async operation to complete (or fail).
    // In a test environment without mocking, the http call will likely fail or timeout.
    // However, we just want to ensure the app starts up without crashing.

    // We can't easily wait for the http call to finish here without mocking.
    // So we just verify the initial loading state.

    // Clean up GetX state
    Get.reset();
  });
}
