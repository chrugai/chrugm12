import 'package:freezed_annotation/freezed_annotation.dart';

import '../exercise.dart';
import '../workout_set.dart';

part 'workout_state.freezed.dart';
part 'workout_state.g.dart';

@freezed
abstract class WorkoutState with _$WorkoutState {
  const factory WorkoutState({
    String? selectedDayId,
    required List<Exercise> currentDayExercises,
    required List<WorkoutSet> loggedSets,
    @Default(false) bool restTimerActive,
    @Default(180) int selectedRestTimeSeconds,
    @Default(false) bool isLoading,
    String? error,
  }) = _WorkoutState;

  factory WorkoutState.initial() => const WorkoutState(
        currentDayExercises: [],
        loggedSets: [],
      );

  factory WorkoutState.fromJson(Map<String, dynamic> json) =>
      _$WorkoutStateFromJson(json);
}
