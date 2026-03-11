import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedMeals(AppDatabase db) async {
  final now = DateTime.now();
  final today = now.toIso8601String().substring(0, 10);
  final createdAt = now.toIso8601String();

  await db.nutritionDao.insertMeal(MealsCompanion(mealId: const Value('meal_1'), userId: const Value('local_user'), mealDate: Value(today), mealName: const Value('Breakfast'), totalCalories: const Value(385.0), totalProteinG: const Value(31.0), totalCarbsG: const Value(40.5), totalFatG: const Value(12.6), createdAt: Value(createdAt)));
  await db.nutritionDao.insertMealFood(MealFoodsCompanion(id: const Value('mf_1_1'), mealId: const Value('meal_1'), foodId: const Value('food_oatmeal'), quantityGrams: const Value(150.0), createdAt: Value(createdAt)));
  await db.nutritionDao.insertMealFood(MealFoodsCompanion(id: const Value('mf_1_2'), mealId: const Value('meal_1'), foodId: const Value('food_boiled_egg'), quantityGrams: const Value(200.0), createdAt: Value(createdAt)));

  await db.nutritionDao.insertMeal(MealsCompanion(mealId: const Value('meal_2'), userId: const Value('local_user'), mealDate: Value(today), mealName: const Value('Lunch'), totalCalories: const Value(525.0), totalProteinG: const Value(66.0), totalCarbsG: const Value(42.0), totalFatG: const Value(7.8), createdAt: Value(createdAt)));
  await db.nutritionDao.insertMealFood(MealFoodsCompanion(id: const Value('mf_2_1'), mealId: const Value('meal_2'), foodId: const Value('food_chicken_breast'), quantityGrams: const Value(200.0), createdAt: Value(createdAt)));
  await db.nutritionDao.insertMealFood(MealFoodsCompanion(id: const Value('mf_2_2'), mealId: const Value('meal_2'), foodId: const Value('food_white_rice'), quantityGrams: const Value(150.0), createdAt: Value(createdAt)));
}
