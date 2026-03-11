import 'package:drift/drift.dart';

class Messages extends Table {
  TextColumn get messageId => text()();
  TextColumn get chatId => text()();
  TextColumn get role => text()();
  TextColumn get content => text()();
  TextColumn get fileUrl => text().nullable()();
  TextColumn get timestamp => text()();

  @override
  Set<Column> get primaryKey => {messageId};
}
