import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/uploads_table.dart';

part 'upload_dao.g.dart';

@DriftAccessor(tables: [Uploads])
class UploadDao extends DatabaseAccessor<AppDatabase> with _$UploadDaoMixin {
  UploadDao(super.db);

  Future<List<Upload>> getAllUploads() => select(uploads).get();

  Future<void> insertUpload(UploadsCompanion upload) =>
      into(uploads).insert(upload);

  Future<int> deleteUpload(String id) =>
      (delete(uploads)..where((t) => t.uploadId.equals(id))).go();
}
