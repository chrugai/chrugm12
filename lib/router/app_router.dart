import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/screens/splash_screen.dart';
import '../features/common/screens/placeholder_screen.dart';
import '../features/common/widgets/bottom_tab_navigator.dart';
import 'route_constants.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _workoutNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'workout');
final _aiCoachNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'aiCoach');
final _foodLogNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'foodLog');

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Routes.splash,
    routes: [
      // Auth routes (outside shell)
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.firstTime,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'First Time'),
      ),
      GoRoute(
        path: Routes.watchDemo,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Watch Demo'),
      ),
      GoRoute(
        path: Routes.signup,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Signup'),
      ),
      GoRoute(
        path: Routes.verify,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Verify'),
      ),

      // Main tabbed shell
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomTabNavigator(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              ),
            ),
          );
        },
        branches: [
          // Workout branch
          StatefulShellBranch(
            navigatorKey: _workoutNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.workout,
                builder: (context, state) =>
                    const PlaceholderScreen(routeName: 'Workout Days'),
                routes: [
                  GoRoute(
                    path: Routes.workoutDay,
                    builder: (context, state) => PlaceholderScreen(
                      routeName:
                          'Workout Day ${state.pathParameters['dayId']}',
                    ),
                    routes: [
                      GoRoute(
                        path: Routes.exerciseDetails,
                        builder: (context, state) => PlaceholderScreen(
                          routeName:
                              'Exercise ${state.pathParameters['exerciseId']}',
                        ),
                      ),
                    ],
                  ),
                  GoRoute(
                    path: Routes.selectExercise,
                    builder: (context, state) =>
                        const PlaceholderScreen(routeName: 'Select Exercise'),
                  ),
                ],
              ),
            ],
          ),

          // AI Coach branch
          StatefulShellBranch(
            navigatorKey: _aiCoachNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.aiCoach,
                builder: (context, state) =>
                    const PlaceholderScreen(routeName: 'AI Coach'),
              ),
            ],
          ),

          // Food Log branch
          StatefulShellBranch(
            navigatorKey: _foodLogNavigatorKey,
            routes: [
              GoRoute(
                path: Routes.foodLog,
                builder: (context, state) =>
                    const PlaceholderScreen(routeName: 'Food Log'),
              ),
            ],
          ),
        ],
      ),

      // Profile & settings (outside shell, full-screen)
      GoRoute(
        path: Routes.profile,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Profile'),
      ),
      GoRoute(
        path: Routes.pickProgram,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Pick a Program'),
      ),
      GoRoute(
        path: Routes.programDetails,
        builder: (context, state) => PlaceholderScreen(
          routeName:
              'Program ${state.pathParameters['programId']}',
        ),
      ),
      GoRoute(
        path: Routes.measurements,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Measurements'),
      ),
      GoRoute(
        path: Routes.uploads,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Uploads'),
      ),
      GoRoute(
        path: Routes.integrations,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Integrations'),
      ),
      GoRoute(
        path: Routes.help,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Help'),
      ),
      GoRoute(
        path: Routes.faqs,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'FAQs'),
      ),
      GoRoute(
        path: Routes.contact,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Contact'),
      ),
      GoRoute(
        path: Routes.feedback,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Feedback'),
      ),
      GoRoute(
        path: Routes.notifications,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Notifications'),
      ),
      GoRoute(
        path: Routes.referFriend,
        builder: (context, state) =>
            const PlaceholderScreen(routeName: 'Refer a Friend'),
      ),
    ],
  );
});
