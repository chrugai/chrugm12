import 'package:drift/drift.dart';

import 'users_table.dart';

class Uploads extends Table {
  TextColumn get uploadId => text()();
  TextColumn get userId => text().references(Users, #userId)();
  TextColumn get fileName => text()();
  TextColumn get fileType => text()();
  TextColumn get filePath => text()();
  TextColumn get uploadDate => text()();
  TextColumn get createdAt => text()();

  @override
  Set<Column> get primaryKey => {uploadId};
}
