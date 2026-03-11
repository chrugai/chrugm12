import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedIntegrations(AppDatabase db) async {
  final names = ['Apple Health', 'Whoop', 'Withings', 'Oura', 'Garmin', 'Fitbit'];
  await db.transaction(() async {
    for (var i = 0; i < names.length; i++) {
      await db.integrationDao.insertIntegration(IntegrationsCompanion(
        integrationId: Value('integ_${i + 1}'),
        userId: const Value('local_user'),
        integrationName: Value(names[i]),
        isConnected: const Value(false),
      ));
    }
  });
}
