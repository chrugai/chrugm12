import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/workout_set.dart' as models;

const _uuid = Uuid();

class WorkoutService {
  WorkoutService(this._db);

  final AppDatabase _db;

  /// Record a new set.
  Future<models.WorkoutSet> recordSet({
    required String exerciseId,
    required String dayId,
    required int reps,
    required double weightKg,
    int? repsInReserve,
    String? tempoVariation,
    String? notes,
  }) async {
    final setId = _uuid.v4();
    final now = DateTime.now();

    await _db.workoutDao.insertSet(SetsCompanion(
      setId: Value(setId),
      exerciseId: Value(exerciseId),
      dayId: Value(dayId),
      reps: Value(reps),
      weightKg: Value(weightKg),
      repsInReserve: Value(repsInReserve),
      tempoVariation: Value(tempoVariation),
      notes: Value(notes),
      timestamp: Value(now.toIso8601String()),
    ));

    return models.WorkoutSet(
      setId: setId,
      exerciseId: exerciseId,
      dayId: dayId,
      reps: reps,
      weightKg: weightKg,
      repsInReserve: repsInReserve,
      tempoVariation: tempoVariation,
      notes: notes,
      timestamp: now,
    );
  }

  /// Delete a set by ID.
  Future<void> deleteSet(String setId) async {
    await _db.workoutDao.deleteSet(setId);
  }

  /// Get all sets for a specific exercise.
  Future<List<models.WorkoutSet>> getSetsForExercise(String exerciseId) async {
    final rows = await _db.workoutDao.getSetsForExercise(exerciseId);
    return rows.map(_setFromRow).toList();
  }

  /// Get all sets for a specific day.
  Future<List<models.WorkoutSet>> getSetsForDay(String dayId) async {
    final rows = await _db.workoutDao.getSetsForDay(dayId);
    return rows.map(_setFromRow).toList();
  }

  models.WorkoutSet _setFromRow(SetEntry row) => models.WorkoutSet(
        setId: row.setId,
        exerciseId: row.exerciseId,
        dayId: row.dayId,
        reps: row.reps,
        weightKg: row.weightKg,
        repsInReserve: row.repsInReserve,
        tempoVariation: row.tempoVariation,
        notes: row.notes,
        timestamp: DateTime.parse(row.timestamp),
      );
}
