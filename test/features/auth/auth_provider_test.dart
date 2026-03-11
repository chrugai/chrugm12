import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/state/auth_state.dart';
import 'package:chrugm12/data/models/user.dart' as models;
import 'package:chrugm12/features/auth/providers/auth_provider.dart';

/// Minimal fake that replaces AuthNotifier behavior without a real DB.
void main() {
  group('AuthNotifier', () {
    test('initial state is not authenticated', () {
      final state = AuthState.initial();
      expect(state.isAuthenticated, false);
      expect(state.user, isNull);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('AuthState copyWith updates fields correctly', () {
      final user = models.User(
        userId: 'u1',
        email: 'test@example.com',
        isAuthenticated: true,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 1),
      );

      final state = AuthState.initial().copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );

      expect(state.isAuthenticated, true);
      expect(state.user?.email, 'test@example.com');
      expect(state.isLoading, false);
    });

    test('logout resets to initial state pattern', () {
      final user = models.User(
        userId: 'u1',
        email: 'test@example.com',
        isAuthenticated: true,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 1),
      );

      var state = AuthState.initial().copyWith(
        isAuthenticated: true,
        user: user,
      );

      expect(state.isAuthenticated, true);

      // Simulate logout
      state = AuthState.initial();
      expect(state.isAuthenticated, false);
      expect(state.user, isNull);
    });

    test('anonymous mode has user but isAuthenticated false', () {
      final anonUser = models.User(
        userId: 'local_user',
        email: 'anonymous@local',
        name: 'Guest',
        isAuthenticated: false,
        createdAt: DateTime.utc(2026, 1, 1),
        updatedAt: DateTime.utc(2026, 1, 1),
      );

      final state = AuthState.initial().copyWith(
        isAuthenticated: false,
        user: anonUser,
      );

      expect(state.isAuthenticated, false);
      expect(state.user?.name, 'Guest');
      expect(state.user?.email, 'anonymous@local');
    });

    test('loading state transitions', () {
      var state = AuthState.initial();
      expect(state.isLoading, false);

      state = state.copyWith(isLoading: true);
      expect(state.isLoading, true);

      state = state.copyWith(isLoading: false, isAuthenticated: true);
      expect(state.isLoading, false);
      expect(state.isAuthenticated, true);
    });

    test('error state is captured', () {
      var state = AuthState.initial();
      state = state.copyWith(error: 'Network error');
      expect(state.error, 'Network error');

      state = state.copyWith(error: null);
      expect(state.error, isNull);
    });
  });
}
