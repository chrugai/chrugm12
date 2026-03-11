// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String get exerciseId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get equipment => throw _privateConstructorUsedError;
  String? get movementType => throw _privateConstructorUsedError;
  List<String> get muscleGroups => throw _privateConstructorUsedError;
  bool get isCompound => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get isUserCustom => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call({
    String exerciseId,
    String name,
    String? category,
    String? equipment,
    String? movementType,
    List<String> muscleGroups,
    bool isCompound,
    String? imageUrl,
    String? description,
    bool isUserCustom,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? name = null,
    Object? category = freezed,
    Object? equipment = freezed,
    Object? movementType = freezed,
    Object? muscleGroups = null,
    Object? isCompound = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? isUserCustom = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            exerciseId: null == exerciseId
                ? _value.exerciseId
                : exerciseId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            equipment: freezed == equipment
                ? _value.equipment
                : equipment // ignore: cast_nullable_to_non_nullable
                      as String?,
            movementType: freezed == movementType
                ? _value.movementType
                : movementType // ignore: cast_nullable_to_non_nullable
                      as String?,
            muscleGroups: null == muscleGroups
                ? _value.muscleGroups
                : muscleGroups // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isCompound: null == isCompound
                ? _value.isCompound
                : isCompound // ignore: cast_nullable_to_non_nullable
                      as bool,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            isUserCustom: null == isUserCustom
                ? _value.isUserCustom
                : isUserCustom // ignore: cast_nullable_to_non_nullable
                      as bool,
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
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
    _$ExerciseImpl value,
    $Res Function(_$ExerciseImpl) then,
  ) = __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String exerciseId,
    String name,
    String? category,
    String? equipment,
    String? movementType,
    List<String> muscleGroups,
    bool isCompound,
    String? imageUrl,
    String? description,
    bool isUserCustom,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
    _$ExerciseImpl _value,
    $Res Function(_$ExerciseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? exerciseId = null,
    Object? name = null,
    Object? category = freezed,
    Object? equipment = freezed,
    Object? movementType = freezed,
    Object? muscleGroups = null,
    Object? isCompound = null,
    Object? imageUrl = freezed,
    Object? description = freezed,
    Object? isUserCustom = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ExerciseImpl(
        exerciseId: null == exerciseId
            ? _value.exerciseId
            : exerciseId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        equipment: freezed == equipment
            ? _value.equipment
            : equipment // ignore: cast_nullable_to_non_nullable
                  as String?,
        movementType: freezed == movementType
            ? _value.movementType
            : movementType // ignore: cast_nullable_to_non_nullable
                  as String?,
        muscleGroups: null == muscleGroups
            ? _value._muscleGroups
            : muscleGroups // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isCompound: null == isCompound
            ? _value.isCompound
            : isCompound // ignore: cast_nullable_to_non_nullable
                  as bool,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        isUserCustom: null == isUserCustom
            ? _value.isUserCustom
            : isUserCustom // ignore: cast_nullable_to_non_nullable
                  as bool,
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
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl({
    required this.exerciseId,
    required this.name,
    this.category,
    this.equipment,
    this.movementType,
    required final List<String> muscleGroups,
    this.isCompound = false,
    this.imageUrl,
    this.description,
    this.isUserCustom = false,
    required this.createdAt,
  }) : _muscleGroups = muscleGroups;

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final String exerciseId;
  @override
  final String name;
  @override
  final String? category;
  @override
  final String? equipment;
  @override
  final String? movementType;
  final List<String> _muscleGroups;
  @override
  List<String> get muscleGroups {
    if (_muscleGroups is EqualUnmodifiableListView) return _muscleGroups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_muscleGroups);
  }

  @override
  @JsonKey()
  final bool isCompound;
  @override
  final String? imageUrl;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool isUserCustom;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Exercise(exerciseId: $exerciseId, name: $name, category: $category, equipment: $equipment, movementType: $movementType, muscleGroups: $muscleGroups, isCompound: $isCompound, imageUrl: $imageUrl, description: $description, isUserCustom: $isUserCustom, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.exerciseId, exerciseId) ||
                other.exerciseId == exerciseId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.equipment, equipment) ||
                other.equipment == equipment) &&
            (identical(other.movementType, movementType) ||
                other.movementType == movementType) &&
            const DeepCollectionEquality().equals(
              other._muscleGroups,
              _muscleGroups,
            ) &&
            (identical(other.isCompound, isCompound) ||
                other.isCompound == isCompound) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isUserCustom, isUserCustom) ||
                other.isUserCustom == isUserCustom) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    exerciseId,
    name,
    category,
    equipment,
    movementType,
    const DeepCollectionEquality().hash(_muscleGroups),
    isCompound,
    imageUrl,
    description,
    isUserCustom,
    createdAt,
  );

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(this);
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise({
    required final String exerciseId,
    required final String name,
    final String? category,
    final String? equipment,
    final String? movementType,
    required final List<String> muscleGroups,
    final bool isCompound,
    final String? imageUrl,
    final String? description,
    final bool isUserCustom,
    required final DateTime createdAt,
  }) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  String get exerciseId;
  @override
  String get name;
  @override
  String? get category;
  @override
  String? get equipment;
  @override
  String? get movementType;
  @override
  List<String> get muscleGroups;
  @override
  bool get isCompound;
  @override
  String? get imageUrl;
  @override
  String? get description;
  @override
  bool get isUserCustom;
  @override
  DateTime get createdAt;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
