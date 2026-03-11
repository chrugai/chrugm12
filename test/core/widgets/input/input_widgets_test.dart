import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/core/widgets/input/app_text_input.dart';
import 'package:chrugm12/core/widgets/input/app_number_input.dart';
import 'package:chrugm12/core/widgets/input/app_search_bar.dart';
import 'package:chrugm12/core/widgets/input/app_checkbox.dart';
import 'package:chrugm12/core/widgets/input/app_date_picker.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child)));
}

void main() {
  group('AppTextInput', () {
    testWidgets('renders with hint text', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextInput(hint: 'Enter name'),
      ));
      expect(find.text('Enter name'), findsOneWidget);
    });

    testWidgets('shows error state when errorText provided', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppTextInput(hint: 'Enter email', errorText: 'Invalid email'),
      ));
      expect(find.text('Invalid email'), findsOneWidget);
    });
  });

  group('AppNumberInput', () {
    testWidgets('tap + button increments value by step', (tester) async {
      num currentValue = 5;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) => AppNumberInput(
            value: currentValue,
            step: 2.5,
            onChanged: (v) => setState(() => currentValue = v),
          ),
        ),
      ));
      expect(find.text('5'), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('7.5'), findsOneWidget);
    });

    testWidgets('tap - button does not go below min', (tester) async {
      num currentValue = 0;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) => AppNumberInput(
            value: currentValue,
            min: 0,
            onChanged: (v) => setState(() => currentValue = v),
          ),
        ),
      ));
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });
  });

  group('AppSearchBar', () {
    testWidgets('onChanged fires when text entered', (tester) async {
      String? lastValue;
      final controller = TextEditingController();
      await tester.pumpWidget(_wrap(
        AppSearchBar(
          controller: controller,
          onChanged: (v) => lastValue = v,
        ),
      ));
      await tester.enterText(find.byType(TextField), 'bench');
      expect(lastValue, 'bench');
    });

    testWidgets('clear button clears text', (tester) async {
      final controller = TextEditingController(text: 'hello');
      String lastValue = 'hello';
      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) => AppSearchBar(
            controller: controller,
            onChanged: (v) => setState(() => lastValue = v),
          ),
        ),
      ));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.clear));
      await tester.pump();
      expect(controller.text, '');
      expect(lastValue, '');
    });
  });

  group('AppCheckbox', () {
    testWidgets('tap toggles value', (tester) async {
      bool checked = false;
      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) => AppCheckbox(
            value: checked,
            onChanged: (v) => setState(() => checked = v),
            label: 'Agree to terms',
          ),
        ),
      ));
      expect(find.text('Agree to terms'), findsOneWidget);
      await tester.tap(find.text('Agree to terms'));
      await tester.pumpAndSettle();
      expect(checked, true);
    });
  });

  group('AppDatePicker', () {
    testWidgets('renders 7 column headers (S M T W T F S)', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => showAppDatePicker(
                context,
                initialDate: DateTime(2026, 3, 11),
                onDateSelected: (_) {},
              ),
              child: const Text('Open'),
            ),
          ),
        ),
      ));
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('S'), findsAtLeast(2));
      expect(find.text('M'), findsAtLeast(1));
      expect(find.text('T'), findsAtLeast(2));
      expect(find.text('W'), findsAtLeast(1));
      expect(find.text('F'), findsAtLeast(1));
    });
  });
}
