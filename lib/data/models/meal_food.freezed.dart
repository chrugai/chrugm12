// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_food.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

MealFood _$MealFoodFromJson(Map<String, dynamic> json) {
  return _MealFood.fromJson(json);
}

/// @nodoc
mixin _$MealFood {
  String get mealFoodId => throw _privateConstructorUsedError;
  String get mealId => throw _privateConstructorUsedError;
  Food get food => throw _privateConstructorUsedError;
  double get quantityGrams => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this MealFood to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MealFood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealFoodCopyWith<MealFood> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealFoodCopyWith<$Res> {
  factory $MealFoodCopyWith(MealFood value, $Res Function(MealFood) then) =
      _$MealFoodCopyWithImpl<$Res, MealFood>;
  @useResult
  $Res call({
    String mealFoodId,
    String mealId,
    Food food,
    double quantityGrams,
    DateTime createdAt,
  });

  $FoodCopyWith<$Res> get food;
}

/// @nodoc
class _$MealFoodCopyWithImpl<$Res, $Val extends MealFood>
    implements $MealFoodCopyWith<$Res> {
  _$MealFoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealFood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealFoodId = null,
    Object? mealId = null,
    Object? food = null,
    Object? quantityGrams = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            mealFoodId: null == mealFoodId
                ? _value.mealFoodId
                : mealFoodId // ignore: cast_nullable_to_non_nullable
                      as String,
            mealId: null == mealId
                ? _value.mealId
                : mealId // ignore: cast_nullable_to_non_nullable
                      as String,
            food: null == food
                ? _value.food
                : food // ignore: cast_nullable_to_non_nullable
                      as Food,
            quantityGrams: null == quantityGrams
                ? _value.quantityGrams
                : quantityGrams // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }

  /// Create a copy of MealFood
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodCopyWith<$Res> get food {
    return $FoodCopyWith<$Res>(_value.food, (value) {
      return _then(_value.copyWith(food: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MealFoodImplCopyWith<$Res>
    implements $MealFoodCopyWith<$Res> {
  factory _$$MealFoodImplCopyWith(
    _$MealFoodImpl value,
    $Res Function(_$MealFoodImpl) then,
  ) = __$$MealFoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String mealFoodId,
    String mealId,
    Food food,
    double quantityGrams,
    DateTime createdAt,
  });

  @override
  $FoodCopyWith<$Res> get food;
}

/// @nodoc
class __$$MealFoodImplCopyWithImpl<$Res>
    extends _$MealFoodCopyWithImpl<$Res, _$MealFoodImpl>
    implements _$$MealFoodImplCopyWith<$Res> {
  __$$MealFoodImplCopyWithImpl(
    _$MealFoodImpl _value,
    $Res Function(_$MealFoodImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MealFood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealFoodId = null,
    Object? mealId = null,
    Object? food = null,
    Object? quantityGrams = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$MealFoodImpl(
        mealFoodId: null == mealFoodId
            ? _value.mealFoodId
            : mealFoodId // ignore: cast_nullable_to_non_nullable
                  as String,
        mealId: null == mealId
            ? _value.mealId
            : mealId // ignore: cast_nullable_to_non_nullable
                  as String,
        food: null == food
            ? _value.food
            : food // ignore: cast_nullable_to_non_nullable
                  as Food,
        quantityGrams: null == quantityGrams
            ? _value.quantityGrams
            : quantityGrams // ignore: cast_nullable_to_non_nullable
                  as double,
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
class _$MealFoodImpl extends _MealFood {
  const _$MealFoodImpl({
    required this.mealFoodId,
    required this.mealId,
    required this.food,
    required this.quantityGrams,
    required this.createdAt,
  }) : super._();

  factory _$MealFoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealFoodImplFromJson(json);

  @override
  final String mealFoodId;
  @override
  final String mealId;
  @override
  final Food food;
  @override
  final double quantityGrams;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'MealFood(mealFoodId: $mealFoodId, mealId: $mealId, food: $food, quantityGrams: $quantityGrams, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealFoodImpl &&
            (identical(other.mealFoodId, mealFoodId) ||
                other.mealFoodId == mealFoodId) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.food, food) || other.food == food) &&
            (identical(other.quantityGrams, quantityGrams) ||
                other.quantityGrams == quantityGrams) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mealFoodId,
    mealId,
    food,
    quantityGrams,
    createdAt,
  );

  /// Create a copy of MealFood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealFoodImplCopyWith<_$MealFoodImpl> get copyWith =>
      __$$MealFoodImplCopyWithImpl<_$MealFoodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealFoodImplToJson(this);
  }
}

abstract class _MealFood extends MealFood {
  const factory _MealFood({
    required final String mealFoodId,
    required final String mealId,
    required final Food food,
    required final double quantityGrams,
    required final DateTime createdAt,
  }) = _$MealFoodImpl;
  const _MealFood._() : super._();

  factory _MealFood.fromJson(Map<String, dynamic> json) =
      _$MealFoodImpl.fromJson;

  @override
  String get mealFoodId;
  @override
  String get mealId;
  @override
  Food get food;
  @override
  double get quantityGrams;
  @override
  DateTime get createdAt;

  /// Create a copy of MealFood
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealFoodImplCopyWith<_$MealFoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
