import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_totals.freezed.dart';
part 'daily_totals.g.dart';

@freezed
abstract class DailyTotals with _$DailyTotals {
  const factory DailyTotals({
    @Default(0) double totalCalories,
    @Default(0) double totalProteinG,
    @Default(0) double totalCarbsG,
    @Default(0) double totalFatG,
    @Default(0) double totalFiberG,
  }) = _DailyTotals;

  factory DailyTotals.fromJson(Map<String, dynamic> json) =>
      _$DailyTotalsFromJson(json);
}
