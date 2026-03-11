// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Food _$FoodFromJson(Map<String, dynamic> json) {
  return _Food.fromJson(json);
}

/// @nodoc
mixin _$Food {
  String get foodId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get caloriesPer100g => throw _privateConstructorUsedError;
  double get proteinGPer100g => throw _privateConstructorUsedError;
  double get carbsGPer100g => throw _privateConstructorUsedError;
  double get fatGPer100g => throw _privateConstructorUsedError;
  bool get isUserCustom => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Food to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodCopyWith<Food> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodCopyWith<$Res> {
  factory $FoodCopyWith(Food value, $Res Function(Food) then) =
      _$FoodCopyWithImpl<$Res, Food>;
  @useResult
  $Res call({
    String foodId,
    String name,
    double caloriesPer100g,
    double proteinGPer100g,
    double carbsGPer100g,
    double fatGPer100g,
    bool isUserCustom,
    String? userId,
    DateTime createdAt,
  });
}

/// @nodoc
class _$FoodCopyWithImpl<$Res, $Val extends Food>
    implements $FoodCopyWith<$Res> {
  _$FoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? name = null,
    Object? caloriesPer100g = null,
    Object? proteinGPer100g = null,
    Object? carbsGPer100g = null,
    Object? fatGPer100g = null,
    Object? isUserCustom = null,
    Object? userId = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            foodId: null == foodId
                ? _value.foodId
                : foodId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            caloriesPer100g: null == caloriesPer100g
                ? _value.caloriesPer100g
                : caloriesPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            proteinGPer100g: null == proteinGPer100g
                ? _value.proteinGPer100g
                : proteinGPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            carbsGPer100g: null == carbsGPer100g
                ? _value.carbsGPer100g
                : carbsGPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            fatGPer100g: null == fatGPer100g
                ? _value.fatGPer100g
                : fatGPer100g // ignore: cast_nullable_to_non_nullable
                      as double,
            isUserCustom: null == isUserCustom
                ? _value.isUserCustom
                : isUserCustom // ignore: cast_nullable_to_non_nullable
                      as bool,
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FoodImplCopyWith<$Res> implements $FoodCopyWith<$Res> {
  factory _$$FoodImplCopyWith(
    _$FoodImpl value,
    $Res Function(_$FoodImpl) then,
  ) = __$$FoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String foodId,
    String name,
    double caloriesPer100g,
    double proteinGPer100g,
    double carbsGPer100g,
    double fatGPer100g,
    bool isUserCustom,
    String? userId,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$FoodImplCopyWithImpl<$Res>
    extends _$FoodCopyWithImpl<$Res, _$FoodImpl>
    implements _$$FoodImplCopyWith<$Res> {
  __$$FoodImplCopyWithImpl(_$FoodImpl _value, $Res Function(_$FoodImpl) _then)
    : super(_value, _then);

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? foodId = null,
    Object? name = null,
    Object? caloriesPer100g = null,
    Object? proteinGPer100g = null,
    Object? carbsGPer100g = null,
    Object? fatGPer100g = null,
    Object? isUserCustom = null,
    Object? userId = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$FoodImpl(
        foodId: null == foodId
            ? _value.foodId
            : foodId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        caloriesPer100g: null == caloriesPer100g
            ? _value.caloriesPer100g
            : caloriesPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        proteinGPer100g: null == proteinGPer100g
            ? _value.proteinGPer100g
            : proteinGPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        carbsGPer100g: null == carbsGPer100g
            ? _value.carbsGPer100g
            : carbsGPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        fatGPer100g: null == fatGPer100g
            ? _value.fatGPer100g
            : fatGPer100g // ignore: cast_nullable_to_non_nullable
                  as double,
        isUserCustom: null == isUserCustom
            ? _value.isUserCustom
            : isUserCustom // ignore: cast_nullable_to_non_nullable
                  as bool,
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodImpl implements _Food {
  const _$FoodImpl({
    required this.foodId,
    required this.name,
    required this.caloriesPer100g,
    required this.proteinGPer100g,
    required this.carbsGPer100g,
    required this.fatGPer100g,
    this.isUserCustom = false,
    this.userId,
    required this.createdAt,
  });

  factory _$FoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodImplFromJson(json);

  @override
  final String foodId;
  @override
  final String name;
  @override
  final double caloriesPer100g;
  @override
  final double proteinGPer100g;
  @override
  final double carbsGPer100g;
  @override
  final double fatGPer100g;
  @override
  @JsonKey()
  final bool isUserCustom;
  @override
  final String? userId;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Food(foodId: $foodId, name: $name, caloriesPer100g: $caloriesPer100g, proteinGPer100g: $proteinGPer100g, carbsGPer100g: $carbsGPer100g, fatGPer100g: $fatGPer100g, isUserCustom: $isUserCustom, userId: $userId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodImpl &&
            (identical(other.foodId, foodId) || other.foodId == foodId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.caloriesPer100g, caloriesPer100g) ||
                other.caloriesPer100g == caloriesPer100g) &&
            (identical(other.proteinGPer100g, proteinGPer100g) ||
                other.proteinGPer100g == proteinGPer100g) &&
            (identical(other.carbsGPer100g, carbsGPer100g) ||
                other.carbsGPer100g == carbsGPer100g) &&
            (identical(other.fatGPer100g, fatGPer100g) ||
                other.fatGPer100g == fatGPer100g) &&
            (identical(other.isUserCustom, isUserCustom) ||
                other.isUserCustom == isUserCustom) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    foodId,
    name,
    caloriesPer100g,
    proteinGPer100g,
    carbsGPer100g,
    fatGPer100g,
    isUserCustom,
    userId,
    createdAt,
  );

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      __$$FoodImplCopyWithImpl<_$FoodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodImplToJson(this);
  }
}

abstract class _Food implements Food {
  const factory _Food({
    required final String foodId,
    required final String name,
    required final double caloriesPer100g,
    required final double proteinGPer100g,
    required final double carbsGPer100g,
    required final double fatGPer100g,
    final bool isUserCustom,
    final String? userId,
    required final DateTime createdAt,
  }) = _$FoodImpl;

  factory _Food.fromJson(Map<String, dynamic> json) = _$FoodImpl.fromJson;

  @override
  String get foodId;
  @override
  String get name;
  @override
  double get caloriesPer100g;
  @override
  double get proteinGPer100g;
  @override
  double get carbsGPer100g;
  @override
  double get fatGPer100g;
  @override
  bool get isUserCustom;
  @override
  String? get userId;
  @override
  DateTime get createdAt;

  /// Create a copy of Food
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodImplCopyWith<_$FoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
