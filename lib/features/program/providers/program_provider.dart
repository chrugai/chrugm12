import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/state/program_state.dart';
import '../services/program_service.dart';

final programServiceProvider = Provider<ProgramService>((ref) {
  final db = ref.watch(databaseProvider);
  return ProgramService(db);
});

final programProvider =
    StateNotifierProvider<ProgramNotifier, ProgramState>((ref) {
  final service = ref.watch(programServiceProvider);
  return ProgramNotifier(service);
});

class ProgramNotifier extends StateNotifier<ProgramState> {
  ProgramNotifier(this._service) : super(ProgramState.initial());

  final ProgramService _service;

  Future<void> loadPrograms() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final programs = await _service.getAllPrograms();
      final active = programs.where((p) => p.isActive).toList();
      state = state.copyWith(
        programs: programs,
        currentProgram: active.isNotEmpty ? active.first : null,
        selectedProgramId: active.isNotEmpty ? active.first.programId : null,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createProgram(String name, {String? description}) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final program = await _service.createProgram(name, description: description);
      state = state.copyWith(
        programs: [...state.programs.map((p) => p.copyWith(isActive: false)), program],
        currentProgram: program,
        selectedProgramId: program.programId,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> selectProgram(String programId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.selectProgram(programId);
      final programs = await _service.getAllPrograms();
      final current = programs.firstWhere((p) => p.programId == programId);
      state = state.copyWith(
        programs: programs,
        currentProgram: current,
        selectedProgramId: programId,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteProgram(String programId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.deleteProgram(programId);
      final programs = state.programs.where((p) => p.programId != programId).toList();
      state = state.copyWith(
        programs: programs,
        currentProgram: state.currentProgram?.programId == programId ? null : state.currentProgram,
        selectedProgramId: state.selectedProgramId == programId ? null : state.selectedProgramId,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> addDay(String programId, String dayName) async {
    try {
      final day = await _service.addDay(programId, dayName);
      final programs = state.programs.map((p) {
        if (p.programId == programId) {
          return p.copyWith(days: [...p.days, day]);
        }
        return p;
      }).toList();
      final current = state.currentProgram?.programId == programId
          ? programs.firstWhere((p) => p.programId == programId)
          : state.currentProgram;
      state = state.copyWith(programs: programs, currentProgram: current);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> renameDay(String dayId, String newName) async {
    try {
      await _service.renameDay(dayId, newName);
      await loadPrograms();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }


  Future<void> addExercisesToDay(
      String dayId, List<String> exerciseIds) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.addExercisesToDay(dayId, exerciseIds);
      await loadPrograms();
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> reorderExercises(String dayId, List<String> exerciseIds) async {
    try {
      await _service.reorderExercises(dayId, exerciseIds);
      await loadPrograms();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }
}
