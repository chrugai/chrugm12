// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthStateImpl _$$AuthStateImplFromJson(Map<String, dynamic> json) =>
    _$AuthStateImpl(
      isAuthenticated: json['isAuthenticated'] as bool,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      authToken: json['authToken'] as String?,
      error: json['error'] as String?,
      isLoading: json['isLoading'] as bool? ?? false,
    );

Map<String, dynamic> _$$AuthStateImplToJson(_$AuthStateImpl instance) =>
    <String, dynamic>{
      'isAuthenticated': instance.isAuthenticated,
      'user': instance.user,
      'authToken': instance.authToken,
      'error': instance.error,
      'isLoading': instance.isLoading,
    };
