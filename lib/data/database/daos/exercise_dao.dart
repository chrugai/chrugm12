import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/exercises_table.dart';

part 'exercise_dao.g.dart';

@DriftAccessor(tables: [Exercises])
class ExerciseDao extends DatabaseAccessor<AppDatabase>
    with _$ExerciseDaoMixin {
  ExerciseDao(super.db);

  Future<List<Exercise>> getAllExercises() => select(exercises).get();

  Future<Exercise?> getExerciseById(String id) =>
      (select(exercises)..where((t) => t.exerciseId.equals(id)))
          .getSingleOrNull();

  Future<List<Exercise>> searchExercises(String query) =>
      (select(exercises)..where((t) => t.name.like('%$query%'))).get();

  Future<List<Exercise>> getExercisesByMuscleGroup(String muscleGroup) =>
      (select(exercises)
            ..where((t) => t.muscleGroups.like('%$muscleGroup%')))
          .get();

  Future<void> insertExercise(ExercisesCompanion exercise) =>
      into(exercises).insert(exercise);
}
