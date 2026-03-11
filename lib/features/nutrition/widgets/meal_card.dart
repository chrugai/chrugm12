import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../data/models/meal.dart';

class MealCard extends StatelessWidget {
  const MealCard({
    super.key,
    required this.meal,
    this.onEdit,
  });

  final Meal meal;
  final VoidCallback? onEdit;

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = h >= 12 ? 'PM' : 'AM';
    final hour12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$hour12:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meal.mealName ?? 'Meal',
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      _formatTime(meal.createdAt),
                      style: AppTypography.caption,
                    ),
                  ],
                ),
              ),
              if (onEdit != null)
                GestureDetector(
                  onTap: onEdit,
                  child: Text(
                    'Edit',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.accentBlue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const Divider(height: AppSpacing.lg),
          // Food items
          ...meal.foods.map((mf) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        mf.food.name,
                        style: AppTypography.bodyMedium,
                      ),
                    ),
                    Text(
                      '${mf.calories.toInt()} cal',
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              )),
          const SizedBox(height: AppSpacing.sm),
          // Summary
          Text(
            '${meal.totalCalories.toInt()} cal · '
            'P: ${meal.totalProteinG.toInt()}g · '
            'C: ${meal.totalCarbsG.toInt()}g · '
            'F: ${meal.totalFatG.toInt()}g',
            style: AppTypography.caption.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
