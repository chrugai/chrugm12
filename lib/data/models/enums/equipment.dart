import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum Equipment {
  barbell,
  dumbbell,
  machine,
  cable,
  bodyweight,
  kettlebell,
  resistanceBand;

  String get displayName => switch (this) {
        Equipment.barbell => 'Barbell',
        Equipment.dumbbell => 'Dumbbell',
        Equipment.machine => 'Machine',
        Equipment.cable => 'Cable',
        Equipment.bodyweight => 'Bodyweight',
        Equipment.kettlebell => 'Kettlebell',
        Equipment.resistanceBand => 'Resistance Band',
      };
}
