import 'package:freezed_annotation/freezed_annotation.dart';

import '../program.dart';

part 'program_state.freezed.dart';
part 'program_state.g.dart';

@freezed
abstract class ProgramState with _$ProgramState {
  const factory ProgramState({
    required List<Program> programs,
    String? selectedProgramId,
    Program? currentProgram,
    @Default(false) bool isLoading,
    String? error,
  }) = _ProgramState;

  factory ProgramState.initial() => const ProgramState(programs: []);

  factory ProgramState.fromJson(Map<String, dynamic> json) =>
      _$ProgramStateFromJson(json);
}
