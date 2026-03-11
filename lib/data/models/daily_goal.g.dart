// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyGoalImpl _$$DailyGoalImplFromJson(Map<String, dynamic> json) =>
    _$DailyGoalImpl(
      dailyCalories: (json['dailyCalories'] as num).toDouble(),
      dailyProteinG: (json['dailyProteinG'] as num).toDouble(),
      dailyCarbsG: (json['dailyCarbsG'] as num).toDouble(),
      dailyFatG: (json['dailyFatG'] as num).toDouble(),
      dailyFiberG: (json['dailyFiberG'] as num).toDouble(),
    );

Map<String, dynamic> _$$DailyGoalImplToJson(_$DailyGoalImpl instance) =>
    <String, dynamic>{
      'dailyCalories': instance.dailyCalories,
      'dailyProteinG': instance.dailyProteinG,
      'dailyCarbsG': instance.dailyCarbsG,
      'dailyFatG': instance.dailyFatG,
      'dailyFiberG': instance.dailyFiberG,
    };
