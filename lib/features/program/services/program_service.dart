import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/day.dart' as models;
import '../../../data/models/exercise.dart' as models;
import '../../../data/models/program.dart' as models;

const _uuid = Uuid();

class ProgramService {
  ProgramService(this._db);

  final AppDatabase _db;

  /// Load all programs with their days and exercises.
  Future<List<models.Program>> getAllPrograms() async {
    final rows = await _db.programDao.getAllPrograms();
    final programs = <models.Program>[];

    for (final row in rows) {
      final days = await _loadDays(row.programId);
      programs.add(_programFromRow(row, days));
    }

    return programs;
  }

  /// Get the currently active program.
  Future<models.Program?> getActiveProgram() async {
    final row = await _db.programDao.getActiveProgram();
    if (row == null) return null;
    final days = await _loadDays(row.programId);
    return _programFromRow(row, days);
  }

  /// Create a new program.
  Future<models.Program> createProgram(String name, {String? description}) async {
    final programId = _uuid.v4();
    final now = DateTime.now().toIso8601String();

    // Deactivate other programs
    final existing = await _db.programDao.getAllPrograms();
    for (final p in existing) {
      await _db.programDao.updateProgram(ProgramsCompanion(
        programId: Value(p.programId),
        userId: Value(p.userId),
        name: Value(p.name),
        isActive: const Value(false),
        createdAt: Value(p.createdAt),
        updatedAt: Value(now),
      ));
    }

    await _db.programDao.insertProgram(ProgramsCompanion(
      programId: Value(programId),
      userId: const Value('local_user'),
      name: Value(name),
      description: Value(description),
      isActive: const Value(true),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    return models.Program(
      programId: programId,
      userId: 'local_user',
      name: name,
      description: description,
      days: const [],
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Select (activate) a program by ID.
  Future<void> selectProgram(String programId) async {
    final now = DateTime.now().toIso8601String();
    final all = await _db.programDao.getAllPrograms();
    for (final p in all) {
      await _db.programDao.updateProgram(ProgramsCompanion(
        programId: Value(p.programId),
        userId: Value(p.userId),
        name: Value(p.name),
        isActive: Value(p.programId == programId),
        createdAt: Value(p.createdAt),
        updatedAt: Value(now),
      ));
    }
  }

  /// Delete a program and its days/exercises.
  Future<void> deleteProgram(String programId) async {
    await _db.programDao.deleteProgram(programId);
  }

  /// Add a day to a program.
  Future<models.Day> addDay(String programId, String dayName) async {
    final dayId = _uuid.v4();
    final now = DateTime.now().toIso8601String();

    // Get current day count for ordering
    final existingDays = await (_db.select(_db.days)
          ..where((t) => t.programId.equals(programId)))
        .get();
    final dayCount = existingDays.length;

    await _db.into(_db.days).insert(DaysCompanion(
      dayId: Value(dayId),
      programId: Value(programId),
      dayNumber: Value(dayCount + 1),
      dayName: Value(dayName),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    return models.Day(
      dayId: dayId,
      programId: programId,
      dayNumber: dayCount + 1,
      dayName: dayName,
      exercises: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// Rename a day.
  Future<void> renameDay(String dayId, String newName) async {
    final now = DateTime.now().toIso8601String();
    await (_db.update(_db.days)..where((t) => t.dayId.equals(dayId)))
        .write(DaysCompanion(dayName: Value(newName), updatedAt: Value(now)));
  }

  /// Reorder exercises within a day.
  Future<void> reorderExercises(String dayId, List<String> exerciseIds) async {
    for (var i = 0; i < exerciseIds.length; i++) {
      final des = await (_db.select(_db.dayExercises)
            ..where((t) =>
                t.dayId.equals(dayId) &
                t.exerciseId.equals(exerciseIds[i])))
          .getSingleOrNull();
      if (des != null) {
        await _db.workoutDao.updateExerciseOrder(DayExercisesCompanion(
          id: Value(des.id),
          dayId: Value(des.dayId),
          exerciseId: Value(des.exerciseId),
          exerciseOrder: Value(i + 1),
          createdAt: Value(des.createdAt),
        ));
      }
    }
  }


  /// Add exercises to a day.
  Future<void> addExercisesToDay(
      String dayId, List<String> exerciseIds) async {
    final existing = await _db.workoutDao.getDayExercises(dayId);
    var order = existing.length;
    for (final exerciseId in exerciseIds) {
      order++;
      await _db.workoutDao.insertDayExercise(DayExercisesCompanion(
        id: Value(_uuid.v4()),
        dayId: Value(dayId),
        exerciseId: Value(exerciseId),
        exerciseOrder: Value(order),
        createdAt: Value(DateTime.now().toIso8601String()),
      ));
    }
  }

  Future<List<models.Day>> _loadDays(String programId) async {
    final dayRows = await (_db.select(_db.days)
          ..where((t) => t.programId.equals(programId))
          ..orderBy([(t) => OrderingTerm.asc(t.dayNumber)]))
        .get();

    final days = <models.Day>[];
    for (final day in dayRows) {
      final deRows = await _db.workoutDao.getDayExercises(day.dayId);
      final exercises = <models.Exercise>[];

      for (final de in deRows) {
        final exRow = await _db.exerciseDao.getExerciseById(de.exerciseId);
        if (exRow != null) {
          exercises.add(models.Exercise(
            exerciseId: exRow.exerciseId,
            name: exRow.name,
            category: exRow.category,
            equipment: exRow.equipment,
            movementType: exRow.movementType,
            muscleGroups: (exRow.muscleGroups?.isNotEmpty ?? false)
                ? exRow.muscleGroups!
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .replaceAll('"', '')
                    .split(',')
                    .map((s) => s.trim())
                    .where((s) => s.isNotEmpty)
                    .toList()
                : [],
            isCompound: exRow.isCompound,
            description: exRow.description,
            isUserCustom: exRow.isUserCustom,
            createdAt: DateTime.parse(exRow.createdAt),
          ));
        }
      }

      days.add(models.Day(
        dayId: day.dayId,
        programId: day.programId,
        dayNumber: day.dayNumber,
        dayName: day.dayName,
        exercises: exercises,
        createdAt: DateTime.parse(day.createdAt),
        updatedAt: DateTime.parse(day.updatedAt),
      ));
    }

    return days;
  }

  models.Program _programFromRow(Program row, List<models.Day> days) {
    return models.Program(
      programId: row.programId,
      userId: row.userId,
      name: row.name,
      description: row.description,
      days: days,
      isActive: row.isActive,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }
}
