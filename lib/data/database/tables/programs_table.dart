import 'package:drift/drift.dart';

import 'users_table.dart';

class Programs extends Table {
  TextColumn get programId => text()();
  TextColumn get userId => text().references(Users, #userId)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {programId};
}
