import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/workout_set.dart';

class SetHistoryItem extends StatelessWidget {
  const SetHistoryItem({
    super.key,
    required this.workoutSet,
    required this.setNumber,
    required this.onDelete,
    required this.onDuplicate,
  });

  final WorkoutSet workoutSet;
  final int setNumber;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;

  String _formatTime(DateTime dt) {
    final h = dt.hour;
    final m = dt.minute.toString().padLeft(2, '0');
    final period = h >= 12 ? 'PM' : 'AM';
    final hour12 = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$hour12:$m $period';
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(workoutSet.setId),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: AppSpacing.lg),
        color: AppColors.accentBlue,
        child: const Icon(Icons.copy, color: Colors.white),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        color: AppColors.danger,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        HapticFeedback.mediumImpact();
        if (direction == DismissDirection.endToStart) {
          return await showDialog<bool>(
            context: context,
            builder: (ctx) => AlertDialog(
              title: const Text('Delete Set'),
              content: const Text('Remove this set from history?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(true),
                  child: Text(
                    'Delete',
                    style: TextStyle(color: AppColors.danger),
                  ),
                ),
              ],
            ),
          );
        }
        onDuplicate();
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          onDelete();
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$setNumber',
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${workoutSet.reps} reps × ${workoutSet.weightKg} kg',
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (workoutSet.repsInReserve != null ||
                      workoutSet.tempoVariation != null)
                    Text(
                      [
                        if (workoutSet.repsInReserve != null)
                          'RIR ${workoutSet.repsInReserve}',
                        if (workoutSet.tempoVariation != null)
                          workoutSet.tempoVariation,
                      ].join(' · '),
                      style: AppTypography.bodySmall,
                    ),
                ],
              ),
            ),
            Text(
              _formatTime(workoutSet.timestamp),
              style: AppTypography.caption,
            ),
          ],
        ),
      ),
    );
  }
}
