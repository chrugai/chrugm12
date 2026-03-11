import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../database/app_database.dart';
import 'chat_seeds.dart';
import 'exercise_seeds.dart';
import 'food_seeds.dart';
import 'integration_seeds.dart';
import 'meal_seeds.dart';
import 'measurement_seeds.dart';
import 'program_seeds.dart';
import 'upload_seeds.dart';
import 'user_seeds.dart';

class SeedRunner {
  static final _log = Logger();

  static Future<void> run(AppDatabase db) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('db_seeded') == true) {
      _log.d('Database already seeded, skipping.');
      return;
    }

    _log.i('Seeding database...');
    final stopwatch = Stopwatch()..start();

    try {
      await seedExercises(db);
      _log.d('Exercises seeded');

      await seedFoods(db);
      _log.d('Foods seeded');

      await seedUser(db);
      _log.d('User seeded');

      await seedPrograms(db);
      _log.d('Programs seeded');

      await seedMeasurements(db);
      _log.d('Measurements seeded');

      await seedUploads(db);
      _log.d('Uploads seeded');

      await seedIntegrations(db);
      _log.d('Integrations seeded');

      await seedChats(db);
      _log.d('Chats seeded');

      await seedMeals(db);
      _log.d('Meals seeded');

      stopwatch.stop();
      await prefs.setBool('db_seeded', true);
      _log.i('Seeding complete in ${stopwatch.elapsedMilliseconds}ms');
    } catch (e, st) {
      _log.e('Seeding failed', error: e, stackTrace: st);
      rethrow;
    }
  }
}
