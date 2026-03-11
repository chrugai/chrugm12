import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/features/onboarding/screens/first_time_screen.dart';
import 'package:chrugm12/features/onboarding/screens/watch_demo_screen.dart';

void main() {
  group('FirstTimeScreen', () {
    testWidgets('renders branding and feature highlights', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FirstTimeScreen()),
      );

      expect(find.text('CHRUG'), findsOneWidget);
      expect(find.text('Your AI-powered fitness companion'), findsOneWidget);
      expect(find.text('Smart Workouts'), findsOneWidget);
      expect(find.text('Nutrition Logging'), findsOneWidget);
      expect(find.text('AI Coach'), findsOneWidget);
    });

    testWidgets('has Get Started and Watch Demo buttons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FirstTimeScreen()),
      );

      expect(find.text('Get Started'), findsOneWidget);
      expect(find.text('Watch Demo'), findsOneWidget);
    });

    testWidgets('renders 3 feature icons', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: FirstTimeScreen()),
      );

      expect(find.byIcon(Icons.fitness_center), findsOneWidget);
      expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
      expect(find.byIcon(Icons.smart_toy_outlined), findsOneWidget);
    });
  });

  group('WatchDemoScreen', () {
    testWidgets('renders first demo page', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WatchDemoScreen()),
      );

      expect(find.text('How It Works'), findsOneWidget);
      expect(find.text('Track Your Workouts'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
    });

    testWidgets('has 4 page indicators', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WatchDemoScreen()),
      );

      // 4 AnimatedContainers as page dots
      expect(find.byType(AnimatedContainer), findsNWidgets(4));
    });

    testWidgets('swipe to second page shows nutrition content',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WatchDemoScreen()),
      );

      // Swipe left to go to page 2
      await tester.drag(find.byType(PageView), const Offset(-400, 0));
      await tester.pumpAndSettle();

      expect(find.text('Log Your Nutrition'), findsOneWidget);
    });

    testWidgets('last page shows Get Started button', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: WatchDemoScreen()),
      );

      // Swipe to last page (3 swipes)
      for (var i = 0; i < 3; i++) {
        await tester.drag(find.byType(PageView), const Offset(-400, 0));
        await tester.pumpAndSettle();
      }

      expect(find.text('Body Measurements'), findsOneWidget);
      expect(find.text('Get Started'), findsOneWidget);
    });
  });
}
