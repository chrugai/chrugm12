import 'package:freezed_annotation/freezed_annotation.dart';

import '../user.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    required bool isAuthenticated,
    User? user,
    String? authToken,
    String? error,
    @Default(false) bool isLoading,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(isAuthenticated: false);

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
