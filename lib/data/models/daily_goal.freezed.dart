// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyGoal _$DailyGoalFromJson(Map<String, dynamic> json) {
  return _DailyGoal.fromJson(json);
}

/// @nodoc
mixin _$DailyGoal {
  double get dailyCalories => throw _privateConstructorUsedError;
  double get dailyProteinG => throw _privateConstructorUsedError;
  double get dailyCarbsG => throw _privateConstructorUsedError;
  double get dailyFatG => throw _privateConstructorUsedError;
  double get dailyFiberG => throw _privateConstructorUsedError;

  /// Serializes this DailyGoal to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyGoalCopyWith<DailyGoal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyGoalCopyWith<$Res> {
  factory $DailyGoalCopyWith(DailyGoal value, $Res Function(DailyGoal) then) =
      _$DailyGoalCopyWithImpl<$Res, DailyGoal>;
  @useResult
  $Res call({
    double dailyCalories,
    double dailyProteinG,
    double dailyCarbsG,
    double dailyFatG,
    double dailyFiberG,
  });
}

/// @nodoc
class _$DailyGoalCopyWithImpl<$Res, $Val extends DailyGoal>
    implements $DailyGoalCopyWith<$Res> {
  _$DailyGoalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyCalories = null,
    Object? dailyProteinG = null,
    Object? dailyCarbsG = null,
    Object? dailyFatG = null,
    Object? dailyFiberG = null,
  }) {
    return _then(
      _value.copyWith(
            dailyCalories: null == dailyCalories
                ? _value.dailyCalories
                : dailyCalories // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyProteinG: null == dailyProteinG
                ? _value.dailyProteinG
                : dailyProteinG // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyCarbsG: null == dailyCarbsG
                ? _value.dailyCarbsG
                : dailyCarbsG // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyFatG: null == dailyFatG
                ? _value.dailyFatG
                : dailyFatG // ignore: cast_nullable_to_non_nullable
                      as double,
            dailyFiberG: null == dailyFiberG
                ? _value.dailyFiberG
                : dailyFiberG // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyGoalImplCopyWith<$Res>
    implements $DailyGoalCopyWith<$Res> {
  factory _$$DailyGoalImplCopyWith(
    _$DailyGoalImpl value,
    $Res Function(_$DailyGoalImpl) then,
  ) = __$$DailyGoalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double dailyCalories,
    double dailyProteinG,
    double dailyCarbsG,
    double dailyFatG,
    double dailyFiberG,
  });
}

/// @nodoc
class __$$DailyGoalImplCopyWithImpl<$Res>
    extends _$DailyGoalCopyWithImpl<$Res, _$DailyGoalImpl>
    implements _$$DailyGoalImplCopyWith<$Res> {
  __$$DailyGoalImplCopyWithImpl(
    _$DailyGoalImpl _value,
    $Res Function(_$DailyGoalImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyGoal
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dailyCalories = null,
    Object? dailyProteinG = null,
    Object? dailyCarbsG = null,
    Object? dailyFatG = null,
    Object? dailyFiberG = null,
  }) {
    return _then(
      _$DailyGoalImpl(
        dailyCalories: null == dailyCalories
            ? _value.dailyCalories
            : dailyCalories // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyProteinG: null == dailyProteinG
            ? _value.dailyProteinG
            : dailyProteinG // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyCarbsG: null == dailyCarbsG
            ? _value.dailyCarbsG
            : dailyCarbsG // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyFatG: null == dailyFatG
            ? _value.dailyFatG
            : dailyFatG // ignore: cast_nullable_to_non_nullable
                  as double,
        dailyFiberG: null == dailyFiberG
            ? _value.dailyFiberG
            : dailyFiberG // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyGoalImpl implements _DailyGoal {
  const _$DailyGoalImpl({
    required this.dailyCalories,
    required this.dailyProteinG,
    required this.dailyCarbsG,
    required this.dailyFatG,
    required this.dailyFiberG,
  });

  factory _$DailyGoalImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyGoalImplFromJson(json);

  @override
  final double dailyCalories;
  @override
  final double dailyProteinG;
  @override
  final double dailyCarbsG;
  @override
  final double dailyFatG;
  @override
  final double dailyFiberG;

  @override
  String toString() {
    return 'DailyGoal(dailyCalories: $dailyCalories, dailyProteinG: $dailyProteinG, dailyCarbsG: $dailyCarbsG, dailyFatG: $dailyFatG, dailyFiberG: $dailyFiberG)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyGoalImpl &&
            (identical(other.dailyCalories, dailyCalories) ||
                other.dailyCalories == dailyCalories) &&
            (identical(other.dailyProteinG, dailyProteinG) ||
                other.dailyProteinG == dailyProteinG) &&
            (identical(other.dailyCarbsG, dailyCarbsG) ||
                other.dailyCarbsG == dailyCarbsG) &&
            (identical(other.dailyFatG, dailyFatG) ||
                other.dailyFatG == dailyFatG) &&
            (identical(other.dailyFiberG, dailyFiberG) ||
                other.dailyFiberG == dailyFiberG));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dailyCalories,
    dailyProteinG,
    dailyCarbsG,
    dailyFatG,
    dailyFiberG,
  );

  /// Create a copy of DailyGoal
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyGoalImplCopyWith<_$DailyGoalImpl> get copyWith =>
      __$$DailyGoalImplCopyWithImpl<_$DailyGoalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyGoalImplToJson(this);
  }
}

abstract class _DailyGoal implements DailyGoal {
  const factory _DailyGoal({
    required final double dailyCalories,
    required final double dailyProteinG,
    required final double dailyCarbsG,
    required final double dailyFatG,
    required final double dailyFiberG,
  }) = _$DailyGoalImpl;

  factory _DailyGoal.fromJson(Map<String, dynamic> json) =
      _$DailyGoalImpl.fromJson;

  @override
  double get dailyCalories;
  @override
  double get dailyProteinG;
  @override
  double get dailyCarbsG;
  @override
  double get dailyFatG;
  @override
  double get dailyFiberG;

  /// Create a copy of DailyGoal
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyGoalImplCopyWith<_$DailyGoalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
