// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MealFoodImpl _$$MealFoodImplFromJson(Map<String, dynamic> json) =>
    _$MealFoodImpl(
      mealFoodId: json['mealFoodId'] as String,
      mealId: json['mealId'] as String,
      food: Food.fromJson(json['food'] as Map<String, dynamic>),
      quantityGrams: (json['quantityGrams'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MealFoodImplToJson(_$MealFoodImpl instance) =>
    <String, dynamic>{
      'mealFoodId': instance.mealFoodId,
      'mealId': instance.mealId,
      'food': instance.food,
      'quantityGrams': instance.quantityGrams,
      'createdAt': instance.createdAt.toIso8601String(),
    };
