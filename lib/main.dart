import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'data/database/app_database.dart';
import 'data/seeds/seed_runner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final db = AppDatabase();
  await SeedRunner.run(db);
  runApp(ProviderScope(
    overrides: [databaseProvider.overrideWithValue(db)],
    child: const ChrugApp(),
  ));
}
