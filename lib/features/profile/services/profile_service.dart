import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/user.dart' as models;

class ProfileService {
  ProfileService(this._db);

  final AppDatabase _db;

  Future<models.User?> getUser() async {
    final row = await _db.userDao.getUser();
    if (row == null) return null;
    return _userFromRow(row);
  }

  Future<models.User> updateUser({
    required String userId,
    String? name,
    String? email,
    double? heightCm,
    double? weightKg,
    String? birthDate,
    String? gender,
    String? profilePicturePath,
  }) async {
    final now = DateTime.now().toIso8601String();
    final existing = await (_db.select(_db.users)
          ..where((t) => t.userId.equals(userId)))
        .getSingle();

    await _db.userDao.upsertUser(UsersCompanion(
      userId: Value(userId),
      email: Value(email ?? existing.email),
      name: Value(name ?? existing.name),
      heightCm: Value(heightCm ?? existing.heightCm),
      weightKg: Value(weightKg ?? existing.weightKg),
      birthDate: Value(birthDate ?? existing.birthDate),
      gender: Value(gender ?? existing.gender),
      profilePicturePath:
          Value(profilePicturePath ?? existing.profilePicturePath),
      isAuthenticated: Value(existing.isAuthenticated),
      createdAt: Value(existing.createdAt),
      updatedAt: Value(now),
    ));

    final updated = await (_db.select(_db.users)
          ..where((t) => t.userId.equals(userId)))
        .getSingle();
    return _userFromRow(updated);
  }

  models.User _userFromRow(User row) {
    return models.User(
      userId: row.userId,
      email: row.email,
      name: row.name,
      heightCm: row.heightCm,
      weightKg: row.weightKg,
      birthDate: row.birthDate,
      gender: row.gender,
      profilePicturePath: row.profilePicturePath,
      isAuthenticated: row.isAuthenticated,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }
}
