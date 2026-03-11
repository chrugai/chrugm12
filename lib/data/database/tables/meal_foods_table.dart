import 'package:drift/drift.dart';

class MealFoods extends Table {
  TextColumn get id => text()();
  TextColumn get mealId => text()();
  TextColumn get foodId => text()();
  RealColumn get quantityGrams => real()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
