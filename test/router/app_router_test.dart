import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:chrugm12/router/app_router.dart';
import 'package:chrugm12/router/route_constants.dart';

void main() {
  late GoRouter router;

  setUp(() {
    final container = ProviderContainer();
    router = container.read(appRouterProvider);
  });

  group('AppRouter', () {
    test('initialLocation is workout', () {
      expect(router.routeInformationProvider.value.uri.path, Routes.workout);
    });

    testWidgets('renders workout tab by default', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Workout Days'), findsOneWidget);
    });

    testWidgets('bottom navigation shows 3 tabs', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(NavigationDestination), findsNWidgets(3));
    });

    testWidgets('tapping AI Coach tab navigates to ai-coach', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.smart_toy_outlined));
      await tester.pumpAndSettle();

      expect(find.text('AI Coach'), findsAtLeast(1));
    });

    testWidgets('tapping Food Log tab navigates to food-log', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp.router(routerConfig: router),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.restaurant_outlined));
      await tester.pumpAndSettle();

      expect(find.text('Food Log'), findsAtLeast(1));
    });
  });

  group('Route constants', () {
    test('all main routes start with /', () {
      expect(Routes.splash, startsWith('/'));
      expect(Routes.workout, startsWith('/'));
      expect(Routes.aiCoach, startsWith('/'));
      expect(Routes.foodLog, startsWith('/'));
      expect(Routes.profile, startsWith('/'));
    });

    test('sub-routes do not start with /', () {
      expect(Routes.workoutDay, isNot(startsWith('/')));
      expect(Routes.exerciseDetails, isNot(startsWith('/')));
      expect(Routes.selectExercise, isNot(startsWith('/')));
    });
  });
}
