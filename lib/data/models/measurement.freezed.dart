// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'measurement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Measurement _$MeasurementFromJson(Map<String, dynamic> json) {
  return _Measurement.fromJson(json);
}

/// @nodoc
mixin _$Measurement {
  String get measurementId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get measurementDate => throw _privateConstructorUsedError;
  double? get neckCm => throw _privateConstructorUsedError;
  double? get shouldersCm => throw _privateConstructorUsedError;
  double? get chestCm => throw _privateConstructorUsedError;
  double? get bicepsLCm => throw _privateConstructorUsedError;
  double? get bicepsRCm => throw _privateConstructorUsedError;
  double? get forearmLCm => throw _privateConstructorUsedError;
  double? get forearmRCm => throw _privateConstructorUsedError;
  double? get waistCm => throw _privateConstructorUsedError;
  double? get hipsCm => throw _privateConstructorUsedError;
  double? get thighLCm => throw _privateConstructorUsedError;
  double? get thighRCm => throw _privateConstructorUsedError;
  double? get calvesLCm => throw _privateConstructorUsedError;
  double? get calvesRCm => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Measurement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeasurementCopyWith<Measurement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementCopyWith<$Res> {
  factory $MeasurementCopyWith(
    Measurement value,
    $Res Function(Measurement) then,
  ) = _$MeasurementCopyWithImpl<$Res, Measurement>;
  @useResult
  $Res call({
    String measurementId,
    String userId,
    String measurementDate,
    double? neckCm,
    double? shouldersCm,
    double? chestCm,
    double? bicepsLCm,
    double? bicepsRCm,
    double? forearmLCm,
    double? forearmRCm,
    double? waistCm,
    double? hipsCm,
    double? thighLCm,
    double? thighRCm,
    double? calvesLCm,
    double? calvesRCm,
    DateTime createdAt,
  });
}

/// @nodoc
class _$MeasurementCopyWithImpl<$Res, $Val extends Measurement>
    implements $MeasurementCopyWith<$Res> {
  _$MeasurementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measurementId = null,
    Object? userId = null,
    Object? measurementDate = null,
    Object? neckCm = freezed,
    Object? shouldersCm = freezed,
    Object? chestCm = freezed,
    Object? bicepsLCm = freezed,
    Object? bicepsRCm = freezed,
    Object? forearmLCm = freezed,
    Object? forearmRCm = freezed,
    Object? waistCm = freezed,
    Object? hipsCm = freezed,
    Object? thighLCm = freezed,
    Object? thighRCm = freezed,
    Object? calvesLCm = freezed,
    Object? calvesRCm = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            measurementId: null == measurementId
                ? _value.measurementId
                : measurementId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            measurementDate: null == measurementDate
                ? _value.measurementDate
                : measurementDate // ignore: cast_nullable_to_non_nullable
                      as String,
            neckCm: freezed == neckCm
                ? _value.neckCm
                : neckCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            shouldersCm: freezed == shouldersCm
                ? _value.shouldersCm
                : shouldersCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            chestCm: freezed == chestCm
                ? _value.chestCm
                : chestCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            bicepsLCm: freezed == bicepsLCm
                ? _value.bicepsLCm
                : bicepsLCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            bicepsRCm: freezed == bicepsRCm
                ? _value.bicepsRCm
                : bicepsRCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            forearmLCm: freezed == forearmLCm
                ? _value.forearmLCm
                : forearmLCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            forearmRCm: freezed == forearmRCm
                ? _value.forearmRCm
                : forearmRCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            waistCm: freezed == waistCm
                ? _value.waistCm
                : waistCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            hipsCm: freezed == hipsCm
                ? _value.hipsCm
                : hipsCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            thighLCm: freezed == thighLCm
                ? _value.thighLCm
                : thighLCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            thighRCm: freezed == thighRCm
                ? _value.thighRCm
                : thighRCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            calvesLCm: freezed == calvesLCm
                ? _value.calvesLCm
                : calvesLCm // ignore: cast_nullable_to_non_nullable
                      as double?,
            calvesRCm: freezed == calvesRCm
                ? _value.calvesRCm
                : calvesRCm // ignore: cast_nullable_to_non_nullable
                      as double?,
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
abstract class _$$MeasurementImplCopyWith<$Res>
    implements $MeasurementCopyWith<$Res> {
  factory _$$MeasurementImplCopyWith(
    _$MeasurementImpl value,
    $Res Function(_$MeasurementImpl) then,
  ) = __$$MeasurementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String measurementId,
    String userId,
    String measurementDate,
    double? neckCm,
    double? shouldersCm,
    double? chestCm,
    double? bicepsLCm,
    double? bicepsRCm,
    double? forearmLCm,
    double? forearmRCm,
    double? waistCm,
    double? hipsCm,
    double? thighLCm,
    double? thighRCm,
    double? calvesLCm,
    double? calvesRCm,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$MeasurementImplCopyWithImpl<$Res>
    extends _$MeasurementCopyWithImpl<$Res, _$MeasurementImpl>
    implements _$$MeasurementImplCopyWith<$Res> {
  __$$MeasurementImplCopyWithImpl(
    _$MeasurementImpl _value,
    $Res Function(_$MeasurementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? measurementId = null,
    Object? userId = null,
    Object? measurementDate = null,
    Object? neckCm = freezed,
    Object? shouldersCm = freezed,
    Object? chestCm = freezed,
    Object? bicepsLCm = freezed,
    Object? bicepsRCm = freezed,
    Object? forearmLCm = freezed,
    Object? forearmRCm = freezed,
    Object? waistCm = freezed,
    Object? hipsCm = freezed,
    Object? thighLCm = freezed,
    Object? thighRCm = freezed,
    Object? calvesLCm = freezed,
    Object? calvesRCm = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$MeasurementImpl(
        measurementId: null == measurementId
            ? _value.measurementId
            : measurementId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        measurementDate: null == measurementDate
            ? _value.measurementDate
            : measurementDate // ignore: cast_nullable_to_non_nullable
                  as String,
        neckCm: freezed == neckCm
            ? _value.neckCm
            : neckCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        shouldersCm: freezed == shouldersCm
            ? _value.shouldersCm
            : shouldersCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        chestCm: freezed == chestCm
            ? _value.chestCm
            : chestCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        bicepsLCm: freezed == bicepsLCm
            ? _value.bicepsLCm
            : bicepsLCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        bicepsRCm: freezed == bicepsRCm
            ? _value.bicepsRCm
            : bicepsRCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        forearmLCm: freezed == forearmLCm
            ? _value.forearmLCm
            : forearmLCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        forearmRCm: freezed == forearmRCm
            ? _value.forearmRCm
            : forearmRCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        waistCm: freezed == waistCm
            ? _value.waistCm
            : waistCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        hipsCm: freezed == hipsCm
            ? _value.hipsCm
            : hipsCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        thighLCm: freezed == thighLCm
            ? _value.thighLCm
            : thighLCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        thighRCm: freezed == thighRCm
            ? _value.thighRCm
            : thighRCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        calvesLCm: freezed == calvesLCm
            ? _value.calvesLCm
            : calvesLCm // ignore: cast_nullable_to_non_nullable
                  as double?,
        calvesRCm: freezed == calvesRCm
            ? _value.calvesRCm
            : calvesRCm // ignore: cast_nullable_to_non_nullable
                  as double?,
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
class _$MeasurementImpl implements _Measurement {
  const _$MeasurementImpl({
    required this.measurementId,
    required this.userId,
    required this.measurementDate,
    this.neckCm,
    this.shouldersCm,
    this.chestCm,
    this.bicepsLCm,
    this.bicepsRCm,
    this.forearmLCm,
    this.forearmRCm,
    this.waistCm,
    this.hipsCm,
    this.thighLCm,
    this.thighRCm,
    this.calvesLCm,
    this.calvesRCm,
    required this.createdAt,
  });

  factory _$MeasurementImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeasurementImplFromJson(json);

  @override
  final String measurementId;
  @override
  final String userId;
  @override
  final String measurementDate;
  @override
  final double? neckCm;
  @override
  final double? shouldersCm;
  @override
  final double? chestCm;
  @override
  final double? bicepsLCm;
  @override
  final double? bicepsRCm;
  @override
  final double? forearmLCm;
  @override
  final double? forearmRCm;
  @override
  final double? waistCm;
  @override
  final double? hipsCm;
  @override
  final double? thighLCm;
  @override
  final double? thighRCm;
  @override
  final double? calvesLCm;
  @override
  final double? calvesRCm;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Measurement(measurementId: $measurementId, userId: $userId, measurementDate: $measurementDate, neckCm: $neckCm, shouldersCm: $shouldersCm, chestCm: $chestCm, bicepsLCm: $bicepsLCm, bicepsRCm: $bicepsRCm, forearmLCm: $forearmLCm, forearmRCm: $forearmRCm, waistCm: $waistCm, hipsCm: $hipsCm, thighLCm: $thighLCm, thighRCm: $thighRCm, calvesLCm: $calvesLCm, calvesRCm: $calvesRCm, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeasurementImpl &&
            (identical(other.measurementId, measurementId) ||
                other.measurementId == measurementId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.measurementDate, measurementDate) ||
                other.measurementDate == measurementDate) &&
            (identical(other.neckCm, neckCm) || other.neckCm == neckCm) &&
            (identical(other.shouldersCm, shouldersCm) ||
                other.shouldersCm == shouldersCm) &&
            (identical(other.chestCm, chestCm) || other.chestCm == chestCm) &&
            (identical(other.bicepsLCm, bicepsLCm) ||
                other.bicepsLCm == bicepsLCm) &&
            (identical(other.bicepsRCm, bicepsRCm) ||
                other.bicepsRCm == bicepsRCm) &&
            (identical(other.forearmLCm, forearmLCm) ||
                other.forearmLCm == forearmLCm) &&
            (identical(other.forearmRCm, forearmRCm) ||
                other.forearmRCm == forearmRCm) &&
            (identical(other.waistCm, waistCm) || other.waistCm == waistCm) &&
            (identical(other.hipsCm, hipsCm) || other.hipsCm == hipsCm) &&
            (identical(other.thighLCm, thighLCm) ||
                other.thighLCm == thighLCm) &&
            (identical(other.thighRCm, thighRCm) ||
                other.thighRCm == thighRCm) &&
            (identical(other.calvesLCm, calvesLCm) ||
                other.calvesLCm == calvesLCm) &&
            (identical(other.calvesRCm, calvesRCm) ||
                other.calvesRCm == calvesRCm) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    measurementId,
    userId,
    measurementDate,
    neckCm,
    shouldersCm,
    chestCm,
    bicepsLCm,
    bicepsRCm,
    forearmLCm,
    forearmRCm,
    waistCm,
    hipsCm,
    thighLCm,
    thighRCm,
    calvesLCm,
    calvesRCm,
    createdAt,
  );

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeasurementImplCopyWith<_$MeasurementImpl> get copyWith =>
      __$$MeasurementImplCopyWithImpl<_$MeasurementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeasurementImplToJson(this);
  }
}

abstract class _Measurement implements Measurement {
  const factory _Measurement({
    required final String measurementId,
    required final String userId,
    required final String measurementDate,
    final double? neckCm,
    final double? shouldersCm,
    final double? chestCm,
    final double? bicepsLCm,
    final double? bicepsRCm,
    final double? forearmLCm,
    final double? forearmRCm,
    final double? waistCm,
    final double? hipsCm,
    final double? thighLCm,
    final double? thighRCm,
    final double? calvesLCm,
    final double? calvesRCm,
    required final DateTime createdAt,
  }) = _$MeasurementImpl;

  factory _Measurement.fromJson(Map<String, dynamic> json) =
      _$MeasurementImpl.fromJson;

  @override
  String get measurementId;
  @override
  String get userId;
  @override
  String get measurementDate;
  @override
  double? get neckCm;
  @override
  double? get shouldersCm;
  @override
  double? get chestCm;
  @override
  double? get bicepsLCm;
  @override
  double? get bicepsRCm;
  @override
  double? get forearmLCm;
  @override
  double? get forearmRCm;
  @override
  double? get waistCm;
  @override
  double? get hipsCm;
  @override
  double? get thighLCm;
  @override
  double? get thighRCm;
  @override
  double? get calvesLCm;
  @override
  double? get calvesRCm;
  @override
  DateTime get createdAt;

  /// Create a copy of Measurement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeasurementImplCopyWith<_$MeasurementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
