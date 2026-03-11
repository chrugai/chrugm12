import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/integrations_table.dart';

part 'integration_dao.g.dart';

@DriftAccessor(tables: [Integrations])
class IntegrationDao extends DatabaseAccessor<AppDatabase>
    with _$IntegrationDaoMixin {
  IntegrationDao(super.db);

  Future<List<Integration>> getAllIntegrations() =>
      select(integrations).get();

  Future<Integration?> getIntegrationByName(String name) =>
      (select(integrations)
            ..where((t) => t.integrationName.equals(name)))
          .getSingleOrNull();

  Future<bool> updateIntegration(IntegrationsCompanion integration) =>
      update(integrations).replace(integration);
}
