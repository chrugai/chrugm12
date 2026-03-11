import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    required String userId,
    required String email,
    String? name,
    double? heightCm,
    double? weightKg,
    String? birthDate,
    String? gender,
    String? profilePicturePath,
    required bool isAuthenticated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
