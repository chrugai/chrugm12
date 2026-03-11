import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/measurement.dart' as models;

const _uuid = Uuid();

class MeasurementService {
  MeasurementService(this._db);

  final AppDatabase _db;

  Future<List<models.Measurement>> getAllMeasurements(String userId) async {
    final rows = await (_db.select(_db.measurements)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.measurementDate)]))
        .get();
    return rows.map(_measurementFromRow).toList();
  }

  Future<models.Measurement> addMeasurement({
    required String userId,
    required String measurementDate,
    double? neckCm,
    double? shouldersCm,
    double? chestCm,
    double? bicepsLCm,
    double? bicepsRCm,
    double? forearmLCm,
    double? forearmRCm,
    double? waistCm,
    double? hipsCm,
    double? thighLCm,
    double? thighRCm,
    double? calvesLCm,
    double? calvesRCm,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now().toIso8601String();

    await _db.measurementDao.insertMeasurement(MeasurementsCompanion(
      measurementId: Value(id),
      userId: Value(userId),
      measurementDate: Value(measurementDate),
      neckCm: Value(neckCm),
      shouldersCm: Value(shouldersCm),
      chestCm: Value(chestCm),
      bicepsLCm: Value(bicepsLCm),
      bicepsRCm: Value(bicepsRCm),
      forearmsLCm: Value(forearmLCm),
      forearmsRCm: Value(forearmRCm),
      waistCm: Value(waistCm),
      hipsCm: Value(hipsCm),
      thighsLCm: Value(thighLCm),
      thighsRCm: Value(thighRCm),
      calvesLCm: Value(calvesLCm),
      calvesRCm: Value(calvesRCm),
      createdAt: Value(now),
    ));

    return models.Measurement(
      measurementId: id,
      userId: userId,
      measurementDate: measurementDate,
      neckCm: neckCm,
      shouldersCm: shouldersCm,
      chestCm: chestCm,
      bicepsLCm: bicepsLCm,
      bicepsRCm: bicepsRCm,
      forearmLCm: forearmLCm,
      forearmRCm: forearmRCm,
      waistCm: waistCm,
      hipsCm: hipsCm,
      thighLCm: thighLCm,
      thighRCm: thighRCm,
      calvesLCm: calvesLCm,
      calvesRCm: calvesRCm,
      createdAt: DateTime.now(),
    );
  }

  Future<void> deleteMeasurement(String measurementId) async {
    await _db.measurementDao.deleteMeasurement(measurementId);
  }

  models.Measurement _measurementFromRow(Measurement row) {
    return models.Measurement(
      measurementId: row.measurementId,
      userId: row.userId,
      measurementDate: row.measurementDate,
      neckCm: row.neckCm,
      shouldersCm: row.shouldersCm,
      chestCm: row.chestCm,
      bicepsLCm: row.bicepsLCm,
      bicepsRCm: row.bicepsRCm,
      forearmLCm: row.forearmsLCm,
      forearmRCm: row.forearmsRCm,
      waistCm: row.waistCm,
      hipsCm: row.hipsCm,
      thighLCm: row.thighsLCm,
      thighRCm: row.thighsRCm,
      calvesLCm: row.calvesLCm,
      calvesRCm: row.calvesRCm,
      createdAt: DateTime.parse(row.createdAt),
    );
  }
}
