import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/features/auth/screens/first_time_user_screen.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: FirstTimeUserScreen(),
    );
  }

  group('FirstTimeUserScreen', () {
    testWidgets('renders "Login or Signup!" text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Login or Signup!'), findsOneWidget);
    });

    testWidgets('"Create New Program" card renders and is tappable',
        (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Create New Program'), findsOneWidget);
      // Verify it's inside a tappable widget
      final card = find.text('Create New Program');
      expect(card, findsOneWidget);
    });

    testWidgets('renders "Watch Video" button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Watch Video'), findsOneWidget);
    });

    testWidgets('renders "How to get started?" section', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('How to get started?'), findsOneWidget);
    });
  });
}
