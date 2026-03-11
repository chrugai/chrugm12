// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_totals.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyTotalsImpl _$$DailyTotalsImplFromJson(Map<String, dynamic> json) =>
    _$DailyTotalsImpl(
      totalCalories: (json['totalCalories'] as num?)?.toDouble() ?? 0,
      totalProteinG: (json['totalProteinG'] as num?)?.toDouble() ?? 0,
      totalCarbsG: (json['totalCarbsG'] as num?)?.toDouble() ?? 0,
      totalFatG: (json['totalFatG'] as num?)?.toDouble() ?? 0,
      totalFiberG: (json['totalFiberG'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$DailyTotalsImplToJson(_$DailyTotalsImpl instance) =>
    <String, dynamic>{
      'totalCalories': instance.totalCalories,
      'totalProteinG': instance.totalProteinG,
      'totalCarbsG': instance.totalCarbsG,
      'totalFatG': instance.totalFatG,
      'totalFiberG': instance.totalFiberG,
    };
