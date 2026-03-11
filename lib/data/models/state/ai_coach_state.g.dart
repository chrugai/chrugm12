// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_coach_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiCoachStateImpl _$$AiCoachStateImplFromJson(Map<String, dynamic> json) =>
    _$AiCoachStateImpl(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => Message.fromJson(e as Map<String, dynamic>))
          .toList(),
      chats: (json['chats'] as List<dynamic>)
          .map((e) => Chat.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentChatId: json['currentChatId'] as String?,
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$AiCoachStateImplToJson(_$AiCoachStateImpl instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'chats': instance.chats,
      'currentChatId': instance.currentChatId,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
