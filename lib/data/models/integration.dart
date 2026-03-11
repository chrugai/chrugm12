import 'package:freezed_annotation/freezed_annotation.dart';

part 'integration.freezed.dart';
part 'integration.g.dart';

@freezed
abstract class Integration with _$Integration {
  const factory Integration({
    required String integrationId,
    required String userId,
    required String integrationName,
    @Default(false) bool isConnected,
    DateTime? lastSyncedAt,
    String? syncError,
  }) = _Integration;

  factory Integration.fromJson(Map<String, dynamic> json) =>
      _$IntegrationFromJson(json);
}
