import 'package:drift/drift.dart';

class Users extends Table {
  TextColumn get userId => text()();
  TextColumn get email => text().unique()();
  TextColumn get name => text().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  TextColumn get birthDate => text().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get profilePicturePath => text().nullable()();
  BoolColumn get isAuthenticated => boolean().withDefault(const Constant(false))();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {userId};
}
