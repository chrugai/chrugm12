import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/state/auth_state.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  final db = ref.watch(databaseProvider);
  return AuthService(db);
});

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final service = ref.watch(authServiceProvider);
  return AuthNotifier(service);
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier(this._service) : super(AuthState.initial());

  final AuthService _service;

  Future<void> checkAuth() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _service.getCurrentUser();
      if (user != null && user.isAuthenticated) {
        state = state.copyWith(
          isAuthenticated: true,
          user: user,
          isLoading: false,
        );
      } else {
        state = state.copyWith(isAuthenticated: false, isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signupWithEmail(String email) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _service.signupWithEmail(email);
      state = state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<bool> verifyOtp(String email, String code) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final success = await _service.verifyOtp(email, code);
      state = state.copyWith(isLoading: false);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<void> signInWithApple() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _service.signInWithApple();
      state = state.copyWith(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> continueAnonymously() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _service.continueAnonymously();
      state = state.copyWith(
        isAuthenticated: false,
        user: user,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.logout();
      state = AuthState.initial();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
