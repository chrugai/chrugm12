// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'integration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntegrationImpl _$$IntegrationImplFromJson(Map<String, dynamic> json) =>
    _$IntegrationImpl(
      integrationId: json['integrationId'] as String,
      userId: json['userId'] as String,
      integrationName: json['integrationName'] as String,
      isConnected: json['isConnected'] as bool? ?? false,
      lastSyncedAt: json['lastSyncedAt'] == null
          ? null
          : DateTime.parse(json['lastSyncedAt'] as String),
      syncError: json['syncError'] as String?,
    );

Map<String, dynamic> _$$IntegrationImplToJson(_$IntegrationImpl instance) =>
    <String, dynamic>{
      'integrationId': instance.integrationId,
      'userId': instance.userId,
      'integrationName': instance.integrationName,
      'isConnected': instance.isConnected,
      'lastSyncedAt': instance.lastSyncedAt?.toIso8601String(),
      'syncError': instance.syncError,
    };
