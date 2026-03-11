import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/day.dart';
import 'package:chrugm12/data/models/exercise.dart';
import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/features/program/providers/program_provider.dart';
import 'package:chrugm12/features/program/screens/program_details_preview.dart';
import 'package:chrugm12/features/program/services/program_service.dart';

class FakeProgramNotifier extends ProgramNotifier {
  FakeProgramNotifier() : super(FakeProgramService());

  void setPrograms(List<Program> programs) {
    state = state.copyWith(programs: programs, isLoading: false);
  }
}

class FakeProgramService extends ProgramService {
  FakeProgramService() : super(null as dynamic);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

Exercise _exercise(String id, String name) => Exercise(
      exerciseId: id,
      name: name,
      muscleGroups: ['test'],
      createdAt: DateTime(2024),
    );

final _testProgram = Program(
  programId: 'prog_ppl',
  userId: 'local_user',
  name: 'Push / Pull / Legs',
  description: 'Classic 3-day split targeting push, pull, and legs.',
  days: [
    Day(
      dayId: 'day_push',
      programId: 'prog_ppl',
      dayNumber: 1,
      dayName: 'Push',
      exercises: [
        _exercise('ex_1', 'Bench Press'),
        _exercise('ex_2', 'Overhead Press'),
      ],
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
    Day(
      dayId: 'day_pull',
      programId: 'prog_ppl',
      dayNumber: 2,
      dayName: 'Pull',
      exercises: [
        _exercise('ex_3', 'Barbell Row'),
        _exercise('ex_4', 'Lat Pulldown'),
      ],
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
    Day(
      dayId: 'day_legs',
      programId: 'prog_ppl',
      dayNumber: 3,
      dayName: 'Legs',
      exercises: [
        _exercise('ex_5', 'Barbell Squat'),
        _exercise('ex_6', 'Leg Press'),
      ],
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
  ],
  isActive: true,
  createdAt: DateTime(2024),
  updatedAt: DateTime(2024),
);

Widget _buildTestWidget(FakeProgramNotifier notifier) {
  return ProviderScope(
    overrides: [
      programProvider.overrideWith((_) => notifier),
    ],
    child: const MaterialApp(
      home: ProgramDetailsPreview(programId: 'prog_ppl'),
    ),
  );
}

void main() {
  group('ProgramDetailsPreview', () {
    late FakeProgramNotifier notifier;

    setUp(() {
      notifier = FakeProgramNotifier();
      notifier.setPrograms([_testProgram]);
    });

    testWidgets('shows program name', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Push / Pull / Legs'), findsOneWidget);
    });

    testWidgets('shows program description', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(
        find.text('Classic 3-day split targeting push, pull, and legs.'),
        findsOneWidget,
      );
    });

    testWidgets('shows days badge', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('3 Days'), findsOneWidget);
    });

    testWidgets('shows day names in accordions', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Push'), findsOneWidget);
      expect(find.text('Pull'), findsOneWidget);
      expect(find.text('Legs'), findsOneWidget);
    });

    testWidgets('first day is expanded with exercises', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Bench Press'), findsOneWidget);
      expect(find.text('Overhead Press'), findsOneWidget);
    });

    testWidgets('shows Start Program button', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Start Program!'), findsOneWidget);
    });

    testWidgets('shows Program header label', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Program'), findsOneWidget);
    });

    testWidgets('shows back arrow', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
