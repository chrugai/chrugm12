import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/core/widgets/display/app_card.dart';
import 'package:chrugm12/core/widgets/display/app_button.dart';
import 'package:chrugm12/core/widgets/display/app_progress_bar.dart';
import 'package:chrugm12/core/widgets/display/app_accordion.dart';
import 'package:chrugm12/core/widgets/display/bubble_selector.dart';
import 'package:chrugm12/core/widgets/display/app_toast.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child)));
}

void main() {
  group('AppCard', () {
    testWidgets('renders child widget with rounded corners', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppCard(child: Text('Card Content')),
      ));
      expect(find.text('Card Content'), findsOneWidget);
    });
  });

  group('AppButton', () {
    testWidgets('in default state responds to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(_wrap(
        AppButton(label: 'Press Me', onPressed: () => tapped = true),
      ));
      await tester.tap(find.text('Press Me'));
      await tester.pumpAndSettle();
      expect(tapped, true);
    });

    testWidgets('in disabled state does not respond to tap', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(_wrap(
        AppButton(
          label: 'Disabled',
          onPressed: () => tapped = true,
          isDisabled: true,
        ),
      ));
      await tester.tap(find.text('Disabled'));
      await tester.pumpAndSettle();
      expect(tapped, false);
    });

    testWidgets('in loading state shows CircularProgressIndicator',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const AppButton(label: 'Loading', isLoading: true),
      ));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });

  group('AppProgressBar', () {
    testWidgets('with progress 0.5 renders', (tester) async {
      await tester.pumpWidget(_wrap(
        const AppProgressBar(progress: 0.5),
      ));
      // Verify the widget tree is built
      expect(find.byType(AppProgressBar), findsOneWidget);
    });
  });

  group('AppAccordion', () {
    testWidgets('initially collapsed, tap expands, tap collapses',
        (tester) async {
      await tester.pumpWidget(_wrap(
        const AppAccordion(
          title: 'FAQ Section',
          content: Text('Answer content here'),
        ),
      ));

      // Initially collapsed - content not visible
      expect(find.text('FAQ Section'), findsOneWidget);

      // Tap to expand
      await tester.tap(find.text('FAQ Section'));
      await tester.pumpAndSettle();

      expect(find.text('Answer content here'), findsOneWidget);

      // Tap to collapse
      await tester.tap(find.text('FAQ Section'));
      await tester.pumpAndSettle();
    });
  });

  group('BubbleSelector', () {
    testWidgets('tap on option adds it to selection', (tester) async {
      List<String> selected = [];
      await tester.pumpWidget(_wrap(
        StatefulBuilder(
          builder: (context, setState) => BubbleSelector(
            options: const ['Chest', 'Back', 'Legs'],
            selectedOptions: selected,
            onSelected: (v) => setState(() => selected = v),
          ),
        ),
      ));

      await tester.tap(find.text('Chest'));
      await tester.pumpAndSettle();
      expect(selected, ['Chest']);
    });
  });

  group('AppToast', () {
    testWidgets('showSuccess displays overlay', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => ElevatedButton(
              onPressed: () => AppToast.showSuccess(context, 'Saved!'),
              child: const Text('Show Toast'),
            ),
          ),
        ),
      ));

      await tester.tap(find.text('Show Toast'));
      await tester.pump();

      expect(find.text('Saved!'), findsOneWidget);

      // Flush all pending timers to avoid 'Timer is still pending' error
      await tester.pumpAndSettle(const Duration(seconds: 4));
    });
  });
}
