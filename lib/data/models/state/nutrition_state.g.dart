// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NutritionStateImpl _$$NutritionStateImplFromJson(Map<String, dynamic> json) =>
    _$NutritionStateImpl(
      selectedDate: json['selectedDate'] as String,
      meals: (json['meals'] as List<dynamic>)
          .map((e) => Meal.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyGoal: DailyGoal.fromJson(json['dailyGoal'] as Map<String, dynamic>),
      dailyTotals: DailyTotals.fromJson(
        json['dailyTotals'] as Map<String, dynamic>,
      ),
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$NutritionStateImplToJson(
  _$NutritionStateImpl instance,
) => <String, dynamic>{
  'selectedDate': instance.selectedDate,
  'meals': instance.meals,
  'dailyGoal': instance.dailyGoal,
  'dailyTotals': instance.dailyTotals,
  'isLoading': instance.isLoading,
  'error': instance.error,
};
