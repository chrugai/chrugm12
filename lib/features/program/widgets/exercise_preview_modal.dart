import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_badge.dart';
import '../../../data/models/exercise.dart';

class ExercisePreviewModal extends StatelessWidget {
  const ExercisePreviewModal({super.key, required this.exercise});

  final Exercise exercise;

  static Future<void> show(BuildContext context, Exercise exercise) {
    return showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
      builder: (_) => ExercisePreviewModal(exercise: exercise),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.modalRadius))),
      child: DraggableScrollableSheet(
        initialChildSize: 0.6, minChildSize: 0.3, maxChildSize: 0.85, expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController, padding: const EdgeInsets.all(AppSpacing.xxl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.inputBorder, borderRadius: BorderRadius.circular(2)))),
                const SizedBox(height: AppSpacing.xxl),
                if (exercise.imageUrl != null && exercise.imageUrl!.isNotEmpty) ...[
                  ClipRRect(borderRadius: BorderRadius.circular(AppSpacing.cardRadius), child: Container(height: 200, width: double.infinity, color: AppColors.background, child: const Icon(Icons.fitness_center, size: 64, color: AppColors.textHint))),
                  const SizedBox(height: AppSpacing.xl),
                ],
                Text(exercise.name, style: AppTypography.headingMedium),
                const SizedBox(height: AppSpacing.md),
                Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: [
                  if (exercise.isCompound) const AppBadge(label: 'Compound') else const AppBadge(label: 'Isolation', color: AppColors.secondary),
                  if (exercise.equipment != null && exercise.equipment!.isNotEmpty) AppBadge(label: exercise.equipment!, color: AppColors.primary),
                ]),
                const SizedBox(height: AppSpacing.xl),
                if (exercise.description != null && exercise.description!.isNotEmpty) ...[
                  Text('Overview', style: AppTypography.headingSmall), const SizedBox(height: AppSpacing.sm),
                  Text(exercise.description!, style: AppTypography.bodyMedium.copyWith(color: AppColors.textSecondary)),
                  const SizedBox(height: AppSpacing.xl),
                ],
                if (exercise.muscleGroups.isNotEmpty) ...[
                  Text('Muscle Groups', style: AppTypography.headingSmall), const SizedBox(height: AppSpacing.sm),
                  Wrap(spacing: AppSpacing.sm, runSpacing: AppSpacing.sm, children: exercise.muscleGroups.map((mg) => AppBadge(label: mg, color: AppColors.background, textColor: AppColors.textPrimary)).toList()),
                ],
                const SizedBox(height: AppSpacing.xxxl),
              ],
            ),
          );
        },
      ),
    );
  }
}
