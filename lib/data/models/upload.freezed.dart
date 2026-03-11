// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Upload _$UploadFromJson(Map<String, dynamic> json) {
  return _Upload.fromJson(json);
}

/// @nodoc
mixin _$Upload {
  String get uploadId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get fileName => throw _privateConstructorUsedError;
  String get fileType => throw _privateConstructorUsedError;
  String get filePath => throw _privateConstructorUsedError;
  String get uploadDate => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this Upload to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Upload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UploadCopyWith<Upload> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UploadCopyWith<$Res> {
  factory $UploadCopyWith(Upload value, $Res Function(Upload) then) =
      _$UploadCopyWithImpl<$Res, Upload>;
  @useResult
  $Res call({
    String uploadId,
    String userId,
    String fileName,
    String fileType,
    String filePath,
    String uploadDate,
    DateTime createdAt,
  });
}

/// @nodoc
class _$UploadCopyWithImpl<$Res, $Val extends Upload>
    implements $UploadCopyWith<$Res> {
  _$UploadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Upload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadId = null,
    Object? userId = null,
    Object? fileName = null,
    Object? fileType = null,
    Object? filePath = null,
    Object? uploadDate = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            uploadId: null == uploadId
                ? _value.uploadId
                : uploadId // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            fileName: null == fileName
                ? _value.fileName
                : fileName // ignore: cast_nullable_to_non_nullable
                      as String,
            fileType: null == fileType
                ? _value.fileType
                : fileType // ignore: cast_nullable_to_non_nullable
                      as String,
            filePath: null == filePath
                ? _value.filePath
                : filePath // ignore: cast_nullable_to_non_nullable
                      as String,
            uploadDate: null == uploadDate
                ? _value.uploadDate
                : uploadDate // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UploadImplCopyWith<$Res> implements $UploadCopyWith<$Res> {
  factory _$$UploadImplCopyWith(
    _$UploadImpl value,
    $Res Function(_$UploadImpl) then,
  ) = __$$UploadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String uploadId,
    String userId,
    String fileName,
    String fileType,
    String filePath,
    String uploadDate,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$UploadImplCopyWithImpl<$Res>
    extends _$UploadCopyWithImpl<$Res, _$UploadImpl>
    implements _$$UploadImplCopyWith<$Res> {
  __$$UploadImplCopyWithImpl(
    _$UploadImpl _value,
    $Res Function(_$UploadImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Upload
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadId = null,
    Object? userId = null,
    Object? fileName = null,
    Object? fileType = null,
    Object? filePath = null,
    Object? uploadDate = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$UploadImpl(
        uploadId: null == uploadId
            ? _value.uploadId
            : uploadId // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        fileName: null == fileName
            ? _value.fileName
            : fileName // ignore: cast_nullable_to_non_nullable
                  as String,
        fileType: null == fileType
            ? _value.fileType
            : fileType // ignore: cast_nullable_to_non_nullable
                  as String,
        filePath: null == filePath
            ? _value.filePath
            : filePath // ignore: cast_nullable_to_non_nullable
                  as String,
        uploadDate: null == uploadDate
            ? _value.uploadDate
            : uploadDate // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UploadImpl implements _Upload {
  const _$UploadImpl({
    required this.uploadId,
    required this.userId,
    required this.fileName,
    required this.fileType,
    required this.filePath,
    required this.uploadDate,
    required this.createdAt,
  });

  factory _$UploadImpl.fromJson(Map<String, dynamic> json) =>
      _$$UploadImplFromJson(json);

  @override
  final String uploadId;
  @override
  final String userId;
  @override
  final String fileName;
  @override
  final String fileType;
  @override
  final String filePath;
  @override
  final String uploadDate;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'Upload(uploadId: $uploadId, userId: $userId, fileName: $fileName, fileType: $fileType, filePath: $filePath, uploadDate: $uploadDate, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UploadImpl &&
            (identical(other.uploadId, uploadId) ||
                other.uploadId == uploadId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileType, fileType) ||
                other.fileType == fileType) &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    uploadId,
    userId,
    fileName,
    fileType,
    filePath,
    uploadDate,
    createdAt,
  );

  /// Create a copy of Upload
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UploadImplCopyWith<_$UploadImpl> get copyWith =>
      __$$UploadImplCopyWithImpl<_$UploadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UploadImplToJson(this);
  }
}

abstract class _Upload implements Upload {
  const factory _Upload({
    required final String uploadId,
    required final String userId,
    required final String fileName,
    required final String fileType,
    required final String filePath,
    required final String uploadDate,
    required final DateTime createdAt,
  }) = _$UploadImpl;

  factory _Upload.fromJson(Map<String, dynamic> json) = _$UploadImpl.fromJson;

  @override
  String get uploadId;
  @override
  String get userId;
  @override
  String get fileName;
  @override
  String get fileType;
  @override
  String get filePath;
  @override
  String get uploadDate;
  @override
  DateTime get createdAt;

  /// Create a copy of Upload
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UploadImplCopyWith<_$UploadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
