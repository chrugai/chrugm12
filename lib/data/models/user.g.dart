// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
  userId: json['userId'] as String,
  email: json['email'] as String,
  name: json['name'] as String?,
  heightCm: (json['heightCm'] as num?)?.toDouble(),
  weightKg: (json['weightKg'] as num?)?.toDouble(),
  birthDate: json['birthDate'] as String?,
  gender: json['gender'] as String?,
  profilePicturePath: json['profilePicturePath'] as String?,
  isAuthenticated: json['isAuthenticated'] as bool,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'name': instance.name,
      'heightCm': instance.heightCm,
      'weightKg': instance.weightKg,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'profilePicturePath': instance.profilePicturePath,
      'isAuthenticated': instance.isAuthenticated,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
