import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_rfw_poc/app.dart';

void main() {
  testWidgets('Home page smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const App());

    // Verify that our app shows the Flutter Logo and welcome text.
    expect(find.byType(FlutterLogo), findsOneWidget);
    expect(find.text('Welcome to Flutter'), findsOneWidget);
  });
}
