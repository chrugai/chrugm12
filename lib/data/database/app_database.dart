import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'daos/chat_dao.dart';
import 'daos/exercise_dao.dart';
import 'daos/integration_dao.dart';
import 'daos/measurement_dao.dart';
import 'daos/nutrition_dao.dart';
import 'daos/program_dao.dart';
import 'daos/upload_dao.dart';
import 'daos/user_dao.dart';
import 'daos/workout_dao.dart';
import 'tables/chats_table.dart';
import 'tables/day_exercises_table.dart';
import 'tables/days_table.dart';
import 'tables/exercises_table.dart';
import 'tables/foods_table.dart';
import 'tables/integrations_table.dart';
import 'tables/meals_table.dart';
import 'tables/meal_foods_table.dart';
import 'tables/measurements_table.dart';
import 'tables/messages_table.dart';
import 'tables/programs_table.dart';
import 'tables/sets_table.dart';
import 'tables/uploads_table.dart';
import 'tables/users_table.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Programs,
    Days,
    Exercises,
    DayExercises,
    Sets,
    Meals,
    Foods,
    MealFoods,
    Measurements,
    Uploads,
    Chats,
    Messages,
    Integrations,
  ],
  daos: [
    UserDao,
    ProgramDao,
    ExerciseDao,
    WorkoutDao,
    NutritionDao,
    MeasurementDao,
    UploadDao,
    ChatDao,
    IntegrationDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await customStatement('PRAGMA foreign_keys = ON');
          await customStatement(
              'CREATE INDEX idx_sets_exercise_id ON sets (exercise_id)');
          await customStatement(
              'CREATE INDEX idx_sets_day_id ON sets (day_id)');
          await customStatement(
              'CREATE INDEX idx_meals_meal_date ON meals (meal_date)');
          await customStatement(
              'CREATE INDEX idx_day_exercises_day_id ON day_exercises (day_id)');
          await customStatement(
              'CREATE INDEX idx_messages_chat_id ON messages (chat_id)');
        },
        onUpgrade: (m, from, to) async {},
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'chrug.sqlite'));
    return NativeDatabase.createInBackground(file, logStatements: true);
  });
}

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});
