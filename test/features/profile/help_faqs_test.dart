import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/seeds/faq_seeds.dart';
import 'package:chrugm12/features/profile/screens/help_screen.dart';
import 'package:chrugm12/features/profile/screens/faqs_screen.dart';

Widget _wrap(Widget child) {
  return MaterialApp(home: child);
}

void main() {
  group('HelpScreen', () {
    testWidgets('renders FAQs and Contact cards', (tester) async {
      await tester.pumpWidget(_wrap(const HelpScreen()));
      await tester.pumpAndSettle();

      expect(find.text('Help'), findsOneWidget);
      expect(find.text('FAQs'), findsOneWidget);
      expect(find.text('Contact Us'), findsOneWidget);
      expect(find.text('How can we help?'), findsOneWidget);
    });
  });

  group('FaqsScreen', () {
    testWidgets('renders 7 accordion sections', (tester) async {
      await tester.pumpWidget(_wrap(const FaqsScreen()));
      await tester.pumpAndSettle();

      expect(find.text('FAQs'), findsOneWidget);

      final faqs = getFaqs();
      expect(faqs.length, 7);

      for (final faq in faqs) {
        expect(find.text(faq.question), findsOneWidget);
      }
    });

    testWidgets('tap expands accordion to show answer', (tester) async {
      await tester.pumpWidget(_wrap(const FaqsScreen()));
      await tester.pumpAndSettle();

      final faqs = getFaqs();
      final firstQuestion = faqs.first.question;
      final firstAnswer = faqs.first.answer;

      // Tap the first question to expand
      await tester.tap(find.text(firstQuestion));
      await tester.pumpAndSettle();

      // Answer should be visible after expanding
      expect(find.text(firstAnswer), findsOneWidget);
    });

    testWidgets('accordion has chevron icon', (tester) async {
      await tester.pumpWidget(_wrap(const FaqsScreen()));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.keyboard_arrow_down), findsNWidgets(7));
    });
  });
}
