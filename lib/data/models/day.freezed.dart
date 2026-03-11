// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Day _$DayFromJson(Map<String, dynamic> json) {
  return _Day.fromJson(json);
}

/// @nodoc
mixin _$Day {
  String get dayId => throw _privateConstructorUsedError;
  String get programId => throw _privateConstructorUsedError;
  int get dayNumber => throw _privateConstructorUsedError;
  String get dayName => throw _privateConstructorUsedError;
  List<Exercise> get exercises => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this Day to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Day
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DayCopyWith<Day> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DayCopyWith<$Res> {
  factory $DayCopyWith(Day value, $Res Function(Day) then) =
      _$DayCopyWithImpl<$Res, Day>;
  @useResult
  $Res call({
    String dayId,
    String programId,
    int dayNumber,
    String dayName,
    List<Exercise> exercises,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class _$DayCopyWithImpl<$Res, $Val extends Day> implements $DayCopyWith<$Res> {
  _$DayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Day
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayId = null,
    Object? programId = null,
    Object? dayNumber = null,
    Object? dayName = null,
    Object? exercises = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            dayId: null == dayId
                ? _value.dayId
                : dayId // ignore: cast_nullable_to_non_nullable
                      as String,
            programId: null == programId
                ? _value.programId
                : programId // ignore: cast_nullable_to_non_nullable
                      as String,
            dayNumber: null == dayNumber
                ? _value.dayNumber
                : dayNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            dayName: null == dayName
                ? _value.dayName
                : dayName // ignore: cast_nullable_to_non_nullable
                      as String,
            exercises: null == exercises
                ? _value.exercises
                : exercises // ignore: cast_nullable_to_non_nullable
                      as List<Exercise>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DayImplCopyWith<$Res> implements $DayCopyWith<$Res> {
  factory _$$DayImplCopyWith(_$DayImpl value, $Res Function(_$DayImpl) then) =
      __$$DayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String dayId,
    String programId,
    int dayNumber,
    String dayName,
    List<Exercise> exercises,
    DateTime createdAt,
    DateTime updatedAt,
  });
}

/// @nodoc
class __$$DayImplCopyWithImpl<$Res> extends _$DayCopyWithImpl<$Res, _$DayImpl>
    implements _$$DayImplCopyWith<$Res> {
  __$$DayImplCopyWithImpl(_$DayImpl _value, $Res Function(_$DayImpl) _then)
    : super(_value, _then);

  /// Create a copy of Day
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dayId = null,
    Object? programId = null,
    Object? dayNumber = null,
    Object? dayName = null,
    Object? exercises = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$DayImpl(
        dayId: null == dayId
            ? _value.dayId
            : dayId // ignore: cast_nullable_to_non_nullable
                  as String,
        programId: null == programId
            ? _value.programId
            : programId // ignore: cast_nullable_to_non_nullable
                  as String,
        dayNumber: null == dayNumber
            ? _value.dayNumber
            : dayNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        dayName: null == dayName
            ? _value.dayName
            : dayName // ignore: cast_nullable_to_non_nullable
                  as String,
        exercises: null == exercises
            ? _value._exercises
            : exercises // ignore: cast_nullable_to_non_nullable
                  as List<Exercise>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DayImpl implements _Day {
  const _$DayImpl({
    required this.dayId,
    required this.programId,
    required this.dayNumber,
    required this.dayName,
    required final List<Exercise> exercises,
    required this.createdAt,
    required this.updatedAt,
  }) : _exercises = exercises;

  factory _$DayImpl.fromJson(Map<String, dynamic> json) =>
      _$$DayImplFromJson(json);

  @override
  final String dayId;
  @override
  final String programId;
  @override
  final int dayNumber;
  @override
  final String dayName;
  final List<Exercise> _exercises;
  @override
  List<Exercise> get exercises {
    if (_exercises is EqualUnmodifiableListView) return _exercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercises);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'Day(dayId: $dayId, programId: $programId, dayNumber: $dayNumber, dayName: $dayName, exercises: $exercises, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DayImpl &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.programId, programId) ||
                other.programId == programId) &&
            (identical(other.dayNumber, dayNumber) ||
                other.dayNumber == dayNumber) &&
            (identical(other.dayName, dayName) || other.dayName == dayName) &&
            const DeepCollectionEquality().equals(
              other._exercises,
              _exercises,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    dayId,
    programId,
    dayNumber,
    dayName,
    const DeepCollectionEquality().hash(_exercises),
    createdAt,
    updatedAt,
  );

  /// Create a copy of Day
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DayImplCopyWith<_$DayImpl> get copyWith =>
      __$$DayImplCopyWithImpl<_$DayImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DayImplToJson(this);
  }
}

abstract class _Day implements Day {
  const factory _Day({
    required final String dayId,
    required final String programId,
    required final int dayNumber,
    required final String dayName,
    required final List<Exercise> exercises,
    required final DateTime createdAt,
    required final DateTime updatedAt,
  }) = _$DayImpl;

  factory _Day.fromJson(Map<String, dynamic> json) = _$DayImpl.fromJson;

  @override
  String get dayId;
  @override
  String get programId;
  @override
  int get dayNumber;
  @override
  String get dayName;
  @override
  List<Exercise> get exercises;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;

  /// Create a copy of Day
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DayImplCopyWith<_$DayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
