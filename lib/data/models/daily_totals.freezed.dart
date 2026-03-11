// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_totals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyTotals _$DailyTotalsFromJson(Map<String, dynamic> json) {
  return _DailyTotals.fromJson(json);
}

/// @nodoc
mixin _$DailyTotals {
  double get totalCalories => throw _privateConstructorUsedError;
  double get totalProteinG => throw _privateConstructorUsedError;
  double get totalCarbsG => throw _privateConstructorUsedError;
  double get totalFatG => throw _privateConstructorUsedError;
  double get totalFiberG => throw _privateConstructorUsedError;

  /// Serializes this DailyTotals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyTotalsCopyWith<DailyTotals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyTotalsCopyWith<$Res> {
  factory $DailyTotalsCopyWith(
    DailyTotals value,
    $Res Function(DailyTotals) then,
  ) = _$DailyTotalsCopyWithImpl<$Res, DailyTotals>;
  @useResult
  $Res call({
    double totalCalories,
    double totalProteinG,
    double totalCarbsG,
    double totalFatG,
    double totalFiberG,
  });
}

/// @nodoc
class _$DailyTotalsCopyWithImpl<$Res, $Val extends DailyTotals>
    implements $DailyTotalsCopyWith<$Res> {
  _$DailyTotalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCalories = null,
    Object? totalProteinG = null,
    Object? totalCarbsG = null,
    Object? totalFatG = null,
    Object? totalFiberG = null,
  }) {
    return _then(
      _value.copyWith(
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
            totalFiberG: null == totalFiberG
                ? _value.totalFiberG
                : totalFiberG // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyTotalsImplCopyWith<$Res>
    implements $DailyTotalsCopyWith<$Res> {
  factory _$$DailyTotalsImplCopyWith(
    _$DailyTotalsImpl value,
    $Res Function(_$DailyTotalsImpl) then,
  ) = __$$DailyTotalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    double totalCalories,
    double totalProteinG,
    double totalCarbsG,
    double totalFatG,
    double totalFiberG,
  });
}

/// @nodoc
class __$$DailyTotalsImplCopyWithImpl<$Res>
    extends _$DailyTotalsCopyWithImpl<$Res, _$DailyTotalsImpl>
    implements _$$DailyTotalsImplCopyWith<$Res> {
  __$$DailyTotalsImplCopyWithImpl(
    _$DailyTotalsImpl _value,
    $Res Function(_$DailyTotalsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalCalories = null,
    Object? totalProteinG = null,
    Object? totalCarbsG = null,
    Object? totalFatG = null,
    Object? totalFiberG = null,
  }) {
    return _then(
      _$DailyTotalsImpl(
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
        totalFiberG: null == totalFiberG
            ? _value.totalFiberG
            : totalFiberG // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyTotalsImpl implements _DailyTotals {
  const _$DailyTotalsImpl({
    this.totalCalories = 0,
    this.totalProteinG = 0,
    this.totalCarbsG = 0,
    this.totalFatG = 0,
    this.totalFiberG = 0,
  });

  factory _$DailyTotalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyTotalsImplFromJson(json);

  @override
  @JsonKey()
  final double totalCalories;
  @override
  @JsonKey()
  final double totalProteinG;
  @override
  @JsonKey()
  final double totalCarbsG;
  @override
  @JsonKey()
  final double totalFatG;
  @override
  @JsonKey()
  final double totalFiberG;

  @override
  String toString() {
    return 'DailyTotals(totalCalories: $totalCalories, totalProteinG: $totalProteinG, totalCarbsG: $totalCarbsG, totalFatG: $totalFatG, totalFiberG: $totalFiberG)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyTotalsImpl &&
            (identical(other.totalCalories, totalCalories) ||
                other.totalCalories == totalCalories) &&
            (identical(other.totalProteinG, totalProteinG) ||
                other.totalProteinG == totalProteinG) &&
            (identical(other.totalCarbsG, totalCarbsG) ||
                other.totalCarbsG == totalCarbsG) &&
            (identical(other.totalFatG, totalFatG) ||
                other.totalFatG == totalFatG) &&
            (identical(other.totalFiberG, totalFiberG) ||
                other.totalFiberG == totalFiberG));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    totalCalories,
    totalProteinG,
    totalCarbsG,
    totalFatG,
    totalFiberG,
  );

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyTotalsImplCopyWith<_$DailyTotalsImpl> get copyWith =>
      __$$DailyTotalsImplCopyWithImpl<_$DailyTotalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyTotalsImplToJson(this);
  }
}

abstract class _DailyTotals implements DailyTotals {
  const factory _DailyTotals({
    final double totalCalories,
    final double totalProteinG,
    final double totalCarbsG,
    final double totalFatG,
    final double totalFiberG,
  }) = _$DailyTotalsImpl;

  factory _DailyTotals.fromJson(Map<String, dynamic> json) =
      _$DailyTotalsImpl.fromJson;

  @override
  double get totalCalories;
  @override
  double get totalProteinG;
  @override
  double get totalCarbsG;
  @override
  double get totalFatG;
  @override
  double get totalFiberG;

  /// Create a copy of DailyTotals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyTotalsImplCopyWith<_$DailyTotalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
