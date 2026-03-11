// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MeasurementImpl _$$MeasurementImplFromJson(Map<String, dynamic> json) =>
    _$MeasurementImpl(
      measurementId: json['measurementId'] as String,
      userId: json['userId'] as String,
      measurementDate: json['measurementDate'] as String,
      neckCm: (json['neckCm'] as num?)?.toDouble(),
      shouldersCm: (json['shouldersCm'] as num?)?.toDouble(),
      chestCm: (json['chestCm'] as num?)?.toDouble(),
      bicepsLCm: (json['bicepsLCm'] as num?)?.toDouble(),
      bicepsRCm: (json['bicepsRCm'] as num?)?.toDouble(),
      forearmLCm: (json['forearmLCm'] as num?)?.toDouble(),
      forearmRCm: (json['forearmRCm'] as num?)?.toDouble(),
      waistCm: (json['waistCm'] as num?)?.toDouble(),
      hipsCm: (json['hipsCm'] as num?)?.toDouble(),
      thighLCm: (json['thighLCm'] as num?)?.toDouble(),
      thighRCm: (json['thighRCm'] as num?)?.toDouble(),
      calvesLCm: (json['calvesLCm'] as num?)?.toDouble(),
      calvesRCm: (json['calvesRCm'] as num?)?.toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$MeasurementImplToJson(_$MeasurementImpl instance) =>
    <String, dynamic>{
      'measurementId': instance.measurementId,
      'userId': instance.userId,
      'measurementDate': instance.measurementDate,
      'neckCm': instance.neckCm,
      'shouldersCm': instance.shouldersCm,
      'chestCm': instance.chestCm,
      'bicepsLCm': instance.bicepsLCm,
      'bicepsRCm': instance.bicepsRCm,
      'forearmLCm': instance.forearmLCm,
      'forearmRCm': instance.forearmRCm,
      'waistCm': instance.waistCm,
      'hipsCm': instance.hipsCm,
      'thighLCm': instance.thighLCm,
      'thighRCm': instance.thighRCm,
      'calvesLCm': instance.calvesLCm,
      'calvesRCm': instance.calvesRCm,
      'createdAt': instance.createdAt.toIso8601String(),
    };
