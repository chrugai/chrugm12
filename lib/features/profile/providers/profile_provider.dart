import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/user.dart' as models;
import '../services/profile_service.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  final db = ref.watch(databaseProvider);
  return ProfileService(db);
});

final profileProvider =
    StateNotifierProvider<ProfileNotifier, AsyncValue<models.User?>>((ref) {
  final service = ref.watch(profileServiceProvider);
  return ProfileNotifier(service);
});

class ProfileNotifier extends StateNotifier<AsyncValue<models.User?>> {
  ProfileNotifier(this._service) : super(const AsyncValue.loading());

  final ProfileService _service;

  Future<void> loadUser() async {
    state = const AsyncValue.loading();
    try {
      final user = await _service.getUser();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateField(String fieldName, dynamic value) async {
    final user = state.valueOrNull;
    if (user == null) return;

    try {
      final updated = await _service.updateUser(
        userId: user.userId,
        name: fieldName == 'name' ? value as String : null,
        email: fieldName == 'email' ? value as String : null,
        heightCm: fieldName == 'heightCm' ? value as double : null,
        weightKg: fieldName == 'weightKg' ? value as double : null,
        birthDate: fieldName == 'birthDate' ? value as String : null,
        gender: fieldName == 'gender' ? value as String : null,
        profilePicturePath:
            fieldName == 'profilePicturePath' ? value as String : null,
      );
      state = AsyncValue.data(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
