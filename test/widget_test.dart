import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_home/main.dart';  // Ensure this path is correct

void main() {
  testWidgets('Initial display test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(SmartHomeMonitoringApp());

    // Verify that our initial screen is displayed.
    expect(find.text('Current light level:'), findsOneWidget);
  });
}
