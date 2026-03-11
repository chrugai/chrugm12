import 'package:drift/drift.dart';

import 'users_table.dart';

class Chats extends Table {
  TextColumn get chatId => text()();
  TextColumn get userId => text().references(Users, #userId)();
  TextColumn get title => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {chatId};
}
