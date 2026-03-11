import 'package:freezed_annotation/freezed_annotation.dart';

part 'measurement.freezed.dart';
part 'measurement.g.dart';

@freezed
abstract class Measurement with _$Measurement {
  const factory Measurement({
    required String measurementId,
    required String userId,
    required String measurementDate,
    double? neckCm,
    double? shouldersCm,
    double? chestCm,
    double? bicepsLCm,
    double? bicepsRCm,
    double? forearmLCm,
    double? forearmRCm,
    double? waistCm,
    double? hipsCm,
    double? thighLCm,
    double? thighRCm,
    double? calvesLCm,
    double? calvesRCm,
    required DateTime createdAt,
  }) = _Measurement;

  factory Measurement.fromJson(Map<String, dynamic> json) =>
      _$MeasurementFromJson(json);
}
