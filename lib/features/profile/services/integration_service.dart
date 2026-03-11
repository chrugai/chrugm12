import 'package:drift/drift.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/integration.dart' as models;

class IntegrationService {
  IntegrationService(this._db);

  final AppDatabase _db;

  Future<List<models.Integration>> getAllIntegrations(String userId) async {
    final rows = await (_db.select(_db.integrations)
          ..where((t) => t.userId.equals(userId)))
        .get();
    return rows.map(_integrationFromRow).toList();
  }

  Future<models.Integration> connectIntegration(String integrationId) async {
    final now = DateTime.now().toIso8601String();
    final row = await (_db.select(_db.integrations)
          ..where((t) => t.integrationId.equals(integrationId)))
        .getSingle();

    await _db.integrationDao.updateIntegration(IntegrationsCompanion(
      integrationId: Value(row.integrationId),
      userId: Value(row.userId),
      integrationName: Value(row.integrationName),
      isConnected: const Value(true),
      lastSyncedAt: Value(now),
    ));

    return models.Integration(
      integrationId: row.integrationId,
      userId: row.userId,
      integrationName: row.integrationName,
      isConnected: true,
      lastSyncedAt: DateTime.now(),
    );
  }

  Future<models.Integration> disconnectIntegration(
      String integrationId) async {
    final row = await (_db.select(_db.integrations)
          ..where((t) => t.integrationId.equals(integrationId)))
        .getSingle();

    await _db.integrationDao.updateIntegration(IntegrationsCompanion(
      integrationId: Value(row.integrationId),
      userId: Value(row.userId),
      integrationName: Value(row.integrationName),
      isConnected: const Value(false),
      lastSyncedAt: const Value(null),
    ));

    return models.Integration(
      integrationId: row.integrationId,
      userId: row.userId,
      integrationName: row.integrationName,
      isConnected: false,
    );
  }

  Future<models.Integration> syncIntegration(String integrationId) async {
    // Mock 1-2 second delay
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    final now = DateTime.now().toIso8601String();
    final row = await (_db.select(_db.integrations)
          ..where((t) => t.integrationId.equals(integrationId)))
        .getSingle();

    await _db.integrationDao.updateIntegration(IntegrationsCompanion(
      integrationId: Value(row.integrationId),
      userId: Value(row.userId),
      integrationName: Value(row.integrationName),
      isConnected: Value(row.isConnected),
      lastSyncedAt: Value(now),
    ));

    return models.Integration(
      integrationId: row.integrationId,
      userId: row.userId,
      integrationName: row.integrationName,
      isConnected: row.isConnected,
      lastSyncedAt: DateTime.now(),
    );
  }

  models.Integration _integrationFromRow(Integration row) {
    return models.Integration(
      integrationId: row.integrationId,
      userId: row.userId,
      integrationName: row.integrationName,
      isConnected: row.isConnected,
      lastSyncedAt:
          row.lastSyncedAt != null ? DateTime.parse(row.lastSyncedAt!) : null,
      syncError: row.syncError,
    );
  }
}
