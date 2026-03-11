import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/upload.dart' as models;
import '../services/upload_service.dart';

final uploadServiceProvider = Provider<UploadService>((ref) {
  final db = ref.watch(databaseProvider);
  return UploadService(db);
});

final uploadProvider =
    StateNotifierProvider<UploadNotifier, AsyncValue<List<models.Upload>>>(
        (ref) {
  final service = ref.watch(uploadServiceProvider);
  return UploadNotifier(service);
});

class UploadNotifier extends StateNotifier<AsyncValue<List<models.Upload>>> {
  UploadNotifier(this._service) : super(const AsyncValue.loading());

  final UploadService _service;

  Future<void> loadUploads() async {
    state = const AsyncValue.loading();
    try {
      final uploads = await _service.getAllUploads('local_user');
      state = AsyncValue.data(uploads);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addUpload({
    required String fileName,
    required String fileType,
    required String filePath,
  }) async {
    try {
      final upload = await _service.addUpload(
        userId: 'local_user',
        fileName: fileName,
        fileType: fileType,
        filePath: filePath,
      );
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data([upload, ...current]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteUpload(String uploadId) async {
    try {
      await _service.deleteUpload(uploadId);
      final current = state.valueOrNull ?? [];
      state = AsyncValue.data(
        current.where((u) => u.uploadId != uploadId).toList(),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
