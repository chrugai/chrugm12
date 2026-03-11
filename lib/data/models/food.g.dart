// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FoodImpl _$$FoodImplFromJson(Map<String, dynamic> json) => _$FoodImpl(
  foodId: json['foodId'] as String,
  name: json['name'] as String,
  caloriesPer100g: (json['caloriesPer100g'] as num).toDouble(),
  proteinGPer100g: (json['proteinGPer100g'] as num).toDouble(),
  carbsGPer100g: (json['carbsGPer100g'] as num).toDouble(),
  fatGPer100g: (json['fatGPer100g'] as num).toDouble(),
  isUserCustom: json['isUserCustom'] as bool? ?? false,
  userId: json['userId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$FoodImplToJson(_$FoodImpl instance) =>
    <String, dynamic>{
      'foodId': instance.foodId,
      'name': instance.name,
      'caloriesPer100g': instance.caloriesPer100g,
      'proteinGPer100g': instance.proteinGPer100g,
      'carbsGPer100g': instance.carbsGPer100g,
      'fatGPer100g': instance.fatGPer100g,
      'isUserCustom': instance.isUserCustom,
      'userId': instance.userId,
      'createdAt': instance.createdAt.toIso8601String(),
    };
