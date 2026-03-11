import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'route_constants.dart';

const _publicRoutes = [
  Routes.splash,
  Routes.firstTime,
  Routes.watchDemo,
  Routes.signup,
  Routes.verify,
];

/// Returns true when the user has a valid session.
/// TODO: Wire up real auth state from Riverpod.
bool _isAuthenticated() => true;

String? authGuard(BuildContext context, GoRouterState state) {
  final authed = _isAuthenticated();
  final isPublicRoute = _publicRoutes.contains(state.matchedLocation);

  if (!authed && !isPublicRoute) {
    return Routes.firstTime;
  }

  if (authed && isPublicRoute) {
    return Routes.workout;
  }

  return null;
}
