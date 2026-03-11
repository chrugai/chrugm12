import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/foods_table.dart';
import '../tables/meal_foods_table.dart';
import '../tables/meals_table.dart';

part 'nutrition_dao.g.dart';

@DriftAccessor(tables: [Meals, Foods, MealFoods])
class NutritionDao extends DatabaseAccessor<AppDatabase>
    with _$NutritionDaoMixin {
  NutritionDao(super.db);

  Future<List<Meal>> getMealsForDate(String date) =>
      (select(meals)..where((t) => t.mealDate.equals(date))).get();

  Future<void> insertMeal(MealsCompanion meal) => into(meals).insert(meal);

  Future<bool> updateMeal(MealsCompanion meal) =>
      update(meals).replace(meal);

  Future<int> deleteMeal(String mealId) =>
      (delete(meals)..where((t) => t.mealId.equals(mealId))).go();

  Future<List<Food>> getAllFoods() => select(foods).get();

  Future<List<Food>> searchFoods(String query) =>
      (select(foods)..where((t) => t.name.like('%$query%'))).get();

  Future<List<Food>> getCustomFoods() =>
      (select(foods)..where((t) => t.isUserCustom.equals(true))).get();

  Future<void> insertFood(FoodsCompanion food) => into(foods).insert(food);

  Future<List<MealFood>> getMealFoods(String mealId) =>
      (select(mealFoods)..where((t) => t.mealId.equals(mealId))).get();

  Future<void> insertMealFood(MealFoodsCompanion mealFood) =>
      into(mealFoods).insert(mealFood);
}
