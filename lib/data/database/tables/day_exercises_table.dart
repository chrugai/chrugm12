import 'package:drift/drift.dart';

import 'days_table.dart';
import 'exercises_table.dart';

class DayExercises extends Table {
  TextColumn get id => text()();
  TextColumn get dayId => text().references(Days, #dayId)();
  TextColumn get exerciseId => text().references(Exercises, #exerciseId)();
  IntColumn get exerciseOrder => integer()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
