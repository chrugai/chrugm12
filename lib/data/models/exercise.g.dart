// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      exerciseId: json['exerciseId'] as String,
      name: json['name'] as String,
      category: json['category'] as String?,
      equipment: json['equipment'] as String?,
      movementType: json['movementType'] as String?,
      muscleGroups: (json['muscleGroups'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isCompound: json['isCompound'] as bool? ?? false,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      isUserCustom: json['isUserCustom'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'exerciseId': instance.exerciseId,
      'name': instance.name,
      'category': instance.category,
      'equipment': instance.equipment,
      'movementType': instance.movementType,
      'muscleGroups': instance.muscleGroups,
      'isCompound': instance.isCompound,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'isUserCustom': instance.isUserCustom,
      'createdAt': instance.createdAt.toIso8601String(),
    };
