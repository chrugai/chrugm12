// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutSetImpl _$$WorkoutSetImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutSetImpl(
      setId: json['setId'] as String,
      exerciseId: json['exerciseId'] as String,
      dayId: json['dayId'] as String,
      reps: (json['reps'] as num).toInt(),
      weightKg: (json['weightKg'] as num).toDouble(),
      repsInReserve: (json['repsInReserve'] as num?)?.toInt(),
      tempoVariation: json['tempoVariation'] as String?,
      notes: json['notes'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      syncedToBackend: json['syncedToBackend'] as bool? ?? false,
    );

Map<String, dynamic> _$$WorkoutSetImplToJson(_$WorkoutSetImpl instance) =>
    <String, dynamic>{
      'setId': instance.setId,
      'exerciseId': instance.exerciseId,
      'dayId': instance.dayId,
      'reps': instance.reps,
      'weightKg': instance.weightKg,
      'repsInReserve': instance.repsInReserve,
      'tempoVariation': instance.tempoVariation,
      'notes': instance.notes,
      'timestamp': instance.timestamp.toIso8601String(),
      'syncedToBackend': instance.syncedToBackend,
    };
