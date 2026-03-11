import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/exercise.dart';

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile({
    super.key,
    required this.exercise,
    required this.isSelected,
    required this.onToggle,
    required this.onMore,
  });

  final Exercise exercise;
  final bool isSelected;
  final VoidCallback onToggle;
  final VoidCallback onMore;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
        child: Row(
          children: [
            Container(
              width: 24, height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: isSelected ? AppColors.primary : AppColors.inputBorder, width: 2),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected ? const Icon(Icons.check, size: 16, color: Colors.white) : null,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(exercise.name, style: AppTypography.bodyLarge, overflow: TextOverflow.ellipsis)),
            GestureDetector(
              onTap: onMore,
              behavior: HitTestBehavior.opaque,
              child: const SizedBox(width: AppSpacing.minTapTarget, height: AppSpacing.minTapTarget, child: Icon(Icons.more_horiz, color: AppColors.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}
