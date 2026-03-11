import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/integration.dart' as models;
import '../services/integration_service.dart';

final integrationServiceProvider = Provider<IntegrationService>((ref) {
  final db = ref.watch(databaseProvider);
  return IntegrationService(db);
});

final integrationProvider = StateNotifierProvider<IntegrationNotifier,
    AsyncValue<List<models.Integration>>>((ref) {
  final service = ref.watch(integrationServiceProvider);
  return IntegrationNotifier(service);
});

class IntegrationNotifier
    extends StateNotifier<AsyncValue<List<models.Integration>>> {
  IntegrationNotifier(this._service) : super(const AsyncValue.loading());

  final IntegrationService _service;

  Future<void> loadIntegrations() async {
    state = const AsyncValue.loading();
    try {
      final integrations = await _service.getAllIntegrations('local_user');
      state = AsyncValue.data(integrations);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> connectIntegration(String integrationId) async {
    try {
      final updated = await _service.connectIntegration(integrationId);
      _replaceInList(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> disconnectIntegration(String integrationId) async {
    try {
      final updated = await _service.disconnectIntegration(integrationId);
      _replaceInList(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> syncIntegration(String integrationId) async {
    try {
      final updated = await _service.syncIntegration(integrationId);
      _replaceInList(updated);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void _replaceInList(models.Integration updated) {
    final current = state.valueOrNull ?? [];
    state = AsyncValue.data(
      current
          .map((i) =>
              i.integrationId == updated.integrationId ? updated : i)
          .toList(),
    );
  }
}
