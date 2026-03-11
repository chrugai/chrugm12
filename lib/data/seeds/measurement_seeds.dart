import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedMeasurements(AppDatabase db) async {
  final now = DateTime.now();
  final weeks = [
    MeasurementsCompanion(measurementId: const Value('meas_w1'), userId: const Value('local_user'), measurementDate: Value(now.subtract(const Duration(days: 21)).toIso8601String().substring(0, 10)), neckCm: const Value(38.0), shouldersCm: const Value(120.0), chestCm: const Value(105.0), bicepsLCm: const Value(36.0), bicepsRCm: const Value(36.5), forearmsLCm: const Value(29.0), forearmsRCm: const Value(29.5), waistCm: const Value(84.0), hipsCm: const Value(100.0), thighsLCm: const Value(60.0), thighsRCm: const Value(60.5), calvesLCm: const Value(38.0), calvesRCm: const Value(38.0), createdAt: Value(now.subtract(const Duration(days: 21)).toIso8601String())),
    MeasurementsCompanion(measurementId: const Value('meas_w2'), userId: const Value('local_user'), measurementDate: Value(now.subtract(const Duration(days: 14)).toIso8601String().substring(0, 10)), neckCm: const Value(38.1), shouldersCm: const Value(120.3), chestCm: const Value(105.3), bicepsLCm: const Value(36.2), bicepsRCm: const Value(36.7), forearmsLCm: const Value(29.1), forearmsRCm: const Value(29.6), waistCm: const Value(83.8), hipsCm: const Value(100.0), thighsLCm: const Value(60.2), thighsRCm: const Value(60.7), calvesLCm: const Value(38.1), calvesRCm: const Value(38.1), createdAt: Value(now.subtract(const Duration(days: 14)).toIso8601String())),
    MeasurementsCompanion(measurementId: const Value('meas_w3'), userId: const Value('local_user'), measurementDate: Value(now.subtract(const Duration(days: 7)).toIso8601String().substring(0, 10)), neckCm: const Value(38.2), shouldersCm: const Value(120.5), chestCm: const Value(105.5), bicepsLCm: const Value(36.4), bicepsRCm: const Value(36.9), forearmsLCm: const Value(29.2), forearmsRCm: const Value(29.7), waistCm: const Value(83.5), hipsCm: const Value(100.0), thighsLCm: const Value(60.4), thighsRCm: const Value(60.9), calvesLCm: const Value(38.2), calvesRCm: const Value(38.2), createdAt: Value(now.subtract(const Duration(days: 7)).toIso8601String())),
    MeasurementsCompanion(measurementId: const Value('meas_w4'), userId: const Value('local_user'), measurementDate: Value(now.toIso8601String().substring(0, 10)), neckCm: const Value(38.3), shouldersCm: const Value(120.8), chestCm: const Value(105.8), bicepsLCm: const Value(36.6), bicepsRCm: const Value(37.1), forearmsLCm: const Value(29.3), forearmsRCm: const Value(29.8), waistCm: const Value(83.2), hipsCm: const Value(100.0), thighsLCm: const Value(60.6), thighsRCm: const Value(61.1), calvesLCm: const Value(38.3), calvesRCm: const Value(38.3), createdAt: Value(now.toIso8601String())),
  ];
  await db.transaction(() async {
    for (final m in weeks) {
      await db.measurementDao.insertMeasurement(m);
    }
  });
}
