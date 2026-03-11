// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'program_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProgramState _$ProgramStateFromJson(Map<String, dynamic> json) {
  return _ProgramState.fromJson(json);
}

/// @nodoc
mixin _$ProgramState {
  List<Program> get programs => throw _privateConstructorUsedError;
  String? get selectedProgramId => throw _privateConstructorUsedError;
  Program? get currentProgram => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this ProgramState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProgramState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProgramStateCopyWith<ProgramState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProgramStateCopyWith<$Res> {
  factory $ProgramStateCopyWith(
    ProgramState value,
    $Res Function(ProgramState) then,
  ) = _$ProgramStateCopyWithImpl<$Res, ProgramState>;
  @useResult
  $Res call({
    List<Program> programs,
    String? selectedProgramId,
    Program? currentProgram,
    bool isLoading,
    String? error,
  });

  $ProgramCopyWith<$Res>? get currentProgram;
}

/// @nodoc
class _$ProgramStateCopyWithImpl<$Res, $Val extends ProgramState>
    implements $ProgramStateCopyWith<$Res> {
  _$ProgramStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProgramState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programs = null,
    Object? selectedProgramId = freezed,
    Object? currentProgram = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            programs: null == programs
                ? _value.programs
                : programs // ignore: cast_nullable_to_non_nullable
                      as List<Program>,
            selectedProgramId: freezed == selectedProgramId
                ? _value.selectedProgramId
                : selectedProgramId // ignore: cast_nullable_to_non_nullable
                      as String?,
            currentProgram: freezed == currentProgram
                ? _value.currentProgram
                : currentProgram // ignore: cast_nullable_to_non_nullable
                      as Program?,
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

  /// Create a copy of ProgramState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgramCopyWith<$Res>? get currentProgram {
    if (_value.currentProgram == null) {
      return null;
    }

    return $ProgramCopyWith<$Res>(_value.currentProgram!, (value) {
      return _then(_value.copyWith(currentProgram: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProgramStateImplCopyWith<$Res>
    implements $ProgramStateCopyWith<$Res> {
  factory _$$ProgramStateImplCopyWith(
    _$ProgramStateImpl value,
    $Res Function(_$ProgramStateImpl) then,
  ) = __$$ProgramStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Program> programs,
    String? selectedProgramId,
    Program? currentProgram,
    bool isLoading,
    String? error,
  });

  @override
  $ProgramCopyWith<$Res>? get currentProgram;
}

/// @nodoc
class __$$ProgramStateImplCopyWithImpl<$Res>
    extends _$ProgramStateCopyWithImpl<$Res, _$ProgramStateImpl>
    implements _$$ProgramStateImplCopyWith<$Res> {
  __$$ProgramStateImplCopyWithImpl(
    _$ProgramStateImpl _value,
    $Res Function(_$ProgramStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProgramState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programs = null,
    Object? selectedProgramId = freezed,
    Object? currentProgram = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$ProgramStateImpl(
        programs: null == programs
            ? _value._programs
            : programs // ignore: cast_nullable_to_non_nullable
                  as List<Program>,
        selectedProgramId: freezed == selectedProgramId
            ? _value.selectedProgramId
            : selectedProgramId // ignore: cast_nullable_to_non_nullable
                  as String?,
        currentProgram: freezed == currentProgram
            ? _value.currentProgram
            : currentProgram // ignore: cast_nullable_to_non_nullable
                  as Program?,
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
class _$ProgramStateImpl implements _ProgramState {
  const _$ProgramStateImpl({
    required final List<Program> programs,
    this.selectedProgramId,
    this.currentProgram,
    this.isLoading = false,
    this.error,
  }) : _programs = programs;

  factory _$ProgramStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProgramStateImplFromJson(json);

  final List<Program> _programs;
  @override
  List<Program> get programs {
    if (_programs is EqualUnmodifiableListView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  @override
  final String? selectedProgramId;
  @override
  final Program? currentProgram;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'ProgramState(programs: $programs, selectedProgramId: $selectedProgramId, currentProgram: $currentProgram, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProgramStateImpl &&
            const DeepCollectionEquality().equals(other._programs, _programs) &&
            (identical(other.selectedProgramId, selectedProgramId) ||
                other.selectedProgramId == selectedProgramId) &&
            (identical(other.currentProgram, currentProgram) ||
                other.currentProgram == currentProgram) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_programs),
    selectedProgramId,
    currentProgram,
    isLoading,
    error,
  );

  /// Create a copy of ProgramState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProgramStateImplCopyWith<_$ProgramStateImpl> get copyWith =>
      __$$ProgramStateImplCopyWithImpl<_$ProgramStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProgramStateImplToJson(this);
  }
}

abstract class _ProgramState implements ProgramState {
  const factory _ProgramState({
    required final List<Program> programs,
    final String? selectedProgramId,
    final Program? currentProgram,
    final bool isLoading,
    final String? error,
  }) = _$ProgramStateImpl;

  factory _ProgramState.fromJson(Map<String, dynamic> json) =
      _$ProgramStateImpl.fromJson;

  @override
  List<Program> get programs;
  @override
  String? get selectedProgramId;
  @override
  Program? get currentProgram;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of ProgramState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProgramStateImplCopyWith<_$ProgramStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
