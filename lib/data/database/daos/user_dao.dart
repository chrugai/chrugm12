import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/users_table.dart';

part 'user_dao.g.dart';

@DriftAccessor(tables: [Users])
class UserDao extends DatabaseAccessor<AppDatabase> with _$UserDaoMixin {
  UserDao(super.db);

  Future<User?> getUser() => select(users).getSingleOrNull();

  Future<void> upsertUser(UsersCompanion user) =>
      into(users).insertOnConflictUpdate(user);

  Future<int> deleteUser() => delete(users).go();
}
