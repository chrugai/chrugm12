import 'package:freezed_annotation/freezed_annotation.dart';

part 'exercise.freezed.dart';
part 'exercise.g.dart';

@freezed
abstract class Exercise with _$Exercise {
  const factory Exercise({
    required String exerciseId,
    required String name,
    String? category,
    String? equipment,
    String? movementType,
    required List<String> muscleGroups,
    @Default(false) bool isCompound,
    String? imageUrl,
    String? description,
    @Default(false) bool isUserCustom,
    required DateTime createdAt,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) =>
      _$ExerciseFromJson(json);
}
