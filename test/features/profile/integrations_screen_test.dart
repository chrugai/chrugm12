import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/integration.dart';
import 'package:chrugm12/features/profile/providers/integration_provider.dart';
import 'package:chrugm12/features/profile/screens/integrations_screen.dart';

// ── Fakes ──────────────────────────────────────────────────────────────────

class _FakeIntegrationNotifier
    extends StateNotifier<AsyncValue<List<Integration>>>
    implements IntegrationNotifier {
  _FakeIntegrationNotifier(AsyncValue<List<Integration>> initial)
      : super(initial);

  @override
  Future<void> loadIntegrations() async {}

  @override
  Future<void> connectIntegration(String integrationId) async {
    final current = state.valueOrNull ?? [];
    state = AsyncValue.data(
      current
          .map((i) => i.integrationId == integrationId
              ? i.copyWith(isConnected: true, lastSyncedAt: DateTime.now())
              : i)
          .toList(),
    );
  }

  @override
  Future<void> disconnectIntegration(String integrationId) async {
    final current = state.valueOrNull ?? [];
    state = AsyncValue.data(
      current
          .map((i) => i.integrationId == integrationId
              ? i.copyWith(isConnected: false, lastSyncedAt: null)
              : i)
          .toList(),
    );
  }

  @override
  Future<void> syncIntegration(String integrationId) async {
    final current = state.valueOrNull ?? [];
    state = AsyncValue.data(
      current
          .map((i) => i.integrationId == integrationId
              ? i.copyWith(lastSyncedAt: DateTime.now())
              : i)
          .toList(),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

// ── Helpers ────────────────────────────────────────────────────────────────

final _integrations = [
  const Integration(
    integrationId: 'integ_1',
    userId: 'u1',
    integrationName: 'Apple Health',
    isConnected: false,
  ),
  Integration(
    integrationId: 'integ_2',
    userId: 'u1',
    integrationName: 'Whoop',
    isConnected: true,
    lastSyncedAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  const Integration(
    integrationId: 'integ_3',
    userId: 'u1',
    integrationName: 'Garmin',
    isConnected: false,
  ),
];

Widget _wrap({AsyncValue<List<Integration>>? state}) {
  final notifier =
      _FakeIntegrationNotifier(state ?? AsyncValue.data(_integrations));

  return ProviderScope(
    overrides: [
      integrationProvider.overrideWith((_) => notifier),
    ],
    child: const MaterialApp(
      home: IntegrationsScreen(),
    ),
  );
}

// ── Tests ──────────────────────────────────────────────────────────────────

void main() {
  group('IntegrationsScreen', () {
    testWidgets('renders title and back arrow', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Integrations'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('renders all integration cards', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Apple Health'), findsOneWidget);
      expect(find.text('Whoop'), findsOneWidget);
      expect(find.text('Garmin'), findsOneWidget);
    });

    testWidgets('shows Connect button for disconnected integrations',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Connect'), findsNWidgets(2));
    });

    testWidgets('shows Connected chip for connected integrations',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.text('Connected'), findsOneWidget);
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows last synced for connected integrations',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.textContaining('Last synced:'), findsOneWidget);
    });

    testWidgets('shows sync icon for connected integrations', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.sync), findsOneWidget);
    });

    testWidgets('connect dialog opens on Connect tap', (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Connect').first);
      await tester.pumpAndSettle();

      expect(find.text('Apple Health'), findsWidgets);
      expect(find.textContaining('health data'), findsOneWidget);
      expect(find.text('Allow'), findsOneWidget);
      expect(find.text("Don't Allow"), findsOneWidget);
    });

    testWidgets('disconnect dialog opens on Connected chip tap',
        (tester) async {
      await tester.pumpWidget(_wrap());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Connected'));
      await tester.pumpAndSettle();

      expect(find.textContaining('Disconnect from Whoop'), findsOneWidget);
      expect(find.text('Disconnect'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
    });

    testWidgets('shows loading state', (tester) async {
      await tester.pumpWidget(
          _wrap(state: const AsyncValue<List<Integration>>.loading()));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
