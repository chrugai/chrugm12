import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/daily_totals.dart';
import '../../../data/models/food.dart' as models;
import '../../../data/models/meal.dart' as models;
import '../../../data/models/meal_food.dart' as models;

const _uuid = Uuid();

class NutritionService {
  NutritionService(this._db);

  final AppDatabase _db;

  Future<List<models.Food>> searchFoods(String query) async {
    final rows = await _db.nutritionDao.searchFoods(query);
    return rows.map(_foodFromRow).toList();
  }

  Future<List<models.Food>> getAllFoods() async {
    final rows = await _db.nutritionDao.getAllFoods();
    return rows.map(_foodFromRow).toList();
  }

  Future<List<models.Food>> getCustomFoods() async {
    final rows = await _db.nutritionDao.getCustomFoods();
    return rows.map(_foodFromRow).toList();
  }

  Future<List<models.Food>> getRecentFoods(String userId) async {
    // Query meal_foods joined with foods, ordered by most recently logged, deduplicated
    final mealRows = await (
      _db.select(_db.meals)
        ..where((t) => t.userId.equals(userId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
        ..limit(50)
    ).get();

    final seenFoodIds = <String>{};
    final recentFoods = <models.Food>[];

    for (final meal in mealRows) {
      final mealFoodRows = await _db.nutritionDao.getMealFoods(meal.mealId);
      for (final mf in mealFoodRows) {
        if (seenFoodIds.add(mf.foodId)) {
          final foodRows = await (
            _db.select(_db.foods)
              ..where((t) => t.foodId.equals(mf.foodId))
          ).get();
          if (foodRows.isNotEmpty) {
            recentFoods.add(_foodFromRow(foodRows.first));
          }
        }
        if (recentFoods.length >= 20) break;
      }
      if (recentFoods.length >= 20) break;
    }

    return recentFoods;
  }

  Future<models.Food> createCustomFood({
    required String name,
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
    required String userId,
  }) async {
    final foodId = _uuid.v4();
    final now = DateTime.now().toIso8601String();

    await _db.nutritionDao.insertFood(FoodsCompanion(
      foodId: Value(foodId),
      name: Value(name),
      caloriesPer100g: Value(caloriesPer100g),
      proteinGPer100g: Value(proteinGPer100g),
      carbsGPer100g: Value(carbsGPer100g),
      fatGPer100g: Value(fatGPer100g),
      isUserCustom: const Value(true),
      userId: Value(userId),
      createdAt: Value(now),
    ));

    return models.Food(
      foodId: foodId,
      name: name,
      caloriesPer100g: caloriesPer100g,
      proteinGPer100g: proteinGPer100g,
      carbsGPer100g: carbsGPer100g,
      fatGPer100g: fatGPer100g,
      isUserCustom: true,
      userId: userId,
      createdAt: DateTime.now(),
    );
  }

  Future<models.Meal> addFoodToMeal({
    required String userId,
    required String date,
    required models.Food food,
    double quantityGrams = 100,
  }) async {
    final now = DateTime.now();
    final nowIso = now.toIso8601String();

    // Find existing meals for this date
    final existingMeals = await _db.nutritionDao.getMealsForDate(date);

    Meal targetMeal;

    if (existingMeals.isEmpty) {
      // No meals today — create "Meal 1"
      targetMeal = await _createMeal(userId, date, 'Meal 1', nowIso);
    } else {
      // Check time gap from most recent meal
      final mostRecent = existingMeals.last;
      final mealCreatedAt = DateTime.parse(mostRecent.createdAt);
      final gap = now.difference(mealCreatedAt);

      if (gap.inHours >= 2) {
        // Create new meal
        final mealNum = existingMeals.length + 1;
        targetMeal = await _createMeal(userId, date, 'Meal $mealNum', nowIso);
      } else {
        targetMeal = mostRecent;
      }
    }

    // Insert meal_food record
    final mealFoodId = _uuid.v4();
    await _db.nutritionDao.insertMealFood(MealFoodsCompanion(
      id: Value(mealFoodId),
      mealId: Value(targetMeal.mealId),
      foodId: Value(food.foodId),
      quantityGrams: Value(quantityGrams),
      createdAt: Value(nowIso),
    ));

    // Recalculate meal totals
    final updatedMeal = await _recalculateMealTotals(targetMeal.mealId);
    return _mealFromRow(updatedMeal);
  }

  Future<List<models.Meal>> getMealsForDate(String userId, String date) async {
    final mealRows = await (
      _db.select(_db.meals)
        ..where((t) => t.mealDate.equals(date) & t.userId.equals(userId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
    ).get();

    final meals = <models.Meal>[];
    for (final row in mealRows) {
      meals.add(await _mealFromRow(row));
    }
    return meals;
  }

  Future<void> deleteMeal(String mealId) async {
    // Delete associated meal_foods first
    await (_db.delete(_db.mealFoods)
      ..where((t) => t.mealId.equals(mealId))
    ).go();
    await _db.nutritionDao.deleteMeal(mealId);
  }

  DailyTotals calculateDailyTotals(List<models.Meal> meals) {
    var totalCal = 0.0;
    var totalProtein = 0.0;
    var totalCarbs = 0.0;
    var totalFat = 0.0;

    for (final meal in meals) {
      totalCal += meal.totalCalories;
      totalProtein += meal.totalProteinG;
      totalCarbs += meal.totalCarbsG;
      totalFat += meal.totalFatG;
    }

    return DailyTotals(
      totalCalories: totalCal,
      totalProteinG: totalProtein,
      totalCarbsG: totalCarbs,
      totalFatG: totalFat,
    );
  }

  // -- Private helpers --

  Future<Meal> _createMeal(
    String userId,
    String date,
    String name,
    String nowIso,
  ) async {
    final mealId = _uuid.v4();
    final companion = MealsCompanion(
      mealId: Value(mealId),
      userId: Value(userId),
      mealDate: Value(date),
      mealName: Value(name),
      totalCalories: const Value(0),
      totalProteinG: const Value(0),
      totalCarbsG: const Value(0),
      totalFatG: const Value(0),
      createdAt: Value(nowIso),
    );
    await _db.nutritionDao.insertMeal(companion);
    return (await (_db.select(_db.meals)
          ..where((t) => t.mealId.equals(mealId)))
        .getSingle());
  }

  Future<Meal> _recalculateMealTotals(String mealId) async {
    final mealFoodRows = await _db.nutritionDao.getMealFoods(mealId);
    var cal = 0.0;
    var protein = 0.0;
    var carbs = 0.0;
    var fat = 0.0;

    for (final mf in mealFoodRows) {
      final foodRow = await (_db.select(_db.foods)
            ..where((t) => t.foodId.equals(mf.foodId)))
          .getSingleOrNull();
      if (foodRow != null) {
        cal += (foodRow.caloriesPer100g * mf.quantityGrams) / 100;
        protein += (foodRow.proteinGPer100g * mf.quantityGrams) / 100;
        carbs += (foodRow.carbsGPer100g * mf.quantityGrams) / 100;
        fat += (foodRow.fatGPer100g * mf.quantityGrams) / 100;
      }
    }

    final meal = await (_db.select(_db.meals)
          ..where((t) => t.mealId.equals(mealId)))
        .getSingle();

    await _db.nutritionDao.updateMeal(MealsCompanion(
      mealId: Value(meal.mealId),
      userId: Value(meal.userId),
      mealDate: Value(meal.mealDate),
      mealName: Value(meal.mealName),
      totalCalories: Value(cal),
      totalProteinG: Value(protein),
      totalCarbsG: Value(carbs),
      totalFatG: Value(fat),
      createdAt: Value(meal.createdAt),
      syncedToBackend: Value(meal.syncedToBackend),
    ));

    return (_db.select(_db.meals)
          ..where((t) => t.mealId.equals(mealId)))
        .getSingle();
  }

  Future<models.Meal> _mealFromRow(Meal row) async {
    final mfRows = await _db.nutritionDao.getMealFoods(row.mealId);
    final mealFoods = <models.MealFood>[];

    for (final mf in mfRows) {
      final foodRow = await (_db.select(_db.foods)
            ..where((t) => t.foodId.equals(mf.foodId)))
          .getSingleOrNull();
      if (foodRow != null) {
        mealFoods.add(models.MealFood(
          mealFoodId: mf.id,
          mealId: mf.mealId,
          food: _foodFromRow(foodRow),
          quantityGrams: mf.quantityGrams,
          createdAt: DateTime.parse(mf.createdAt),
        ));
      }
    }

    return models.Meal(
      mealId: row.mealId,
      userId: row.userId,
      mealDate: row.mealDate,
      mealName: row.mealName,
      foods: mealFoods,
      totalCalories: row.totalCalories,
      totalProteinG: row.totalProteinG,
      totalCarbsG: row.totalCarbsG,
      totalFatG: row.totalFatG,
      createdAt: DateTime.parse(row.createdAt),
      syncedToBackend: row.syncedToBackend,
    );
  }

  models.Food _foodFromRow(Food row) {
    return models.Food(
      foodId: row.foodId,
      name: row.name,
      caloriesPer100g: row.caloriesPer100g,
      proteinGPer100g: row.proteinGPer100g,
      carbsGPer100g: row.carbsGPer100g,
      fatGPer100g: row.fatGPer100g,
      isUserCustom: row.isUserCustom,
      userId: row.userId,
      createdAt: DateTime.parse(row.createdAt),
    );
  }
}
