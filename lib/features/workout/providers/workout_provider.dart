import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/exercise.dart' as models;
import '../../../data/models/state/workout_state.dart';
import '../services/workout_service.dart';

final workoutServiceProvider = Provider<WorkoutService>((ref) {
  final db = ref.watch(databaseProvider);
  return WorkoutService(db);
});

final workoutProvider =
    StateNotifierProvider<WorkoutNotifier, WorkoutState>((ref) {
  final service = ref.watch(workoutServiceProvider);
  final db = ref.watch(databaseProvider);
  return WorkoutNotifier(service, db);
});

class WorkoutNotifier extends StateNotifier<WorkoutState> {
  WorkoutNotifier(this._service, this._db) : super(WorkoutState.initial());

  final WorkoutService _service;
  final AppDatabase _db;

  /// Select a training day and load its exercises + logged sets.
  Future<void> selectDay(String dayId) async {
    state = state.copyWith(isLoading: true, error: null, selectedDayId: dayId);
    try {
      final dayExerciseRows = await _db.workoutDao.getDayExercises(dayId);

      final exercises = <models.Exercise>[];
      for (final de in dayExerciseRows) {
        final exRow = await _db.exerciseDao.getExerciseById(de.exerciseId);
        if (exRow != null) {
          exercises.add(models.Exercise(
            exerciseId: exRow.exerciseId,
            name: exRow.name,
            category: exRow.category,
            equipment: exRow.equipment,
            movementType: exRow.movementType,
            muscleGroups: (exRow.muscleGroups?.isNotEmpty ?? false)
                ? List<String>.from(
                    jsonDecode(exRow.muscleGroups!) as List<dynamic>)
                : [],
            isCompound: exRow.isCompound,
            imageUrl: exRow.imageUrl,
            description: exRow.description,
            isUserCustom: exRow.isUserCustom,
            createdAt: DateTime.parse(exRow.createdAt),
          ));
        }
      }

      final sets = await _service.getSetsForDay(dayId);

      state = state.copyWith(
        currentDayExercises: exercises,
        loggedSets: sets,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Record a new set for the given exercise.
  Future<void> recordSet({
    required String exerciseId,
    required int reps,
    required double weightKg,
    int? repsInReserve,
    String? tempoVariation,
    String? notes,
  }) async {
    final dayId = state.selectedDayId;
    if (dayId == null) return;

    state = state.copyWith(isLoading: true, error: null);
    try {
      final newSet = await _service.recordSet(
        exerciseId: exerciseId,
        dayId: dayId,
        reps: reps,
        weightKg: weightKg,
        repsInReserve: repsInReserve,
        tempoVariation: tempoVariation,
        notes: notes,
      );

      state = state.copyWith(
        loggedSets: [...state.loggedSets, newSet],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Delete a logged set.
  Future<void> deleteSet(String setId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.deleteSet(setId);
      state = state.copyWith(
        loggedSets: state.loggedSets.where((s) => s.setId != setId).toList(),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Toggle rest timer active state.
  void toggleRestTimer() {
    state = state.copyWith(restTimerActive: !state.restTimerActive);
  }

  /// Set rest timer duration.
  void setRestTime(int seconds) {
    state = state.copyWith(selectedRestTimeSeconds: seconds);
  }

  /// Stop rest timer.
  void stopRestTimer() {
    state = state.copyWith(restTimerActive: false);
  }
}
