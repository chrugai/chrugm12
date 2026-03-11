import 'package:drift/drift.dart';

import 'programs_table.dart';

class Days extends Table {
  TextColumn get dayId => text()();
  TextColumn get programId => text().references(Programs, #programId)();
  IntColumn get dayNumber => integer()();
  TextColumn get dayName => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {dayId};
}
