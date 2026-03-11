import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/day_exercises_table.dart';
import '../tables/sets_table.dart';

part 'workout_dao.g.dart';

@DriftAccessor(tables: [Sets, DayExercises])
class WorkoutDao extends DatabaseAccessor<AppDatabase>
    with _$WorkoutDaoMixin {
  WorkoutDao(super.db);

  Future<List<SetEntry>> getSetsForExercise(String exerciseId) =>
      (select(sets)..where((t) => t.exerciseId.equals(exerciseId))).get();

  Future<List<SetEntry>> getSetsForDay(String dayId) =>
      (select(sets)..where((t) => t.dayId.equals(dayId))).get();

  Future<void> insertSet(SetsCompanion set) => into(sets).insert(set);

  Future<int> deleteSet(String setId) =>
      (delete(sets)..where((t) => t.setId.equals(setId))).go();

  Future<List<DayExercise>> getDayExercises(String dayId) =>
      (select(dayExercises)
            ..where((t) => t.dayId.equals(dayId))
            ..orderBy([(t) => OrderingTerm.asc(t.exerciseOrder)]))
          .get();

  Future<void> insertDayExercise(DayExercisesCompanion dayExercise) =>
      into(dayExercises).insert(dayExercise);

  Future<bool> updateExerciseOrder(DayExercisesCompanion dayExercise) =>
      update(dayExercises).replace(dayExercise);

  Future<int> deleteDayExercise(String id) =>
      (delete(dayExercises)..where((t) => t.id.equals(id))).go();
}
