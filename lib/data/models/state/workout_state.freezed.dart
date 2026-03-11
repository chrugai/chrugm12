// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkoutState _$WorkoutStateFromJson(Map<String, dynamic> json) {
  return _WorkoutState.fromJson(json);
}

/// @nodoc
mixin _$WorkoutState {
  String? get selectedDayId => throw _privateConstructorUsedError;
  List<Exercise> get currentDayExercises => throw _privateConstructorUsedError;
  List<WorkoutSet> get loggedSets => throw _privateConstructorUsedError;
  bool get restTimerActive => throw _privateConstructorUsedError;
  int get selectedRestTimeSeconds => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this WorkoutState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkoutStateCopyWith<WorkoutState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkoutStateCopyWith<$Res> {
  factory $WorkoutStateCopyWith(
    WorkoutState value,
    $Res Function(WorkoutState) then,
  ) = _$WorkoutStateCopyWithImpl<$Res, WorkoutState>;
  @useResult
  $Res call({
    String? selectedDayId,
    List<Exercise> currentDayExercises,
    List<WorkoutSet> loggedSets,
    bool restTimerActive,
    int selectedRestTimeSeconds,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class _$WorkoutStateCopyWithImpl<$Res, $Val extends WorkoutState>
    implements $WorkoutStateCopyWith<$Res> {
  _$WorkoutStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDayId = freezed,
    Object? currentDayExercises = null,
    Object? loggedSets = null,
    Object? restTimerActive = null,
    Object? selectedRestTimeSeconds = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedDayId: freezed == selectedDayId
                ? _value.selectedDayId
                : selectedDayId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentDayExercises: null == currentDayExercises
                ? _value.currentDayExercises
                : currentDayExercises // ignore: cast_nullable_to_non_nullable
                      as List<Exercise>,
            loggedSets: null == loggedSets
                ? _value.loggedSets
                : loggedSets // ignore: cast_nullable_to_non_nullable
                      as List<WorkoutSet>,
            restTimerActive: null == restTimerActive
                ? _value.restTimerActive
                : restTimerActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            selectedRestTimeSeconds: null == selectedRestTimeSeconds
                ? _value.selectedRestTimeSeconds
                : selectedRestTimeSeconds // ignore: cast_nullable_to_non_nullable
                      as int,
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkoutStateImplCopyWith<$Res>
    implements $WorkoutStateCopyWith<$Res> {
  factory _$$WorkoutStateImplCopyWith(
    _$WorkoutStateImpl value,
    $Res Function(_$WorkoutStateImpl) then,
  ) = __$$WorkoutStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? selectedDayId,
    List<Exercise> currentDayExercises,
    List<WorkoutSet> loggedSets,
    bool restTimerActive,
    int selectedRestTimeSeconds,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class __$$WorkoutStateImplCopyWithImpl<$Res>
    extends _$WorkoutStateCopyWithImpl<$Res, _$WorkoutStateImpl>
    implements _$$WorkoutStateImplCopyWith<$Res> {
  __$$WorkoutStateImplCopyWithImpl(
    _$WorkoutStateImpl _value,
    $Res Function(_$WorkoutStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDayId = freezed,
    Object? currentDayExercises = null,
    Object? loggedSets = null,
    Object? restTimerActive = null,
    Object? selectedRestTimeSeconds = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$WorkoutStateImpl(
        selectedDayId: freezed == selectedDayId
            ? _value.selectedDayId
            : selectedDayId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentDayExercises: null == currentDayExercises
            ? _value._currentDayExercises
            : currentDayExercises // ignore: cast_nullable_to_non_nullable
                  as List<Exercise>,
        loggedSets: null == loggedSets
            ? _value._loggedSets
            : loggedSets // ignore: cast_nullable_to_non_nullable
                  as List<WorkoutSet>,
        restTimerActive: null == restTimerActive
            ? _value.restTimerActive
            : restTimerActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        selectedRestTimeSeconds: null == selectedRestTimeSeconds
            ? _value.selectedRestTimeSeconds
            : selectedRestTimeSeconds // ignore: cast_nullable_to_non_nullable
                  as int,
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkoutStateImpl implements _WorkoutState {
  const _$WorkoutStateImpl({
    this.selectedDayId,
    required final List<Exercise> currentDayExercises,
    required final List<WorkoutSet> loggedSets,
    this.restTimerActive = false,
    this.selectedRestTimeSeconds = 180,
    this.isLoading = false,
    this.error,
  }) : _currentDayExercises = currentDayExercises,
       _loggedSets = loggedSets;

  factory _$WorkoutStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkoutStateImplFromJson(json);

  @override
  final String? selectedDayId;
  final List<Exercise> _currentDayExercises;
  @override
  List<Exercise> get currentDayExercises {
    if (_currentDayExercises is EqualUnmodifiableListView)
      return _currentDayExercises;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentDayExercises);
  }

  final List<WorkoutSet> _loggedSets;
  @override
  List<WorkoutSet> get loggedSets {
    if (_loggedSets is EqualUnmodifiableListView) return _loggedSets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_loggedSets);
  }

  @override
  @JsonKey()
  final bool restTimerActive;
  @override
  @JsonKey()
  final int selectedRestTimeSeconds;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'WorkoutState(selectedDayId: $selectedDayId, currentDayExercises: $currentDayExercises, loggedSets: $loggedSets, restTimerActive: $restTimerActive, selectedRestTimeSeconds: $selectedRestTimeSeconds, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkoutStateImpl &&
            (identical(other.selectedDayId, selectedDayId) ||
                other.selectedDayId == selectedDayId) &&
            const DeepCollectionEquality().equals(
              other._currentDayExercises,
              _currentDayExercises,
            ) &&
            const DeepCollectionEquality().equals(
              other._loggedSets,
              _loggedSets,
            ) &&
            (identical(other.restTimerActive, restTimerActive) ||
                other.restTimerActive == restTimerActive) &&
            (identical(
                  other.selectedRestTimeSeconds,
                  selectedRestTimeSeconds,
                ) ||
                other.selectedRestTimeSeconds == selectedRestTimeSeconds) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedDayId,
    const DeepCollectionEquality().hash(_currentDayExercises),
    const DeepCollectionEquality().hash(_loggedSets),
    restTimerActive,
    selectedRestTimeSeconds,
    isLoading,
    error,
  );

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkoutStateImplCopyWith<_$WorkoutStateImpl> get copyWith =>
      __$$WorkoutStateImplCopyWithImpl<_$WorkoutStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkoutStateImplToJson(this);
  }
}

abstract class _WorkoutState implements WorkoutState {
  const factory _WorkoutState({
    final String? selectedDayId,
    required final List<Exercise> currentDayExercises,
    required final List<WorkoutSet> loggedSets,
    final bool restTimerActive,
    final int selectedRestTimeSeconds,
    final bool isLoading,
    final String? error,
  }) = _$WorkoutStateImpl;

  factory _WorkoutState.fromJson(Map<String, dynamic> json) =
      _$WorkoutStateImpl.fromJson;

  @override
  String? get selectedDayId;
  @override
  List<Exercise> get currentDayExercises;
  @override
  List<WorkoutSet> get loggedSets;
  @override
  bool get restTimerActive;
  @override
  int get selectedRestTimeSeconds;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of WorkoutState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkoutStateImplCopyWith<_$WorkoutStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
