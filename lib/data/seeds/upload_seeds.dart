import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedUploads(AppDatabase db) async {
  final now = DateTime.now().toIso8601String();
  await db.transaction(() async {
    await db.uploadDao.insertUpload(UploadsCompanion(uploadId: const Value('upload_1'), userId: const Value('local_user'), fileName: const Value('Bloodwork_Jan2025.pdf'), fileType: const Value('application/pdf'), filePath: const Value('/uploads/Bloodwork_Jan2025.pdf'), uploadDate: const Value('2025-01-15'), createdAt: Value(now)));
    await db.uploadDao.insertUpload(UploadsCompanion(uploadId: const Value('upload_2'), userId: const Value('local_user'), fileName: const Value('Progress_Photo.jpg'), fileType: const Value('image/jpeg'), filePath: const Value('/uploads/Progress_Photo.jpg'), uploadDate: const Value('2025-02-10'), createdAt: Value(now)));
    await db.uploadDao.insertUpload(UploadsCompanion(uploadId: const Value('upload_3'), userId: const Value('local_user'), fileName: const Value('Vitamin_Panel.pdf'), fileType: const Value('application/pdf'), filePath: const Value('/uploads/Vitamin_Panel.pdf'), uploadDate: const Value('2025-03-01'), createdAt: Value(now)));
  });
}
