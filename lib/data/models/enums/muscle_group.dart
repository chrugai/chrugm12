import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum MuscleGroup {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  forearms,
  legs,
  quads,
  hamstring,
  glutes,
  calves,
  core;

  String get displayName => switch (this) {
        MuscleGroup.chest => 'Chest',
        MuscleGroup.back => 'Back',
        MuscleGroup.shoulders => 'Shoulders',
        MuscleGroup.biceps => 'Biceps',
        MuscleGroup.triceps => 'Triceps',
        MuscleGroup.forearms => 'Forearms',
        MuscleGroup.legs => 'Legs',
        MuscleGroup.quads => 'Quads',
        MuscleGroup.hamstring => 'Hamstring',
        MuscleGroup.glutes => 'Glutes',
        MuscleGroup.calves => 'Calves',
        MuscleGroup.core => 'Core',
      };
}
