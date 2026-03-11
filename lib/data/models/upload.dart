import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload.freezed.dart';
part 'upload.g.dart';

@freezed
abstract class Upload with _$Upload {
  const factory Upload({
    required String uploadId,
    required String userId,
    required String fileName,
    required String fileType,
    required String filePath,
    required String uploadDate,
    required DateTime createdAt,
  }) = _Upload;

  factory Upload.fromJson(Map<String, dynamic> json) =>
      _$UploadFromJson(json);
}
