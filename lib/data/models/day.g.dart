// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DayImpl _$$DayImplFromJson(Map<String, dynamic> json) => _$DayImpl(
  dayId: json['dayId'] as String,
  programId: json['programId'] as String,
  dayNumber: (json['dayNumber'] as num).toInt(),
  dayName: json['dayName'] as String,
  exercises: (json['exercises'] as List<dynamic>)
      .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$DayImplToJson(_$DayImpl instance) => <String, dynamic>{
  'dayId': instance.dayId,
  'programId': instance.programId,
  'dayNumber': instance.dayNumber,
  'dayName': instance.dayName,
  'exercises': instance.exercises,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
