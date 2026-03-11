import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/measurements_table.dart';

part 'measurement_dao.g.dart';

@DriftAccessor(tables: [Measurements])
class MeasurementDao extends DatabaseAccessor<AppDatabase>
    with _$MeasurementDaoMixin {
  MeasurementDao(super.db);

  Future<List<Measurement>> getAllMeasurements() =>
      select(measurements).get();

  Future<void> insertMeasurement(MeasurementsCompanion measurement) =>
      into(measurements).insert(measurement);

  Future<bool> updateMeasurement(MeasurementsCompanion measurement) =>
      update(measurements).replace(measurement);

  Future<int> deleteMeasurement(String id) =>
      (delete(measurements)..where((t) => t.measurementId.equals(id))).go();
}
