import 'package:freezed_annotation/freezed_annotation.dart';

import 'day.dart';

part 'program.freezed.dart';
part 'program.g.dart';

@freezed
abstract class Program with _$Program {
  const factory Program({
    required String programId,
    required String userId,
    required String name,
    String? description,
    required List<Day> days,
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) =>
      _$ProgramFromJson(json);
}
