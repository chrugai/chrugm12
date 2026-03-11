import 'package:drift/drift.dart';

import 'users_table.dart';

class Measurements extends Table {
  TextColumn get measurementId => text()();
  TextColumn get userId => text().references(Users, #userId)();
  TextColumn get measurementDate => text()();
  RealColumn get neckCm => real().nullable()();
  RealColumn get shouldersCm => real().nullable()();
  RealColumn get chestCm => real().nullable()();
  RealColumn get bicepsLCm => real().nullable()();
  RealColumn get bicepsRCm => real().nullable()();
  RealColumn get forearmsLCm => real().nullable()();
  RealColumn get forearmsRCm => real().nullable()();
  RealColumn get waistCm => real().nullable()();
  RealColumn get hipsCm => real().nullable()();
  RealColumn get thighsLCm => real().nullable()();
  RealColumn get thighsRCm => real().nullable()();
  RealColumn get calvesLCm => real().nullable()();
  RealColumn get calvesRCm => real().nullable()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {measurementId};
}
