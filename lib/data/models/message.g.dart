// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      messageId: json['messageId'] as String,
      chatId: json['chatId'] as String,
      role: json['role'] as String,
      content: json['content'] as String,
      fileUrl: json['fileUrl'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'messageId': instance.messageId,
      'chatId': instance.chatId,
      'role': instance.role,
      'content': instance.content,
      'fileUrl': instance.fileUrl,
      'timestamp': instance.timestamp.toIso8601String(),
    };
