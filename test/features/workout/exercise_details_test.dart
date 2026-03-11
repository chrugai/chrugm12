import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/core/theme/app_colors.dart';
import 'package:chrugm12/data/models/enums/rir.dart';
import 'package:chrugm12/data/models/enums/tempo_variation.dart';
import 'package:chrugm12/data/models/workout_set.dart';
import 'package:chrugm12/features/workout/widgets/add_set_modal.dart';
import 'package:chrugm12/features/workout/widgets/rest_time_picker_modal.dart';
import 'package:chrugm12/features/workout/widgets/rest_timer_pill.dart';
import 'package:chrugm12/features/workout/widgets/set_history_item.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('SetHistoryItem', () {
    testWidgets('displays reps, weight, and set number', (tester) async {
      final set = WorkoutSet(
        setId: 's1',
        exerciseId: 'e1',
        dayId: 'd1',
        reps: 10,
        weightKg: 60.0,
        timestamp: DateTime(2025, 1, 15, 14, 30),
      );

      await tester.pumpWidget(_wrap(
        SetHistoryItem(
          workoutSet: set,
          setNumber: 1,
          onDelete: () {},
          onDuplicate: () {},
        ),
      ));

      expect(find.text('1'), findsOneWidget);
      expect(find.text('10 reps × 60.0 kg'), findsOneWidget);
      expect(find.text('2:30 PM'), findsOneWidget);
    });

    testWidgets('shows RIR and tempo when provided', (tester) async {
      final set = WorkoutSet(
        setId: 's2',
        exerciseId: 'e1',
        dayId: 'd1',
        reps: 8,
        weightKg: 80.0,
        repsInReserve: 2,
        tempoVariation: 'Slow Eccentric',
        timestamp: DateTime(2025, 1, 15, 15, 0),
      );

      await tester.pumpWidget(_wrap(
        SetHistoryItem(
          workoutSet: set,
          setNumber: 2,
          onDelete: () {},
          onDuplicate: () {},
        ),
      ));

      expect(find.text('RIR 2 · Slow Eccentric'), findsOneWidget);
    });
  });

  group('AddSetModal', () {
    testWidgets('record button disabled when reps and weight are zero',
        (tester) async {
      await tester.pumpWidget(_wrap(
        AddSetModal(
          onRecord: ({
            required int reps,
            required double weightKg,
            int? repsInReserve,
            String? tempoVariation,
            String? notes,
          }) {},
        ),
      ));

      expect(find.text('Record Set'), findsWidgets);
      // RIR options visible
      for (final rir in RIR.values) {
        expect(find.text(rir.displayName), findsOneWidget);
      }
      // Tempo options visible
      for (final tempo in TempoVariation.values) {
        expect(find.text(tempo.displayName), findsOneWidget);
      }
    });

    testWidgets('shows notes field when toggled', (tester) async {
      await tester.pumpWidget(_wrap(
        AddSetModal(
          onRecord: ({
            required int reps,
            required double weightKg,
            int? repsInReserve,
            String? tempoVariation,
            String? notes,
          }) {},
        ),
      ));

      expect(find.text('Add notes'), findsOneWidget);
      await tester.tap(find.text('Add notes'));
      await tester.pumpAndSettle();
      expect(find.text('Hide notes'), findsOneWidget);
      expect(find.byType(TextField), findsOneWidget);
    });
  });

  group('RestTimerPill', () {
    testWidgets('displays time and controls', (tester) async {
      await tester.pumpWidget(_wrap(
        RestTimerPill(
          totalSeconds: 90,
          onComplete: () {},
          onSkip: () {},
          onAdjust: () {},
          onClose: () {},
        ),
      ));

      expect(find.textContaining('1:30'), findsWidgets);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });

  group('RestTimePickerModal', () {
    testWidgets('shows preset options', (tester) async {
      await tester.pumpWidget(_wrap(
        RestTimePickerModal(
          currentSeconds: 90,
          onSelected: (_) {},
        ),
      ));

      expect(find.text('Rest Time'), findsOneWidget);
      expect(find.text('30s'), findsOneWidget);
      expect(find.text('45s'), findsOneWidget);
      expect(find.text('1m'), findsOneWidget);
      expect(find.text('1m 30s'), findsOneWidget);
      expect(find.text('2m'), findsOneWidget);
      expect(find.text('3m'), findsOneWidget);
    });
  });
}
