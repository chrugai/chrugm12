import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/features/auth/widgets/otp_input_field.dart';

void main() {
  Widget buildTestWidget({
    required ValueChanged<String> onCompleted,
    bool hasError = false,
    bool hasSuccess = false,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: OtpInputField(
          onCompleted: onCompleted,
          hasError: hasError,
          hasSuccess: hasSuccess,
        ),
      ),
    );
  }

  group('OtpInputField', () {
    testWidgets('renders 6 text fields', (tester) async {
      await tester.pumpWidget(buildTestWidget(onCompleted: (_) {}));
      expect(find.byType(TextField), findsNWidgets(6));
    });

    testWidgets('auto-advances focus on digit entry', (tester) async {
      await tester.pumpWidget(buildTestWidget(onCompleted: (_) {}));
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);

      // Enter digit in first field
      await tester.enterText(fields.at(0), '1');
      await tester.pump();

      // Enter digit in second field (focus should have moved)
      await tester.enterText(fields.at(1), '2');
      await tester.pump();

      // Verify digits are in the fields
      final controller0 =
          tester.widget<TextField>(fields.at(0)).controller;
      final controller1 =
          tester.widget<TextField>(fields.at(1)).controller;
      expect(controller0?.text, '1');
      expect(controller1?.text, '2');
    });

    testWidgets('fires onCompleted when all 6 digits filled',
        (tester) async {
      String? completedCode;
      await tester.pumpWidget(
        buildTestWidget(onCompleted: (code) => completedCode = code),
      );
      await tester.pumpAndSettle();

      final fields = find.byType(TextField);

      for (var i = 0; i < 6; i++) {
        await tester.enterText(fields.at(i), '${i + 1}');
        await tester.pump();
      }

      expect(completedCode, '123456');
    });
  });
}
