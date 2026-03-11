import 'package:drift/drift.dart';

import 'users_table.dart';

class Meals extends Table {
  TextColumn get mealId => text()();
  TextColumn get userId => text().references(Users, #userId)();
  TextColumn get mealDate => text()();
  TextColumn get mealName => text().nullable()();
  RealColumn get totalCalories => real()();
  RealColumn get totalProteinG => real()();
  RealColumn get totalCarbsG => real()();
  RealColumn get totalFatG => real()();
  TextColumn get createdAt => text()();
  BoolColumn get syncedToBackend =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {mealId};
}
