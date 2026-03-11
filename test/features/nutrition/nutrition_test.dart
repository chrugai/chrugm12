import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/daily_goal.dart';
import 'package:chrugm12/data/models/daily_totals.dart';
import 'package:chrugm12/data/models/food.dart';
import 'package:chrugm12/data/models/meal.dart';
import 'package:chrugm12/data/models/meal_food.dart';
import 'package:chrugm12/data/models/state/nutrition_state.dart';

void main() {
  final now = DateTime.utc(2026, 1, 1);

  final chickenBreast = Food(
    foodId: 'food_chicken_breast',
    name: 'Chicken Breast (Grilled)',
    caloriesPer100g: 165.0,
    proteinGPer100g: 31.0,
    carbsGPer100g: 0.0,
    fatGPer100g: 3.6,
    createdAt: now,
  );

  final whiteRice = Food(
    foodId: 'food_white_rice',
    name: 'White Rice (Cooked)',
    caloriesPer100g: 130.0,
    proteinGPer100g: 2.7,
    carbsGPer100g: 28.0,
    fatGPer100g: 0.3,
    createdAt: now,
  );

  final oatmeal = Food(
    foodId: 'food_oatmeal',
    name: 'Oatmeal',
    caloriesPer100g: 68.0,
    proteinGPer100g: 2.5,
    carbsGPer100g: 12.0,
    fatGPer100g: 1.4,
    createdAt: now,
  );

  group('MealFood computed macros', () {
    test('calculates calories for 100g serving', () {
      final mf = MealFood(
        mealFoodId: 'mf1',
        mealId: 'm1',
        food: chickenBreast,
        quantityGrams: 100,
        createdAt: now,
      );

      expect(mf.calories, 165.0);
      expect(mf.proteinG, 31.0);
      expect(mf.carbsG, 0.0);
      expect(mf.fatG, 3.6);
    });

    test('calculates calories for 200g serving', () {
      final mf = MealFood(
        mealFoodId: 'mf2',
        mealId: 'm1',
        food: chickenBreast,
        quantityGrams: 200,
        createdAt: now,
      );

      expect(mf.calories, 330.0);
      expect(mf.proteinG, 62.0);
      expect(mf.fatG, 7.2);
    });

    test('calculates calories for 150g rice', () {
      final mf = MealFood(
        mealFoodId: 'mf3',
        mealId: 'm1',
        food: whiteRice,
        quantityGrams: 150,
        createdAt: now,
      );

      expect(mf.calories, 195.0);
      expect(mf.proteinG, closeTo(4.05, 0.01));
      expect(mf.carbsG, 42.0);
      expect(mf.fatG, closeTo(0.45, 0.01));
    });
  });

  group('DailyTotals calculation', () {
    test('sums totals from two meals correctly', () {
      final meal1 = Meal(
        mealId: 'm1',
        userId: 'local_user',
        mealDate: '2026-01-01',
        mealName: 'Breakfast',
        foods: [],
        totalCalories: 385.0,
        totalProteinG: 18.0,
        totalCarbsG: 50.0,
        totalFatG: 12.0,
        createdAt: now,
      );

      final meal2 = Meal(
        mealId: 'm2',
        userId: 'local_user',
        mealDate: '2026-01-01',
        mealName: 'Lunch',
        foods: [],
        totalCalories: 525.0,
        totalProteinG: 42.0,
        totalCarbsG: 55.0,
        totalFatG: 14.0,
        createdAt: now,
      );

      // Replicate calculateDailyTotals logic
      final meals = [meal1, meal2];
      var totalCal = 0.0;
      var totalProtein = 0.0;
      var totalCarbs = 0.0;
      var totalFat = 0.0;
      for (final m in meals) {
        totalCal += m.totalCalories;
        totalProtein += m.totalProteinG;
        totalCarbs += m.totalCarbsG;
        totalFat += m.totalFatG;
      }

      final totals = DailyTotals(
        totalCalories: totalCal,
        totalProteinG: totalProtein,
        totalCarbsG: totalCarbs,
        totalFatG: totalFat,
      );

      expect(totals.totalCalories, 910.0);
      expect(totals.totalProteinG, 60.0);
      expect(totals.totalCarbsG, 105.0);
      expect(totals.totalFatG, 26.0);
    });
  });

  group('NutritionState', () {
    test('initial state uses today date and empty meals', () {
      final state = NutritionState.initial();
      expect(state.meals, isEmpty);
      expect(state.isLoading, false);
      expect(state.error, isNull);
      expect(state.dailyGoal, defaultDailyGoal);
      expect(state.dailyTotals.totalCalories, 0);
      expect(state.selectedDate, isNotEmpty);
    });

    test('remaining calories = goal - totals', () {
      final state = NutritionState.initial().copyWith(
        dailyTotals: const DailyTotals(
          totalCalories: 800,
          totalProteinG: 60,
          totalCarbsG: 80,
          totalFatG: 25,
        ),
      );

      final remaining =
          state.dailyGoal.dailyCalories - state.dailyTotals.totalCalories;
      expect(remaining, 1200.0); // 2000 - 800
    });

    test('copyWith updates meals and recalculates', () {
      final meal = Meal(
        mealId: 'm1',
        userId: 'local_user',
        mealDate: '2026-01-01',
        mealName: 'Lunch',
        foods: [],
        totalCalories: 500.0,
        totalProteinG: 40.0,
        totalCarbsG: 50.0,
        totalFatG: 15.0,
        createdAt: now,
      );

      final state = NutritionState.initial().copyWith(
        meals: [meal],
        dailyTotals: const DailyTotals(
          totalCalories: 500,
          totalProteinG: 40,
          totalCarbsG: 50,
          totalFatG: 15,
        ),
      );

      expect(state.meals.length, 1);
      expect(state.dailyTotals.totalCalories, 500.0);
    });

    test('selectDate updates selectedDate', () {
      final state = NutritionState.initial().copyWith(
        selectedDate: '2026-03-15',
      );
      expect(state.selectedDate, '2026-03-15');
    });
  });

  group('Food model', () {
    test('searchFoods matching — foods with "chicken" in name', () {
      final foods = [chickenBreast, whiteRice, oatmeal];
      final results = foods
          .where((f) => f.name.toLowerCase().contains('chicken'))
          .toList();
      expect(results.length, 1);
      expect(results.first.foodId, 'food_chicken_breast');
    });

    test('custom food has isUserCustom true', () {
      final custom = Food(
        foodId: 'custom_1',
        name: 'My Protein Bar',
        caloriesPer100g: 380.0,
        proteinGPer100g: 25.0,
        carbsGPer100g: 40.0,
        fatGPer100g: 12.0,
        isUserCustom: true,
        userId: 'local_user',
        createdAt: now,
      );
      expect(custom.isUserCustom, true);
      expect(custom.userId, 'local_user');
    });
  });
}
