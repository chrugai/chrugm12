import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_progress_ring.dart';

class CalorieProgressRing extends StatelessWidget {
  const CalorieProgressRing({
    super.key,
    required this.goalCalories,
    required this.eatenCalories,
  });

  final double goalCalories;
  final double eatenCalories;

  double get _remaining => goalCalories - eatenCalories;
  double get _progress => goalCalories > 0 ? eatenCalories / goalCalories : 0;
  bool get _isOver => eatenCalories > goalCalories;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Goal label
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${goalCalories.toInt()}',
              style: AppTypography.headingSmall,
            ),
            Text('Goal', style: AppTypography.bodySmall),
          ],
        ),
        const SizedBox(width: AppSpacing.xl),
        // Ring
        AppProgressRing(
          progress: _progress,
          color: _isOver ? AppColors.danger : AppColors.accentBlue,
          centerText: _isOver
              ? '${(-_remaining).toInt()}'
              : '${_remaining.toInt()}',
          centerSubtext: _isOver ? 'Over' : 'Remaining',
        ),
        const SizedBox(width: AppSpacing.xl),
        // Eaten label
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${eatenCalories.toInt()}',
              style: AppTypography.headingSmall,
            ),
            Text('Eaten', style: AppTypography.bodySmall),
          ],
        ),
      ],
    );
  }
}
