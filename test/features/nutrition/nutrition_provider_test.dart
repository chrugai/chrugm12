import 'package:chrugm12/data/models/daily_goal.dart';
import 'package:chrugm12/data/models/daily_totals.dart';
import 'package:chrugm12/data/models/food.dart';
import 'package:chrugm12/data/models/meal.dart';
import 'package:chrugm12/data/models/meal_food.dart';
import 'package:chrugm12/data/models/state/nutrition_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NutritionState', () {
    test('initial state has today date and empty meals', () {
      final state = NutritionState.initial();
      final today = DateTime.now().toIso8601String().substring(0, 10);
      expect(state.selectedDate, today);
      expect(state.meals, isEmpty);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
      expect(state.dailyGoal, defaultDailyGoal);
    });

    test('copyWith updates selected date', () {
      final state = NutritionState.initial();
      final updated = state.copyWith(selectedDate: '2026-03-15');
      expect(updated.selectedDate, '2026-03-15');
    });

    test('copyWith updates meals list', () {
      final state = NutritionState.initial();
      final meal = Meal(
        mealId: 'meal_1',
        userId: 'local_user',
        mealDate: '2026-03-11',
        mealName: 'Breakfast',
        foods: [],
        totalCalories: 500,
        totalProteinG: 30,
        totalCarbsG: 60,
        totalFatG: 15,
        createdAt: DateTime(2026, 3, 11),
      );
      final updated = state.copyWith(meals: [meal]);
      expect(updated.meals.length, 1);
      expect(updated.meals.first.mealName, 'Breakfast');
    });

    test('copyWith updates daily totals', () {
      final state = NutritionState.initial();
      const totals = DailyTotals(
        totalCalories: 1800,
        totalProteinG: 120,
        totalCarbsG: 180,
        totalFatG: 60,
      );
      final updated = state.copyWith(dailyTotals: totals);
      expect(updated.dailyTotals.totalCalories, 1800);
      expect(updated.dailyTotals.totalProteinG, 120);
    });

    test('MealFood computes macros from quantity', () {
      final food = Food(
        foodId: 'food_1',
        name: 'Chicken Breast',
        caloriesPer100g: 165,
        proteinGPer100g: 31,
        carbsGPer100g: 0,
        fatGPer100g: 3.6,
        createdAt: DateTime(2026, 1, 1),
      );
      final mealFood = MealFood(
        mealFoodId: 'mf_1',
        mealId: 'meal_1',
        food: food,
        quantityGrams: 200,
        createdAt: DateTime(2026, 3, 11),
      );
      expect(mealFood.calories, 330);
      expect(mealFood.proteinG, 62);
      expect(mealFood.carbsG, 0);
      expect(mealFood.fatG, closeTo(7.2, 0.01));
    });

    test('default daily goal has sensible values', () {
      expect(defaultDailyGoal.dailyCalories, 2000);
      expect(defaultDailyGoal.dailyProteinG, 150);
      expect(defaultDailyGoal.dailyCarbsG, 200);
      expect(defaultDailyGoal.dailyFatG, 65);
      expect(defaultDailyGoal.dailyFiberG, 30);
    });
  });
}
