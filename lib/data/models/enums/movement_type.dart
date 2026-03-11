import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum MovementType {
  compound,
  isolation;

  String get displayName => switch (this) {
        MovementType.compound => 'Compound',
        MovementType.isolation => 'Isolation',
      };
}
