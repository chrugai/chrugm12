// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationItemImpl _$$NotificationItemImplFromJson(
  Map<String, dynamic> json,
) => _$NotificationItemImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  body: json['body'] as String,
  isRead: json['isRead'] as bool? ?? false,
  timestamp: DateTime.parse(json['timestamp'] as String),
  relatedScreenRoute: json['relatedScreenRoute'] as String?,
);

Map<String, dynamic> _$$NotificationItemImplToJson(
  _$NotificationItemImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'body': instance.body,
  'isRead': instance.isRead,
  'timestamp': instance.timestamp.toIso8601String(),
  'relatedScreenRoute': instance.relatedScreenRoute,
};
