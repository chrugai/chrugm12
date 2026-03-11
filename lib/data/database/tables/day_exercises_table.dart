import 'package:drift/drift.dart';

class DayExercises extends Table {
  TextColumn get id => text()();
  TextColumn get dayId => text()();
  TextColumn get exerciseId => text()();
  IntColumn get exerciseOrder => integer()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
