import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../data/models/day.dart';

class DayCard extends StatelessWidget {
  const DayCard({
    super.key,
    required this.day,
    this.onTap,
  });

  final Day day;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.fitness_center,
            color: AppColors.primary,
            size: 22,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              day.dayName,
              style: AppTypography.bodyLarge.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (day.exercises.isNotEmpty)
            Text(
              '${day.exercises.length} exercise${day.exercises.length == 1 ? '' : 's'}',
              style: AppTypography.bodySmall,
            ),
        ],
      ),
    );
  }
}
