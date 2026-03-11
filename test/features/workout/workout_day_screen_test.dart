import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/database/app_database.dart'
    hide Day, Exercise, Program;
import 'package:chrugm12/data/models/day.dart';
import 'package:chrugm12/data/models/exercise.dart';
import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/data/models/state/workout_state.dart';
import 'package:chrugm12/data/models/workout_set.dart';
import 'package:chrugm12/features/program/providers/program_provider.dart';
import 'package:chrugm12/features/workout/providers/workout_provider.dart';
import 'package:chrugm12/features/workout/screens/workout_day_screen.dart';
import 'package:chrugm12/features/workout/services/workout_service.dart';

// ── Fakes ──────────────────────────────────────────────────────────────────

class _FakeAppDb extends Fake implements AppDatabase {}

class _FakeProgramNotifier extends StateNotifier<ProgramState>
    implements ProgramNotifier {
  _FakeProgramNotifier(ProgramState initial) : super(initial);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

class _FakeWorkoutNotifier extends StateNotifier<WorkoutState>
    implements WorkoutNotifier {
  _FakeWorkoutNotifier(WorkoutState initial) : super(initial);

  @override
  Future<void> selectDay(String dayId) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

// ── Helpers ────────────────────────────────────────────────────────────────

final _now = DateTime(2025, 6, 15, 10, 0);

Exercise _exercise(String id, String name) => Exercise(
      exerciseId: id,
      name: name,
      category: 'Strength',
      equipment: 'Barbell',
      movementType: 'Compound',
      muscleGroups: const ['Chest'],
      isCompound: true,
      isUserCustom: false,
      createdAt: _now,
    );

Day _day({
  String id = 'day-1',
  String name = 'Day 1',
  List<Exercise>? exercises,
}) =>
    Day(
      dayId: id,
      programId: 'prog-1',
      dayNumber: 1,
      dayName: name,
      exercises: exercises ?? [],
      createdAt: _now,
      updatedAt: _now,
    );

Program _program({List<Day>? days}) => Program(
      programId: 'prog-1',
      userId: 'u1',
      name: 'My Program',
      days: days ?? [_day()],
      isActive: true,
      createdAt: _now,
      updatedAt: _now,
    );

Widget _wrap({
  required ProgramState programState,
  WorkoutState? workoutState,
  String dayId = 'day-1',
}) {
  final fakeProgNotifier = _FakeProgramNotifier(programState);
  final fakeWorkoutNotifier =
      _FakeWorkoutNotifier(workoutState ?? WorkoutState.initial());
  final fakeDb = _FakeAppDb();

  return ProviderScope(
    overrides: [
      programProvider.overrideWith((_) => fakeProgNotifier),
      workoutProvider.overrideWith((_) => fakeWorkoutNotifier),
      databaseProvider.overrideWithValue(fakeDb),
      workoutServiceProvider
          .overrideWithValue(WorkoutService(fakeDb)),
    ],
    child: MaterialApp(
      home: WorkoutDayScreen(dayId: dayId),
    ),
  );
}

// ── Tests ──────────────────────────────────────────────────────────────────

void main() {
  final bench = _exercise('e1', 'Bench Press');
  final squat = _exercise('e2', 'Squat');
  final exercises = [bench, squat];

  final dayWithExercises = _day(exercises: exercises);
  final programState = ProgramState(
    programs: [_program(days: [dayWithExercises])],
    currentProgram: _program(days: [dayWithExercises]),
    selectedProgramId: 'prog-1',
    isLoading: false,
  );

  group('WorkoutDayScreen', () {
    testWidgets('renders exercise cards', (tester) async {
      await tester.pumpWidget(_wrap(programState: programState));
      await tester.pumpAndSettle();

      expect(find.text('Bench Press'), findsOneWidget);
      expect(find.text('Squat'), findsOneWidget);
    });

    testWidgets('renders last set info', (tester) async {
      final workoutState = WorkoutState(
        selectedDayId: 'day-1',
        currentDayExercises: exercises,
        loggedSets: [
          WorkoutSet(
            setId: 's1',
            exerciseId: 'e1',
            dayId: 'day-1',
            reps: 10,
            weightKg: 80.0,
            timestamp: _now,
          ),
        ],
      );

      await tester.pumpWidget(_wrap(
        programState: programState,
        workoutState: workoutState,
      ));
      await tester.pumpAndSettle();

      // 80kg → 176 lb, 10 reps
      expect(find.textContaining('176 lb'), findsOneWidget);
      expect(find.textContaining('10 reps'), findsOneWidget);
    });

    testWidgets('shows empty state when no exercises', (tester) async {
      final emptyProgState = ProgramState(
        programs: [_program()],
        currentProgram: _program(),
        selectedProgramId: 'prog-1',
        isLoading: false,
      );

      await tester.pumpWidget(_wrap(programState: emptyProgState));
      await tester.pumpAndSettle();

      expect(find.text('Add your first exercise'), findsOneWidget);
    });

    testWidgets('FAB is visible', (tester) async {
      await tester.pumpWidget(_wrap(programState: programState));
      await tester.pumpAndSettle();

      expect(find.text('Add Exercise'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });

    testWidgets('rename link is visible', (tester) async {
      await tester.pumpWidget(_wrap(programState: programState));
      await tester.pumpAndSettle();

      expect(find.text('rename day?'), findsOneWidget);
    });

    testWidgets('rename modal opens on tap', (tester) async {
      await tester.pumpWidget(_wrap(programState: programState));
      await tester.pumpAndSettle();

      await tester.tap(find.text('rename day?'));
      await tester.pumpAndSettle();

      expect(find.text('Rename Day'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
    });
  });
}
