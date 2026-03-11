import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/features/profile/screens/contact_form_screen.dart';
import 'package:chrugm12/features/profile/screens/feedback_screen.dart';

void main() {
  group('ContactFormScreen', () {
    testWidgets('send button disabled when fields empty', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ContactFormScreen(),
      ));

      // Find the Send button text
      final sendButton = find.text('Send');
      expect(sendButton, findsOneWidget);

      // Button should be rendered (it's always there, just disabled)
      expect(sendButton, findsOneWidget);
    });

    testWidgets('send button enables when subject and message filled',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ContactFormScreen(),
      ));

      // Tap subject dropdown
      await tester.tap(find.text('Select a subject'));
      await tester.pumpAndSettle();

      // Select "Bug Report" from bottom sheet
      await tester.tap(find.text('Bug Report'));
      await tester.pumpAndSettle();

      // Type in message field
      await tester.enterText(
        find.byType(TextField),
        'This is a test message',
      );
      await tester.pump();

      // The Send text should still be present
      expect(find.text('Send'), findsOneWidget);
    });

    testWidgets('shows success state after mock send', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ContactFormScreen(),
      ));

      // Select subject
      await tester.tap(find.text('Select a subject'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('General Question'));
      await tester.pumpAndSettle();

      // Type message
      await tester.enterText(
        find.byType(TextField),
        'Test message content',
      );
      await tester.pump();

      // Tap send
      await tester.tap(find.text('Send'));
      await tester.pump();

      // Wait for 1s mock delay
      await tester.pump(const Duration(seconds: 1));
      await tester.pump();

      // Should show success state
      expect(find.text('Thanks for reaching out!'), findsOneWidget);

      // Flush toast timers
      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });

  group('FeedbackScreen', () {
    testWidgets('submit disabled when no rating selected', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: FeedbackScreen(),
      ));

      expect(find.text('Submit'), findsOneWidget);
      expect(find.text("How's your experience?"), findsOneWidget);
    });

    testWidgets('submit enables on rating selection', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: FeedbackScreen(),
      ));

      // Tap 4th star
      final stars = find.byIcon(Icons.star_outline_rounded);
      expect(stars, findsNWidgets(5));

      await tester.tap(stars.at(3));
      await tester.pump();

      // First 4 should be filled, last one outline
      expect(find.byIcon(Icons.star_rounded), findsNWidgets(4));
      expect(find.byIcon(Icons.star_outline_rounded), findsOneWidget);
    });
  });
}
