// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:assistant_drive/app/app.dart';

void main() {
  testWidgets('AssistantDrive app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: AssistantDriveApp()));

    // Wait for the async initialization to complete
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify that AssistantDrive title is displayed in the app bar.
    expect(find.text('AssistantDrive'), findsWidgets);
  });
}
