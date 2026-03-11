// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutrition_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NutritionState _$NutritionStateFromJson(Map<String, dynamic> json) {
  return _NutritionState.fromJson(json);
}

/// @nodoc
mixin _$NutritionState {
  String get selectedDate => throw _privateConstructorUsedError;
  List<Meal> get meals => throw _privateConstructorUsedError;
  DailyGoal get dailyGoal => throw _privateConstructorUsedError;
  DailyTotals get dailyTotals => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this NutritionState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionStateCopyWith<NutritionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionStateCopyWith<$Res> {
  factory $NutritionStateCopyWith(
    NutritionState value,
    $Res Function(NutritionState) then,
  ) = _$NutritionStateCopyWithImpl<$Res, NutritionState>;
  @useResult
  $Res call({
    String selectedDate,
    List<Meal> meals,
    DailyGoal dailyGoal,
    DailyTotals dailyTotals,
    bool isLoading,
    String? error,
  });

  $DailyGoalCopyWith<$Res> get dailyGoal;
  $DailyTotalsCopyWith<$Res> get dailyTotals;
}

/// @nodoc
class _$NutritionStateCopyWithImpl<$Res, $Val extends NutritionState>
    implements $NutritionStateCopyWith<$Res> {
  _$NutritionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? meals = null,
    Object? dailyGoal = null,
    Object? dailyTotals = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            selectedDate: null == selectedDate
                ? _value.selectedDate
                : selectedDate // ignore: cast_nullable_to_non_nullable
                      as String,
            meals: null == meals
                ? _value.meals
                : meals // ignore: cast_nullable_to_non_nullable
                      as List<Meal>,
            dailyGoal: null == dailyGoal
                ? _value.dailyGoal
                : dailyGoal // ignore: cast_nullable_to_non_nullable
                      as DailyGoal,
            dailyTotals: null == dailyTotals
                ? _value.dailyTotals
                : dailyTotals // ignore: cast_nullable_to_non_nullable
                      as DailyTotals,
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

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyGoalCopyWith<$Res> get dailyGoal {
    return $DailyGoalCopyWith<$Res>(_value.dailyGoal, (value) {
      return _then(_value.copyWith(dailyGoal: value) as $Val);
    });
  }

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DailyTotalsCopyWith<$Res> get dailyTotals {
    return $DailyTotalsCopyWith<$Res>(_value.dailyTotals, (value) {
      return _then(_value.copyWith(dailyTotals: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NutritionStateImplCopyWith<$Res>
    implements $NutritionStateCopyWith<$Res> {
  factory _$$NutritionStateImplCopyWith(
    _$NutritionStateImpl value,
    $Res Function(_$NutritionStateImpl) then,
  ) = __$$NutritionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String selectedDate,
    List<Meal> meals,
    DailyGoal dailyGoal,
    DailyTotals dailyTotals,
    bool isLoading,
    String? error,
  });

  @override
  $DailyGoalCopyWith<$Res> get dailyGoal;
  @override
  $DailyTotalsCopyWith<$Res> get dailyTotals;
}

/// @nodoc
class __$$NutritionStateImplCopyWithImpl<$Res>
    extends _$NutritionStateCopyWithImpl<$Res, _$NutritionStateImpl>
    implements _$$NutritionStateImplCopyWith<$Res> {
  __$$NutritionStateImplCopyWithImpl(
    _$NutritionStateImpl _value,
    $Res Function(_$NutritionStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? meals = null,
    Object? dailyGoal = null,
    Object? dailyTotals = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$NutritionStateImpl(
        selectedDate: null == selectedDate
            ? _value.selectedDate
            : selectedDate // ignore: cast_nullable_to_non_nullable
                  as String,
        meals: null == meals
            ? _value._meals
            : meals // ignore: cast_nullable_to_non_nullable
                  as List<Meal>,
        dailyGoal: null == dailyGoal
            ? _value.dailyGoal
            : dailyGoal // ignore: cast_nullable_to_non_nullable
                  as DailyGoal,
        dailyTotals: null == dailyTotals
            ? _value.dailyTotals
            : dailyTotals // ignore: cast_nullable_to_non_nullable
                  as DailyTotals,
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
class _$NutritionStateImpl implements _NutritionState {
  const _$NutritionStateImpl({
    required this.selectedDate,
    required final List<Meal> meals,
    required this.dailyGoal,
    required this.dailyTotals,
    this.isLoading = false,
    this.error,
  }) : _meals = meals;

  factory _$NutritionStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$NutritionStateImplFromJson(json);

  @override
  final String selectedDate;
  final List<Meal> _meals;
  @override
  List<Meal> get meals {
    if (_meals is EqualUnmodifiableListView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meals);
  }

  @override
  final DailyGoal dailyGoal;
  @override
  final DailyTotals dailyTotals;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'NutritionState(selectedDate: $selectedDate, meals: $meals, dailyGoal: $dailyGoal, dailyTotals: $dailyTotals, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionStateImpl &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            const DeepCollectionEquality().equals(other._meals, _meals) &&
            (identical(other.dailyGoal, dailyGoal) ||
                other.dailyGoal == dailyGoal) &&
            (identical(other.dailyTotals, dailyTotals) ||
                other.dailyTotals == dailyTotals) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    selectedDate,
    const DeepCollectionEquality().hash(_meals),
    dailyGoal,
    dailyTotals,
    isLoading,
    error,
  );

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionStateImplCopyWith<_$NutritionStateImpl> get copyWith =>
      __$$NutritionStateImplCopyWithImpl<_$NutritionStateImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NutritionStateImplToJson(this);
  }
}

abstract class _NutritionState implements NutritionState {
  const factory _NutritionState({
    required final String selectedDate,
    required final List<Meal> meals,
    required final DailyGoal dailyGoal,
    required final DailyTotals dailyTotals,
    final bool isLoading,
    final String? error,
  }) = _$NutritionStateImpl;

  factory _NutritionState.fromJson(Map<String, dynamic> json) =
      _$NutritionStateImpl.fromJson;

  @override
  String get selectedDate;
  @override
  List<Meal> get meals;
  @override
  DailyGoal get dailyGoal;
  @override
  DailyTotals get dailyTotals;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of NutritionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionStateImplCopyWith<_$NutritionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
