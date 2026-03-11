import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/measurement.dart' as models;
import '../services/measurement_service.dart';

final measurementServiceProvider = Provider<MeasurementService>((ref) {
  final db = ref.watch(databaseProvider);
  return MeasurementService(db);
});

final measurementProvider = StateNotifierProvider<MeasurementNotifier,
    AsyncValue<List<models.Measurement>>>((ref) {
  final service = ref.watch(measurementServiceProvider);
  return MeasurementNotifier(service);
});

class MeasurementNotifier
    extends StateNotifier<AsyncValue<List<models.Measurement>>> {
  MeasurementNotifier(this._service) : super(const AsyncValue.loading());

  final MeasurementService _service;

  Future<void> loadMeasurements() async {
    state = const AsyncValue.loading();
    try {
      final measurements = await _service.getAllMeasurements('local_user');
      state = AsyncValue.data(measurements);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addMeasurement({
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
    try {
      final measurement = await _service.addMeasurement(
        userId: 'local_user',
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
      );
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data([measurement, ...current]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteMeasurement(String measurementId) async {
    try {
      await _service.deleteMeasurement(measurementId);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data(
        current.where((m) => m.measurementId != measurementId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
