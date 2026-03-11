import 'package:drift/drift.dart';

class Days extends Table {
  TextColumn get dayId => text()();
  TextColumn get programId => text()();
  IntColumn get dayNumber => integer()();
  TextColumn get dayName => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {dayId};
}
