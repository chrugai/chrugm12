// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealImpl _$$MealImplFromJson(Map<String, dynamic> json) => _$MealImpl(
  mealId: json['mealId'] as String,
  userId: json['userId'] as String,
  mealDate: json['mealDate'] as String,
  mealName: json['mealName'] as String?,
  foods: (json['foods'] as List<dynamic>)
      .map((e) => MealFood.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCalories: (json['totalCalories'] as num).toDouble(),
  totalProteinG: (json['totalProteinG'] as num).toDouble(),
  totalCarbsG: (json['totalCarbsG'] as num).toDouble(),
  totalFatG: (json['totalFatG'] as num).toDouble(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  syncedToBackend: json['syncedToBackend'] as bool? ?? false,
);

Map<String, dynamic> _$$MealImplToJson(_$MealImpl instance) =>
    <String, dynamic>{
      'mealId': instance.mealId,
      'userId': instance.userId,
      'mealDate': instance.mealDate,
      'mealName': instance.mealName,
      'foods': instance.foods,
      'totalCalories': instance.totalCalories,
      'totalProteinG': instance.totalProteinG,
      'totalCarbsG': instance.totalCarbsG,
      'totalFatG': instance.totalFatG,
      'createdAt': instance.createdAt.toIso8601String(),
      'syncedToBackend': instance.syncedToBackend,
    };
