import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/day.dart';

void main() {
  group('ProgramState', () {
    test('initial state has empty programs list', () {
      final state = ProgramState.initial();
      expect(state.programs, isEmpty);
      expect(state.currentProgram, isNull);
      expect(state.selectedProgramId, isNull);
      expect(state.isLoading, false);
    });

    test('copyWith updates programs and current program', () {
      final now = DateTime.utc(2026, 1, 1);
      final program = Program(
        programId: 'p1',
        userId: 'u1',
        name: 'PPL',
        days: const [],
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );

      final state = ProgramState.initial().copyWith(
        programs: [program],
        currentProgram: program,
        selectedProgramId: 'p1',
      );

      expect(state.programs.length, 1);
      expect(state.currentProgram?.name, 'PPL');
      expect(state.selectedProgramId, 'p1');
    });

    test('delete program removes it from list', () {
      final now = DateTime.utc(2026, 1, 1);
      final p1 = Program(programId: 'p1', userId: 'u1', name: 'PPL', days: const [], isActive: true, createdAt: now, updatedAt: now);
      final p2 = Program(programId: 'p2', userId: 'u1', name: 'Upper Lower', days: const [], isActive: false, createdAt: now, updatedAt: now);

      var state = ProgramState.initial().copyWith(
        programs: [p1, p2],
        currentProgram: p1,
        selectedProgramId: 'p1',
      );

      // Simulate delete of p1
      final remaining = state.programs.where((p) => p.programId != 'p1').toList();
      state = state.copyWith(
        programs: remaining,
        currentProgram: null,
        selectedProgramId: null,
      );

      expect(state.programs.length, 1);
      expect(state.programs.first.name, 'Upper Lower');
      expect(state.currentProgram, isNull);
    });

    test('add day to program', () {
      final now = DateTime.utc(2026, 1, 1);
      final program = Program(programId: 'p1', userId: 'u1', name: 'PPL', days: const [], isActive: true, createdAt: now, updatedAt: now);
      final day = Day(dayId: 'd1', programId: 'p1', dayNumber: 1, dayName: 'Push', exercises: const [], createdAt: now, updatedAt: now);

      final updated = program.copyWith(days: [...program.days, day]);
      expect(updated.days.length, 1);
      expect(updated.days.first.dayName, 'Push');
    });

    test('rename day via copyWith', () {
      final now = DateTime.utc(2026, 1, 1);
      final day = Day(dayId: 'd1', programId: 'p1', dayNumber: 1, dayName: 'Push', exercises: const [], createdAt: now, updatedAt: now);

      final renamed = day.copyWith(dayName: 'Chest & Triceps');
      expect(renamed.dayName, 'Chest & Triceps');
      expect(renamed.dayId, 'd1');
    });
  });
}
