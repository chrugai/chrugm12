import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/user.dart' as models;

class AuthService {
  AuthService(this._db);

  final AppDatabase _db;

  models.User _userFromRow(User row) => models.User(
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

  /// Mock signup: creates a local user with the given email.
  Future<models.User> signupWithEmail(String email) async {
    final now = DateTime.now().toIso8601String();

    await _db.userDao.upsertUser(UsersCompanion(
      userId: const Value('local_user'),
      email: Value(email),
      isAuthenticated: const Value(true),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    return models.User(
      userId: 'local_user',
      email: email,
      isAuthenticated: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Mock OTP verification — always succeeds after a short delay.
  Future<bool> verifyOtp(String email, String code) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return true;
  }

  /// Mock Apple sign-in — creates/returns a local user.
  Future<models.User> signInWithApple() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return signupWithEmail('apple_user@icloud.com');
  }

  /// Mock anonymous mode — creates anonymous user.
  Future<models.User> continueAnonymously() async {
    final now = DateTime.now().toIso8601String();

    await _db.userDao.upsertUser(UsersCompanion(
      userId: const Value('local_user'),
      email: const Value('anonymous@local'),
      name: const Value('Guest'),
      isAuthenticated: const Value(false),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    return models.User(
      userId: 'local_user',
      email: 'anonymous@local',
      name: 'Guest',
      isAuthenticated: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Get the current user from the database.
  Future<models.User?> getCurrentUser() async {
    final row = await _db.userDao.getUser();
    if (row == null) return null;
    return _userFromRow(row);
  }

  /// Logout — marks user as not authenticated.
  Future<void> logout() async {
    await _db.userDao.upsertUser(const UsersCompanion(
      userId: Value('local_user'),
      isAuthenticated: Value(false),
    ));
  }
}
