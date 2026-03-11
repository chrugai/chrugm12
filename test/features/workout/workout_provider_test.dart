import 'package:chrugm12/data/models/exercise.dart';
import 'package:chrugm12/data/models/state/workout_state.dart';
import 'package:chrugm12/data/models/workout_set.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WorkoutState', () {
    test('initial state has empty lists and defaults', () {
      final state = WorkoutState.initial();
      expect(state.selectedDayId, isNull);
      expect(state.currentDayExercises, isEmpty);
      expect(state.loggedSets, isEmpty);
      expect(state.restTimerActive, isFalse);
      expect(state.selectedRestTimeSeconds, 180);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('copyWith updates selected day', () {
      final state = WorkoutState.initial();
      final updated = state.copyWith(selectedDayId: 'day_1');
      expect(updated.selectedDayId, 'day_1');
      expect(updated.loggedSets, isEmpty);
    });

    test('copyWith adds logged sets', () {
      final state = WorkoutState.initial();
      final set = WorkoutSet(
        setId: 'set_1',
        exerciseId: 'ex_1',
        dayId: 'day_1',
        reps: 10,
        weightKg: 80.0,
        timestamp: DateTime(2026, 3, 11),
      );
      final updated = state.copyWith(loggedSets: [set]);
      expect(updated.loggedSets.length, 1);
      expect(updated.loggedSets.first.reps, 10);
      expect(updated.loggedSets.first.weightKg, 80.0);
    });

    test('copyWith toggles rest timer', () {
      final state = WorkoutState.initial();
      expect(state.restTimerActive, isFalse);
      final toggled = state.copyWith(restTimerActive: true);
      expect(toggled.restTimerActive, isTrue);
    });

    test('copyWith sets rest time', () {
      final state = WorkoutState.initial();
      final updated = state.copyWith(selectedRestTimeSeconds: 90);
      expect(updated.selectedRestTimeSeconds, 90);
    });

    test('copyWith sets exercises for day', () {
      final state = WorkoutState.initial();
      final exercise = Exercise(
        exerciseId: 'ex_bench',
        name: 'Bench Press',
        muscleGroups: ['chest', 'triceps'],
        isCompound: true,
        createdAt: DateTime(2026, 1, 1),
      );
      final updated = state.copyWith(currentDayExercises: [exercise]);
      expect(updated.currentDayExercises.length, 1);
      expect(updated.currentDayExercises.first.name, 'Bench Press');
    });

    test('delete set removes from list', () {
      final sets = [
        WorkoutSet(
          setId: 'set_1',
          exerciseId: 'ex_1',
          dayId: 'day_1',
          reps: 10,
          weightKg: 80.0,
          timestamp: DateTime(2026, 3, 11),
        ),
        WorkoutSet(
          setId: 'set_2',
          exerciseId: 'ex_1',
          dayId: 'day_1',
          reps: 8,
          weightKg: 85.0,
          timestamp: DateTime(2026, 3, 11),
        ),
      ];
      final state = WorkoutState.initial().copyWith(loggedSets: sets);
      final afterDelete = state.copyWith(
        loggedSets: state.loggedSets.where((s) => s.setId != 'set_1').toList(),
      );
      expect(afterDelete.loggedSets.length, 1);
      expect(afterDelete.loggedSets.first.setId, 'set_2');
    });
  });
}
