// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutSet _$WorkoutSetFromJson(Map<String, dynamic> json) {
  return _WorkoutSet.fromJson(json);
}

/// @nodoc
mixin _$WorkoutSet {
  String get setId => throw _privateConstructorUsedError;
  String get exerciseId => throw _privateConstructorUsedError;
  String get dayId => throw _privateConstructorUsedError;
  int get reps => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  int? get repsInReserve => throw _privateConstructorUsedError;
  String? get tempoVariation => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;
  bool get syncedToBackend => throw _privateConstructorUsedError;

  /// Serializes this WorkoutSet to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutSetCopyWith<WorkoutSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutSetCopyWith<$Res> {
  factory $WorkoutSetCopyWith(
    WorkoutSet value,
    $Res Function(WorkoutSet) then,
  ) = _$WorkoutSetCopyWithImpl<$Res, WorkoutSet>;
  @useResult
  $Res call({
    String setId,
    String exerciseId,
    String dayId,
    int reps,
    double weightKg,
    int? repsInReserve,
    String? tempoVariation,
    String? notes,
    DateTime timestamp,
    bool syncedToBackend,
  });
}

/// @nodoc
class _$WorkoutSetCopyWithImpl<$Res, $Val extends WorkoutSet>
    implements $WorkoutSetCopyWith<$Res> {
  _$WorkoutSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? exerciseId = null,
    Object? dayId = null,
    Object? reps = null,
    Object? weightKg = null,
    Object? repsInReserve = freezed,
    Object? tempoVariation = freezed,
    Object? notes = freezed,
    Object? timestamp = null,
    Object? syncedToBackend = null,
  }) {
    return _then(
      _value.copyWith(
            setId: null == setId
                ? _value.setId
                : setId // ignore: cast_nullable_to_non_nullable
                      as String,
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String,
            dayId: null == dayId
                ? _value.dayId
                : dayId // ignore: cast_nullable_to_non_nullable
                      as String,
            reps: null == reps
                ? _value.reps
                : reps // ignore: cast_nullable_to_non_nullable
                      as int,
            weightKg: null == weightKg
                ? _value.weightKg
                : weightKg // ignore: cast_nullable_to_non_nullable
                      as double,
            repsInReserve: freezed == repsInReserve
                ? _value.repsInReserve
                : repsInReserve // ignore: cast_nullable_to_non_nullable
                      as int?,
            tempoVariation: freezed == tempoVariation
                ? _value.tempoVariation
                : tempoVariation // ignore: cast_nullable_to_non_nullable
                      as String?,
            notes: freezed == notes
                ? _value.notes
                : notes // ignore: cast_nullable_to_non_nullable
                      as String?,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
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
abstract class _$$WorkoutSetImplCopyWith<$Res>
    implements $WorkoutSetCopyWith<$Res> {
  factory _$$WorkoutSetImplCopyWith(
    _$WorkoutSetImpl value,
    $Res Function(_$WorkoutSetImpl) then,
  ) = __$$WorkoutSetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String setId,
    String exerciseId,
    String dayId,
    int reps,
    double weightKg,
    int? repsInReserve,
    String? tempoVariation,
    String? notes,
    DateTime timestamp,
    bool syncedToBackend,
  });
}

/// @nodoc
class __$$WorkoutSetImplCopyWithImpl<$Res>
    extends _$WorkoutSetCopyWithImpl<$Res, _$WorkoutSetImpl>
    implements _$$WorkoutSetImplCopyWith<$Res> {
  __$$WorkoutSetImplCopyWithImpl(
    _$WorkoutSetImpl _value,
    $Res Function(_$WorkoutSetImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setId = null,
    Object? exerciseId = null,
    Object? dayId = null,
    Object? reps = null,
    Object? weightKg = null,
    Object? repsInReserve = freezed,
    Object? tempoVariation = freezed,
    Object? notes = freezed,
    Object? timestamp = null,
    Object? syncedToBackend = null,
  }) {
    return _then(
      _$WorkoutSetImpl(
        setId: null == setId
            ? _value.setId
            : setId // ignore: cast_nullable_to_non_nullable
                  as String,
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String,
        dayId: null == dayId
            ? _value.dayId
            : dayId // ignore: cast_nullable_to_non_nullable
                  as String,
        reps: null == reps
            ? _value.reps
            : reps // ignore: cast_nullable_to_non_nullable
                  as int,
        weightKg: null == weightKg
            ? _value.weightKg
            : weightKg // ignore: cast_nullable_to_non_nullable
                  as double,
        repsInReserve: freezed == repsInReserve
            ? _value.repsInReserve
            : repsInReserve // ignore: cast_nullable_to_non_nullable
                  as int?,
        tempoVariation: freezed == tempoVariation
            ? _value.tempoVariation
            : tempoVariation // ignore: cast_nullable_to_non_nullable
                  as String?,
        notes: freezed == notes
            ? _value.notes
            : notes // ignore: cast_nullable_to_non_nullable
                  as String?,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
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
class _$WorkoutSetImpl implements _WorkoutSet {
  const _$WorkoutSetImpl({
    required this.setId,
    required this.exerciseId,
    required this.dayId,
    required this.reps,
    required this.weightKg,
    this.repsInReserve,
    this.tempoVariation,
    this.notes,
    required this.timestamp,
    this.syncedToBackend = false,
  });

  factory _$WorkoutSetImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutSetImplFromJson(json);

  @override
  final String setId;
  @override
  final String exerciseId;
  @override
  final String dayId;
  @override
  final int reps;
  @override
  final double weightKg;
  @override
  final int? repsInReserve;
  @override
  final String? tempoVariation;
  @override
  final String? notes;
  @override
  final DateTime timestamp;
  @override
  @JsonKey()
  final bool syncedToBackend;

  @override
  String toString() {
    return 'WorkoutSet(setId: $setId, exerciseId: $exerciseId, dayId: $dayId, reps: $reps, weightKg: $weightKg, repsInReserve: $repsInReserve, tempoVariation: $tempoVariation, notes: $notes, timestamp: $timestamp, syncedToBackend: $syncedToBackend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutSetImpl &&
            (identical(other.setId, setId) || other.setId == setId) &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.dayId, dayId) || other.dayId == dayId) &&
            (identical(other.reps, reps) || other.reps == reps) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.repsInReserve, repsInReserve) ||
                other.repsInReserve == repsInReserve) &&
            (identical(other.tempoVariation, tempoVariation) ||
                other.tempoVariation == tempoVariation) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.syncedToBackend, syncedToBackend) ||
                other.syncedToBackend == syncedToBackend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    setId,
    exerciseId,
    dayId,
    reps,
    weightKg,
    repsInReserve,
    tempoVariation,
    notes,
    timestamp,
    syncedToBackend,
  );

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutSetImplCopyWith<_$WorkoutSetImpl> get copyWith =>
      __$$WorkoutSetImplCopyWithImpl<_$WorkoutSetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutSetImplToJson(this);
  }
}

abstract class _WorkoutSet implements WorkoutSet {
  const factory _WorkoutSet({
    required final String setId,
    required final String exerciseId,
    required final String dayId,
    required final int reps,
    required final double weightKg,
    final int? repsInReserve,
    final String? tempoVariation,
    final String? notes,
    required final DateTime timestamp,
    final bool syncedToBackend,
  }) = _$WorkoutSetImpl;

  factory _WorkoutSet.fromJson(Map<String, dynamic> json) =
      _$WorkoutSetImpl.fromJson;

  @override
  String get setId;
  @override
  String get exerciseId;
  @override
  String get dayId;
  @override
  int get reps;
  @override
  double get weightKg;
  @override
  int? get repsInReserve;
  @override
  String? get tempoVariation;
  @override
  String? get notes;
  @override
  DateTime get timestamp;
  @override
  bool get syncedToBackend;

  /// Create a copy of WorkoutSet
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutSetImplCopyWith<_$WorkoutSetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
