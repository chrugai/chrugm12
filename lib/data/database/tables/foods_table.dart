import 'package:drift/drift.dart';

class Foods extends Table {
  TextColumn get foodId => text()();
  TextColumn get name => text()();
  RealColumn get caloriesPer100g => real()();
  RealColumn get proteinGPer100g => real()();
  RealColumn get carbsGPer100g => real()();
  RealColumn get fatGPer100g => real()();
  BoolColumn get isUserCustom => boolean().withDefault(const Constant(false))();
  TextColumn get userId => text().nullable()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {foodId};
}
