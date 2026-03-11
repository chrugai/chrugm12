import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';
part 'food.g.dart';

@freezed
abstract class Food with _$Food {
  const factory Food({
    required String foodId,
    required String name,
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
    @Default(false) bool isUserCustom,
    String? userId,
    required DateTime createdAt,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}
