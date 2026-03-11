// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_coach_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AiCoachState _$AiCoachStateFromJson(Map<String, dynamic> json) {
  return _AiCoachState.fromJson(json);
}

/// @nodoc
mixin _$AiCoachState {
  List<Message> get messages => throw _privateConstructorUsedError;
  List<Chat> get chats => throw _privateConstructorUsedError;
  String? get currentChatId => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this AiCoachState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AiCoachState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AiCoachStateCopyWith<AiCoachState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AiCoachStateCopyWith<$Res> {
  factory $AiCoachStateCopyWith(
    AiCoachState value,
    $Res Function(AiCoachState) then,
  ) = _$AiCoachStateCopyWithImpl<$Res, AiCoachState>;
  @useResult
  $Res call({
    List<Message> messages,
    List<Chat> chats,
    String? currentChatId,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class _$AiCoachStateCopyWithImpl<$Res, $Val extends AiCoachState>
    implements $AiCoachStateCopyWith<$Res> {
  _$AiCoachStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AiCoachState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? chats = null,
    Object? currentChatId = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<Message>,
            chats: null == chats
                ? _value.chats
                : chats // ignore: cast_nullable_to_non_nullable
                      as List<Chat>,
            currentChatId: freezed == currentChatId
                ? _value.currentChatId
                : currentChatId // ignore: cast_nullable_to_non_nullable
                      as String?,
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
abstract class _$$AiCoachStateImplCopyWith<$Res>
    implements $AiCoachStateCopyWith<$Res> {
  factory _$$AiCoachStateImplCopyWith(
    _$AiCoachStateImpl value,
    $Res Function(_$AiCoachStateImpl) then,
  ) = __$$AiCoachStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<Message> messages,
    List<Chat> chats,
    String? currentChatId,
    bool isLoading,
    String? error,
  });
}

/// @nodoc
class __$$AiCoachStateImplCopyWithImpl<$Res>
    extends _$AiCoachStateCopyWithImpl<$Res, _$AiCoachStateImpl>
    implements _$$AiCoachStateImplCopyWith<$Res> {
  __$$AiCoachStateImplCopyWithImpl(
    _$AiCoachStateImpl _value,
    $Res Function(_$AiCoachStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AiCoachState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? chats = null,
    Object? currentChatId = freezed,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AiCoachStateImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<Message>,
        chats: null == chats
            ? _value._chats
            : chats // ignore: cast_nullable_to_non_nullable
                  as List<Chat>,
        currentChatId: freezed == currentChatId
            ? _value.currentChatId
            : currentChatId // ignore: cast_nullable_to_non_nullable
                  as String?,
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
class _$AiCoachStateImpl implements _AiCoachState {
  const _$AiCoachStateImpl({
    required final List<Message> messages,
    required final List<Chat> chats,
    this.currentChatId,
    this.isLoading = false,
    this.error,
  }) : _messages = messages,
       _chats = chats;

  factory _$AiCoachStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$AiCoachStateImplFromJson(json);

  final List<Message> _messages;
  @override
  List<Message> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final List<Chat> _chats;
  @override
  List<Chat> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  final String? currentChatId;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'AiCoachState(messages: $messages, chats: $chats, currentChatId: $currentChatId, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AiCoachStateImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.currentChatId, currentChatId) ||
                other.currentChatId == currentChatId) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    const DeepCollectionEquality().hash(_chats),
    currentChatId,
    isLoading,
    error,
  );

  /// Create a copy of AiCoachState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AiCoachStateImplCopyWith<_$AiCoachStateImpl> get copyWith =>
      __$$AiCoachStateImplCopyWithImpl<_$AiCoachStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AiCoachStateImplToJson(this);
  }
}

abstract class _AiCoachState implements AiCoachState {
  const factory _AiCoachState({
    required final List<Message> messages,
    required final List<Chat> chats,
    final String? currentChatId,
    final bool isLoading,
    final String? error,
  }) = _$AiCoachStateImpl;

  factory _AiCoachState.fromJson(Map<String, dynamic> json) =
      _$AiCoachStateImpl.fromJson;

  @override
  List<Message> get messages;
  @override
  List<Chat> get chats;
  @override
  String? get currentChatId;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of AiCoachState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AiCoachStateImplCopyWith<_$AiCoachStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
