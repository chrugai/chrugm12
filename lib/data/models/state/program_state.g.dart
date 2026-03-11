// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramStateImpl _$$ProgramStateImplFromJson(Map<String, dynamic> json) =>
    _$ProgramStateImpl(
      programs: (json['programs'] as List<dynamic>)
          .map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedProgramId: json['selectedProgramId'] as String?,
      currentProgram: json['currentProgram'] == null
          ? null
          : Program.fromJson(json['currentProgram'] as Map<String, dynamic>),
      isLoading: json['isLoading'] as bool? ?? false,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$ProgramStateImplToJson(_$ProgramStateImpl instance) =>
    <String, dynamic>{
      'programs': instance.programs,
      'selectedProgramId': instance.selectedProgramId,
      'currentProgram': instance.currentProgram,
      'isLoading': instance.isLoading,
      'error': instance.error,
    };
