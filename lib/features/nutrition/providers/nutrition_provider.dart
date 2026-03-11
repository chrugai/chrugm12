import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/food.dart' as models;
import '../../../data/models/state/nutrition_state.dart';
import '../services/nutrition_service.dart';

final nutritionServiceProvider = Provider<NutritionService>((ref) {
  final db = ref.watch(databaseProvider);
  return NutritionService(db);
});

final nutritionProvider =
    StateNotifierProvider<NutritionNotifier, NutritionState>((ref) {
  final service = ref.watch(nutritionServiceProvider);
  return NutritionNotifier(service);
});

class NutritionNotifier extends StateNotifier<NutritionState> {
  NutritionNotifier(this._service) : super(NutritionState.initial());

  final NutritionService _service;

  Future<void> loadMealsForDate(String date) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final meals = await _service.getMealsForDate('local_user', date);
      final totals = _service.calculateDailyTotals(meals);
      state = state.copyWith(
        meals: meals,
        dailyTotals: totals,
        selectedDate: date,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> selectDate(String isoDate) async {
    state = state.copyWith(selectedDate: isoDate);
    await loadMealsForDate(isoDate);
  }

  Future<void> addFood(models.Food food, {double quantityGrams = 100}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.addFoodToMeal(
        userId: 'local_user',
        date: state.selectedDate,
        food: food,
        quantityGrams: quantityGrams,
      );
      await loadMealsForDate(state.selectedDate);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteMeal(String mealId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.deleteMeal(mealId);
      final meals = state.meals.where((m) => m.mealId != mealId).toList();
      final totals = _service.calculateDailyTotals(meals);
      state = state.copyWith(
        meals: meals,
        dailyTotals: totals,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<models.Food> createCustomFood({
    required String name,
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
  }) async {
    return _service.createCustomFood(
      name: name,
      caloriesPer100g: caloriesPer100g,
      proteinGPer100g: proteinGPer100g,
      carbsGPer100g: carbsGPer100g,
      fatGPer100g: fatGPer100g,
      userId: 'local_user',
    );
  }

  Future<List<models.Food>> searchFoods(String query) {
    return _service.searchFoods(query);
  }

  Future<List<models.Food>> getRecentFoods() {
    return _service.getRecentFoods('local_user');
  }

  double get remainingCalories =>
      state.dailyGoal.dailyCalories - state.dailyTotals.totalCalories;
}
