import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/programs_table.dart';

part 'program_dao.g.dart';

@DriftAccessor(tables: [Programs])
class ProgramDao extends DatabaseAccessor<AppDatabase> with _$ProgramDaoMixin {
  ProgramDao(super.db);

  Future<List<Program>> getAllPrograms() => select(programs).get();

  Future<Program?> getProgramById(String id) =>
      (select(programs)..where((t) => t.programId.equals(id)))
          .getSingleOrNull();

  Future<Program?> getActiveProgram() =>
      (select(programs)..where((t) => t.isActive.equals(true)))
          .getSingleOrNull();

  Future<void> insertProgram(ProgramsCompanion program) =>
      into(programs).insert(program);

  Future<bool> updateProgram(ProgramsCompanion program) =>
      update(programs).replace(program);

  Future<int> deleteProgram(String id) =>
      (delete(programs)..where((t) => t.programId.equals(id))).go();
}
