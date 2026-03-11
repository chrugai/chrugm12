// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkoutStateImpl _$$WorkoutStateImplFromJson(Map<String, dynamic> json) =>
    _$WorkoutStateImpl(
      selectedDayId: json['selectedDayId'] as String?,
      currentDayExercises: (json['currentDayExercises'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      loggedSets: (json['loggedSets'] as List<dynamic>)
          .map((e) => WorkoutSet.fromJson(e as Map<String, dynamic>))
          .toList(),
      restTimerActive: json['restTimerActive'] as bool? ?? false,
      selectedRestTimeSeconds:
          (json['selectedRestTimeSeconds'] as num?)?.toInt() ?? 180,
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$WorkoutStateImplToJson(_$WorkoutStateImpl instance) =>
    <String, dynamic>{
      'selectedDayId': instance.selectedDayId,
      'currentDayExercises': instance.currentDayExercises,
      'loggedSets': instance.loggedSets,
      'restTimerActive': instance.restTimerActive,
      'selectedRestTimeSeconds': instance.selectedRestTimeSeconds,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
