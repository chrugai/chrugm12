import 'package:drift/drift.dart';

import 'days_table.dart';
import 'exercises_table.dart';

@DataClassName('SetEntry')
class Sets extends Table {
  TextColumn get setId => text()();
  TextColumn get exerciseId => text().references(Exercises, #exerciseId)();
  TextColumn get dayId => text().references(Days, #dayId)();
  IntColumn get reps => integer()();
  RealColumn get weightKg => real()();
  IntColumn get repsInReserve => integer().nullable()();
  TextColumn get tempoVariation => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get timestamp => text()();
  BoolColumn get syncedToBackend =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {setId};
}
