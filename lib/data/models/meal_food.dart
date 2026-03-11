import 'package:freezed_annotation/freezed_annotation.dart';

import 'food.dart';

part 'meal_food.freezed.dart';
part 'meal_food.g.dart';

@freezed
abstract class MealFood with _$MealFood {
  const MealFood._();

  const factory MealFood({
    required String mealFoodId,
    required String mealId,
    required Food food,
    required double quantityGrams,
    required DateTime createdAt,
  }) = _MealFood;

  factory MealFood.fromJson(Map<String, dynamic> json) =>
      _$MealFoodFromJson(json);

  double get calories => (food.caloriesPer100g * quantityGrams) / 100;
  double get proteinG => (food.proteinGPer100g * quantityGrams) / 100;
  double get carbsG => (food.carbsGPer100g * quantityGrams) / 100;
  double get fatG => (food.fatGPer100g * quantityGrams) / 100;
}
