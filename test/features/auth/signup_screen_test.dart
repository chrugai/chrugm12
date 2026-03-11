import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/features/auth/screens/signup_screen.dart';

void main() {
  Widget buildTestWidget({String? initialEmail}) {
    return ProviderScope(
      child: MaterialApp(
        home: SignupScreen(initialEmail: initialEmail),
      ),
    );
  }

  group('SignupScreen', () {
    testWidgets('renders Apple button and email input', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Continue with Apple'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('renders Google button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Continue with Google'), findsOneWidget);
    });

    testWidgets('renders Cancel button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('renders Email label', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('renders Privacy Policy and Terms links', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Privacy Policy'), findsOneWidget);
      expect(find.text('Terms of Service'), findsOneWidget);
    });

    testWidgets('arrow button appears only when email is non-empty',
        (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Arrow not visible when empty
      expect(find.byIcon(Icons.arrow_forward), findsNothing);

      // Type email
      await tester.enterText(find.byType(TextField), 'test@mail.com');
      await tester.pump();

      // Arrow now visible
      expect(find.byIcon(Icons.arrow_forward), findsOneWidget);
    });

    testWidgets('shows error for invalid email', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Type invalid email
      await tester.enterText(find.byType(TextField), 'invalid');
      await tester.pump();

      // Tap arrow
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pump();

      expect(find.text('Enter valid email'), findsOneWidget);
    });

    testWidgets('pre-fills email from initialEmail', (tester) async {
      await tester.pumpWidget(buildTestWidget(initialEmail: 'pre@fill.com'));
      await tester.pumpAndSettle();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, 'pre@fill.com');
    });
  });
}
