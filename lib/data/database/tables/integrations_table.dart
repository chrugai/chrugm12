import 'package:drift/drift.dart';

import 'users_table.dart';

class Integrations extends Table {
  TextColumn get integrationId => text()();
  TextColumn get userId => text().references(Users, #userId)();
  TextColumn get integrationName => text()();
  BoolColumn get isConnected =>
      boolean().withDefault(const Constant(false))();
  TextColumn get lastSyncedAt => text().nullable()();
  TextColumn get syncError => text().nullable()();

  @override
  Set<Column> get primaryKey => {integrationId};
}
