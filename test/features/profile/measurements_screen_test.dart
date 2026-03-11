import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/measurement.dart';
import 'package:chrugm12/features/profile/providers/measurement_provider.dart';
import 'package:chrugm12/features/profile/screens/measurements_screen.dart';
import 'package:chrugm12/features/profile/widgets/add_measurement_form.dart';
import 'package:chrugm12/features/profile/widgets/measurement_card.dart';

class FakeMeasurementNotifier
    extends StateNotifier<AsyncValue<List<Measurement>>>
    implements MeasurementNotifier {
  FakeMeasurementNotifier(super.state);

  @override
  Future<void> loadMeasurements() async {}

  @override
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
  }) async {}

  @override
  Future<void> deleteMeasurement(String measurementId) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final _sampleMeasurement = Measurement(
  measurementId: 'm1',
  userId: 'u1',
  measurementDate: '2026-03-11',
  neckCm: 38.5,
  shouldersCm: 120.0,
  chestCm: 105.0,
  bicepsLCm: 35.0,
  bicepsRCm: 35.5,
  forearmLCm: 28.0,
  forearmRCm: 28.5,
  waistCm: 82.0,
  hipsCm: 95.0,
  thighLCm: 60.0,
  thighRCm: 60.5,
  calvesLCm: 38.0,
  calvesRCm: 38.0,
  createdAt: DateTime(2026, 3, 11),
);

Widget _buildApp({
  required AsyncValue<List<Measurement>> state,
}) {
  return ProviderScope(
    overrides: [
      measurementProvider.overrideWith(
        (_) => FakeMeasurementNotifier(state),
      ),
    ],
    child: const MaterialApp(home: MeasurementsScreen()),
  );
}

void main() {
  group('MeasurementsScreen', () {
    testWidgets('shows empty state when no measurements', (tester) async {
      await tester.pumpWidget(_buildApp(
        state: const AsyncValue.data([]),
      ));
      await tester.pumpAndSettle();

      expect(find.text('No measurements yet'), findsOneWidget);
      expect(find.text('Tap + to add your first measurement'), findsOneWidget);
    });

    testWidgets('shows loading indicator', (tester) async {
      await tester.pumpWidget(_buildApp(
        state: const AsyncValue.loading(),
      ));
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders measurement cards with data', (tester) async {
      await tester.pumpWidget(_buildApp(
        state: AsyncValue.data([_sampleMeasurement]),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(MeasurementCard), findsOneWidget);
      expect(find.text('2026-03-11'), findsOneWidget);
      expect(find.text('38.5 cm'), findsOneWidget); // neck
      expect(find.text('Neck'), findsOneWidget);
    });

    testWidgets('has FAB to open add form', (tester) async {
      await tester.pumpWidget(_buildApp(
        state: const AsyncValue.data([]),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('shows app bar with title', (tester) async {
      await tester.pumpWidget(_buildApp(
        state: const AsyncValue.data([]),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Measurements'), findsOneWidget);
    });

    testWidgets('card shows only non-null measurements', (tester) async {
      final partial = Measurement(
        measurementId: 'm2',
        userId: 'u1',
        measurementDate: '2026-03-10',
        neckCm: 40.0,
        waistCm: 85.0,
        createdAt: DateTime(2026, 3, 10),
      );

      await tester.pumpWidget(_buildApp(
        state: AsyncValue.data([partial]),
      ));
      await tester.pumpAndSettle();

      expect(find.text('Neck'), findsOneWidget);
      expect(find.text('Waist'), findsOneWidget);
      expect(find.text('Shoulders'), findsNothing);
      expect(find.text('Biceps L'), findsNothing);
    });
  });

  group('AddMeasurementForm', () {
    testWidgets('has 13 measurement fields', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AddMeasurementForm(
            onSave: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();

      const labels = [
        'Neck', 'Shoulders', 'Chest',
        'Biceps L', 'Biceps R',
        'Forearm L', 'Forearm R',
        'Waist', 'Hips',
        'Thigh L', 'Thigh R',
        'Calves L', 'Calves R',
      ];
      for (final label in labels) {
        await tester.scrollUntilVisible(find.text(label), 100);
        expect(find.text(label), findsOneWidget, reason: 'Missing field: \$label');
      }
    });

    testWidgets('save button disabled when no values', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AddMeasurementForm(
            onSave: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.scrollUntilVisible(find.text('Save'), 100);
      expect(find.text('Save'), findsOneWidget);
      // AppButton uses Opacity 0.5 when disabled
      final opacity = tester.widget<Opacity>(
        find.ancestor(
          of: find.text('Save'),
          matching: find.byType(Opacity),
        ).first,
      );
      expect(opacity.opacity, 0.5);
    });

    testWidgets('pre-fills from last entry', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: AddMeasurementForm(
            prefill: _sampleMeasurement,
            onSave: (_) {},
          ),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('38.5'), findsOneWidget); // neck
      expect(find.text('120'), findsOneWidget); // shoulders (whole number)
    });
  });
}
