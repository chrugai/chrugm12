import 'package:drift/drift.dart';

import 'foods_table.dart';
import 'meals_table.dart';

class MealFoods extends Table {
  TextColumn get id => text()();
  TextColumn get mealId => text().references(Meals, #mealId)();
  TextColumn get foodId => text().references(Foods, #foodId)();
  RealColumn get quantityGrams => real()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}
