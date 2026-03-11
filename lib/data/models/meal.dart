import 'package:freezed_annotation/freezed_annotation.dart';

import 'meal_food.dart';

part 'meal.freezed.dart';
part 'meal.g.dart';

@freezed
abstract class Meal with _$Meal {
  const factory Meal({
    required String mealId,
    required String userId,
    required String mealDate,
    String? mealName,
    required List<MealFood> foods,
    required double totalCalories,
    required double totalProteinG,
    required double totalCarbsG,
    required double totalFatG,
    required DateTime createdAt,
    @Default(false) bool syncedToBackend,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}
