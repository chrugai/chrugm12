// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UploadImpl _$$UploadImplFromJson(Map<String, dynamic> json) => _$UploadImpl(
  uploadId: json['uploadId'] as String,
  userId: json['userId'] as String,
  fileName: json['fileName'] as String,
  fileType: json['fileType'] as String,
  filePath: json['filePath'] as String,
  uploadDate: json['uploadDate'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$UploadImplToJson(_$UploadImpl instance) =>
    <String, dynamic>{
      'uploadId': instance.uploadId,
      'userId': instance.userId,
      'fileName': instance.fileName,
      'fileType': instance.fileType,
      'filePath': instance.filePath,
      'uploadDate': instance.uploadDate,
      'createdAt': instance.createdAt.toIso8601String(),
    };
