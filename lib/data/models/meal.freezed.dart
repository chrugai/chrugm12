// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Meal _$MealFromJson(Map<String, dynamic> json) {
  return _Meal.fromJson(json);
}

/// @nodoc
mixin _$Meal {
  String get mealId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get mealDate => throw _privateConstructorUsedError;
  String? get mealName => throw _privateConstructorUsedError;
  List<MealFood> get foods => throw _privateConstructorUsedError;
  double get totalCalories => throw _privateConstructorUsedError;
  double get totalProteinG => throw _privateConstructorUsedError;
  double get totalCarbsG => throw _privateConstructorUsedError;
  double get totalFatG => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get syncedToBackend => throw _privateConstructorUsedError;

  /// Serializes this Meal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealCopyWith<Meal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealCopyWith<$Res> {
  factory $MealCopyWith(Meal value, $Res Function(Meal) then) =
      _$MealCopyWithImpl<$Res, Meal>;
  @useResult
  $Res call({
    String mealId,
    String userId,
    String mealDate,
    String? mealName,
    List<MealFood> foods,
    double totalCalories,
    double totalProteinG,
    double totalCarbsG,
    double totalFatG,
    DateTime createdAt,
    bool syncedToBackend,
  });
}

/// @nodoc
class _$MealCopyWithImpl<$Res, $Val extends Meal>
    implements $MealCopyWith<$Res> {
  _$MealCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? userId = null,
    Object? mealDate = null,
    Object? mealName = freezed,
    Object? foods = null,
    Object? totalCalories = null,
    Object? totalProteinG = null,
    Object? totalCarbsG = null,
    Object? totalFatG = null,
    Object? createdAt = null,
    Object? syncedToBackend = null,
  }) {
    return _then(
      _value.copyWith(
            mealId: null == mealId
                ? _value.mealId
                : mealId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            mealDate: null == mealDate
                ? _value.mealDate
                : mealDate // ignore: cast_nullable_to_non_nullable
                      as String,
            mealName: freezed == mealName
                ? _value.mealName
                : mealName // ignore: cast_nullable_to_non_nullable
                      as String?,
            foods: null == foods
                ? _value.foods
                : foods // ignore: cast_nullable_to_non_nullable
                      as List<MealFood>,
            totalCalories: null == totalCalories
                ? _value.totalCalories
                : totalCalories // ignore: cast_nullable_to_non_nullable
                      as double,
            totalProteinG: null == totalProteinG
                ? _value.totalProteinG
                : totalProteinG // ignore: cast_nullable_to_non_nullable
                      as double,
            totalCarbsG: null == totalCarbsG
                ? _value.totalCarbsG
                : totalCarbsG // ignore: cast_nullable_to_non_nullable
                      as double,
            totalFatG: null == totalFatG
                ? _value.totalFatG
                : totalFatG // ignore: cast_nullable_to_non_nullable
                      as double,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            syncedToBackend: null == syncedToBackend
                ? _value.syncedToBackend
                : syncedToBackend // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MealImplCopyWith<$Res> implements $MealCopyWith<$Res> {
  factory _$$MealImplCopyWith(
    _$MealImpl value,
    $Res Function(_$MealImpl) then,
  ) = __$$MealImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String mealId,
    String userId,
    String mealDate,
    String? mealName,
    List<MealFood> foods,
    double totalCalories,
    double totalProteinG,
    double totalCarbsG,
    double totalFatG,
    DateTime createdAt,
    bool syncedToBackend,
  });
}

/// @nodoc
class __$$MealImplCopyWithImpl<$Res>
    extends _$MealCopyWithImpl<$Res, _$MealImpl>
    implements _$$MealImplCopyWith<$Res> {
  __$$MealImplCopyWithImpl(_$MealImpl _value, $Res Function(_$MealImpl) _then)
    : super(_value, _then);

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? mealId = null,
    Object? userId = null,
    Object? mealDate = null,
    Object? mealName = freezed,
    Object? foods = null,
    Object? totalCalories = null,
    Object? totalProteinG = null,
    Object? totalCarbsG = null,
    Object? totalFatG = null,
    Object? createdAt = null,
    Object? syncedToBackend = null,
  }) {
    return _then(
      _$MealImpl(
        mealId: null == mealId
            ? _value.mealId
            : mealId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        mealDate: null == mealDate
            ? _value.mealDate
            : mealDate // ignore: cast_nullable_to_non_nullable
                  as String,
        mealName: freezed == mealName
            ? _value.mealName
            : mealName // ignore: cast_nullable_to_non_nullable
                  as String?,
        foods: null == foods
            ? _value._foods
            : foods // ignore: cast_nullable_to_non_nullable
                  as List<MealFood>,
        totalCalories: null == totalCalories
            ? _value.totalCalories
            : totalCalories // ignore: cast_nullable_to_non_nullable
                  as double,
        totalProteinG: null == totalProteinG
            ? _value.totalProteinG
            : totalProteinG // ignore: cast_nullable_to_non_nullable
                  as double,
        totalCarbsG: null == totalCarbsG
            ? _value.totalCarbsG
            : totalCarbsG // ignore: cast_nullable_to_non_nullable
                  as double,
        totalFatG: null == totalFatG
            ? _value.totalFatG
            : totalFatG // ignore: cast_nullable_to_non_nullable
                  as double,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        syncedToBackend: null == syncedToBackend
            ? _value.syncedToBackend
            : syncedToBackend // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MealImpl implements _Meal {
  const _$MealImpl({
    required this.mealId,
    required this.userId,
    required this.mealDate,
    this.mealName,
    required final List<MealFood> foods,
    required this.totalCalories,
    required this.totalProteinG,
    required this.totalCarbsG,
    required this.totalFatG,
    required this.createdAt,
    this.syncedToBackend = false,
  }) : _foods = foods;

  factory _$MealImpl.fromJson(Map<String, dynamic> json) =>
      _$$MealImplFromJson(json);

  @override
  final String mealId;
  @override
  final String userId;
  @override
  final String mealDate;
  @override
  final String? mealName;
  final List<MealFood> _foods;
  @override
  List<MealFood> get foods {
    if (_foods is EqualUnmodifiableListView) return _foods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_foods);
  }

  @override
  final double totalCalories;
  @override
  final double totalProteinG;
  @override
  final double totalCarbsG;
  @override
  final double totalFatG;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool syncedToBackend;

  @override
  String toString() {
    return 'Meal(mealId: $mealId, userId: $userId, mealDate: $mealDate, mealName: $mealName, foods: $foods, totalCalories: $totalCalories, totalProteinG: $totalProteinG, totalCarbsG: $totalCarbsG, totalFatG: $totalFatG, createdAt: $createdAt, syncedToBackend: $syncedToBackend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealImpl &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.mealDate, mealDate) ||
                other.mealDate == mealDate) &&
            (identical(other.mealName, mealName) ||
                other.mealName == mealName) &&
            const DeepCollectionEquality().equals(other._foods, _foods) &&
            (identical(other.totalCalories, totalCalories) ||
                other.totalCalories == totalCalories) &&
            (identical(other.totalProteinG, totalProteinG) ||
                other.totalProteinG == totalProteinG) &&
            (identical(other.totalCarbsG, totalCarbsG) ||
                other.totalCarbsG == totalCarbsG) &&
            (identical(other.totalFatG, totalFatG) ||
                other.totalFatG == totalFatG) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.syncedToBackend, syncedToBackend) ||
                other.syncedToBackend == syncedToBackend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    mealId,
    userId,
    mealDate,
    mealName,
    const DeepCollectionEquality().hash(_foods),
    totalCalories,
    totalProteinG,
    totalCarbsG,
    totalFatG,
    createdAt,
    syncedToBackend,
  );

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      __$$MealImplCopyWithImpl<_$MealImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MealImplToJson(this);
  }
}

abstract class _Meal implements Meal {
  const factory _Meal({
    required final String mealId,
    required final String userId,
    required final String mealDate,
    final String? mealName,
    required final List<MealFood> foods,
    required final double totalCalories,
    required final double totalProteinG,
    required final double totalCarbsG,
    required final double totalFatG,
    required final DateTime createdAt,
    final bool syncedToBackend,
  }) = _$MealImpl;

  factory _Meal.fromJson(Map<String, dynamic> json) = _$MealImpl.fromJson;

  @override
  String get mealId;
  @override
  String get userId;
  @override
  String get mealDate;
  @override
  String? get mealName;
  @override
  List<MealFood> get foods;
  @override
  double get totalCalories;
  @override
  double get totalProteinG;
  @override
  double get totalCarbsG;
  @override
  double get totalFatG;
  @override
  DateTime get createdAt;
  @override
  bool get syncedToBackend;

  /// Create a copy of Meal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealImplCopyWith<_$MealImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
