import 'package:drift/drift.dart';

class Exercises extends Table {
  TextColumn get exerciseId => text()();
  TextColumn get name => text()();
  TextColumn get category => text().nullable()();
  TextColumn get equipment => text().nullable()();
  TextColumn get movementType => text().nullable()();
  TextColumn get muscleGroups => text().nullable()();
  BoolColumn get isCompound => boolean().withDefault(const Constant(false))();
  TextColumn get imageUrl => text().nullable()();
  TextColumn get description => text().nullable()();
  BoolColumn get isUserCustom => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {exerciseId};
}
