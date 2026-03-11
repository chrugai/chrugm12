import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/upload.dart' as models;

const _uuid = Uuid();

class UploadService {
  UploadService(this._db);

  final AppDatabase _db;

  Future<List<models.Upload>> getAllUploads(String userId) async {
    final rows = await (_db.select(_db.uploads)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.uploadDate)]))
        .get();
    return rows.map(_uploadFromRow).toList();
  }

  Future<models.Upload> addUpload({
    required String userId,
    required String fileName,
    required String fileType,
    required String filePath,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    final nowIso = now.toIso8601String();
    final date = nowIso.substring(0, 10);

    await _db.uploadDao.insertUpload(UploadsCompanion(
      uploadId: Value(id),
      userId: Value(userId),
      fileName: Value(fileName),
      fileType: Value(fileType),
      filePath: Value(filePath),
      uploadDate: Value(date),
      createdAt: Value(nowIso),
    ));

    return models.Upload(
      uploadId: id,
      userId: userId,
      fileName: fileName,
      fileType: fileType,
      filePath: filePath,
      uploadDate: date,
      createdAt: now,
    );
  }

  Future<void> deleteUpload(String uploadId) async {
    await _db.uploadDao.deleteUpload(uploadId);
  }

  models.Upload _uploadFromRow(Upload row) {
    return models.Upload(
      uploadId: row.uploadId,
      userId: row.userId,
      fileName: row.fileName,
      fileType: row.fileType,
      filePath: row.filePath,
      uploadDate: row.uploadDate,
      createdAt: DateTime.parse(row.createdAt),
    );
  }
}
