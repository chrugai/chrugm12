import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/features/auth/screens/account_verification_screen.dart';

void main() {
  Widget buildTestWidget({String email = 'test@mail.com'}) {
    return ProviderScope(
      child: MaterialApp(
        home: AccountVerificationScreen(email: email),
      ),
    );
  }

  group('AccountVerificationScreen', () {
    testWidgets('renders verify email heading and email', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Verify email'), findsOneWidget);
      expect(find.text('Account Verification'), findsOneWidget);
    });

    testWidgets('renders shield icon', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.byIcon(Icons.shield), findsOneWidget);
    });

    testWidgets('renders 6 OTP fields', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('displays email in instruction text', (tester) async {
      await tester
          .pumpWidget(buildTestWidget(email: 'user@example.com'));
      expect(find.textContaining('user@example.com'), findsOneWidget);
    });

    testWidgets('shows Resend link initially', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Resend'), findsOneWidget);
    });

    testWidgets('shows resend timer after tapping Resend', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      // Tap Resend
      await tester.tap(find.text('Resend'));
      await tester.pump();

      // Timer text should appear
      expect(
        find.textContaining('You can request a new code in'),
        findsOneWidget,
      );
    });
  });
}
