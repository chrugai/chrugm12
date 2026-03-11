import 'package:freezed_annotation/freezed_annotation.dart';

part 'workout_set.freezed.dart';
part 'workout_set.g.dart';

@freezed
abstract class WorkoutSet with _$WorkoutSet {
  const factory WorkoutSet({
    required String setId,
    required String exerciseId,
    required String dayId,
    required int reps,
    required double weightKg,
    int? repsInReserve,
    String? tempoVariation,
    String? notes,
    required DateTime timestamp,
    @Default(false) bool syncedToBackend,
  }) = _WorkoutSet;

  factory WorkoutSet.fromJson(Map<String, dynamic> json) =>
      _$WorkoutSetFromJson(json);
}
