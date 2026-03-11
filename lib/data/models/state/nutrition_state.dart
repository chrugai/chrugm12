import 'package:freezed_annotation/freezed_annotation.dart';

import '../daily_goal.dart';
import '../daily_totals.dart';
import '../meal.dart';

part 'nutrition_state.freezed.dart';
part 'nutrition_state.g.dart';

@freezed
abstract class NutritionState with _$NutritionState {
  const factory NutritionState({
    required String selectedDate,
    required List<Meal> meals,
    required DailyGoal dailyGoal,
    required DailyTotals dailyTotals,
    @Default(false) bool isLoading,
    String? error,
  }) = _NutritionState;

  factory NutritionState.initial() => NutritionState(
        selectedDate: DateTime.now().toIso8601String().substring(0, 10),
        meals: const [],
        dailyGoal: defaultDailyGoal,
        dailyTotals: const DailyTotals(),
      );

  factory NutritionState.fromJson(Map<String, dynamic> json) =>
      _$NutritionStateFromJson(json);
}
