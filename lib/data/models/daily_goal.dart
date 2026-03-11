import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_goal.freezed.dart';
part 'daily_goal.g.dart';

@freezed
abstract class DailyGoal with _$DailyGoal {
  const factory DailyGoal({
    required double dailyCalories,
    required double dailyProteinG,
    required double dailyCarbsG,
    required double dailyFatG,
    required double dailyFiberG,
  }) = _DailyGoal;

  factory DailyGoal.fromJson(Map<String, dynamic> json) =>
      _$DailyGoalFromJson(json);
}

const defaultDailyGoal = DailyGoal(
  dailyCalories: 2000,
  dailyProteinG: 150,
  dailyCarbsG: 200,
  dailyFatG: 65,
  dailyFiberG: 30,
);
