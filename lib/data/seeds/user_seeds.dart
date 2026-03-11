import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedUser(AppDatabase db) async {
  final now = DateTime.now().toIso8601String();
  await db.userDao.upsertUser(UsersCompanion(
    userId: const Value('local_user'),
    email: const Value('jimmy@gmail.com'),
    name: const Value('Jimmy Chen'),
    heightCm: const Value(178.0),
    weightKg: const Value(85.0),
    birthDate: const Value('1990-01-15'),
    gender: const Value('Male'),
    isAuthenticated: const Value(true),
    createdAt: Value(now),
    updatedAt: Value(now),
  ));
}
