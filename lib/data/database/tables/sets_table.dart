import 'package:drift/drift.dart';

@DataClassName('SetEntry')
class Sets extends Table {
  TextColumn get setId => text()();
  TextColumn get exerciseId => text()();
  TextColumn get dayId => text()();
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
