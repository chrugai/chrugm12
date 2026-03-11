import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_accordion.dart';
import '../../../core/widgets/display/app_badge.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../router/route_constants.dart';
import '../providers/program_provider.dart';

class ProgramDetailsPreview extends ConsumerStatefulWidget {
  const ProgramDetailsPreview({super.key, required this.programId});

  final String programId;

  @override
  ConsumerState<ProgramDetailsPreview> createState() =>
      _ProgramDetailsPreviewState();
}

class _ProgramDetailsPreviewState
    extends ConsumerState<ProgramDetailsPreview> {
  @override
  void initState() {
    super.initState();
    final state = ref.read(programProvider);
    if (state.programs.isEmpty) {
      Future.microtask(() {
        ref.read(programProvider.notifier).loadPrograms();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(programProvider);
    final program = state.programs.where(
      (p) => p.programId == widget.programId,
    ).firstOrNull;

    if (state.isLoading || program == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        color: AppColors.primary.withValues(alpha: 0.15),
                        child: const Icon(
                          Icons.fitness_center,
                          size: 64,
                          color: AppColors.primary,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + AppSpacing.md,
                        left: AppSpacing.screenPaddingH,
                        child: GestureDetector(
                          onTap: () => context.pop(),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.arrow_back,
                              color: AppColors.textPrimary,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).padding.top + AppSpacing.md,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'Program',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(program.name, style: AppTypography.headingLarge),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          program.description ?? '',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Row(
                          children: [
                            AppBadge(label: '${program.days.length} Days'),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xxl),
                        ...List.generate(program.days.length, (index) {
                          final day = program.days[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              bottom: index < program.days.length - 1
                                  ? AppSpacing.sm
                                  : 0,
                            ),
                            child: AppAccordion(
                              title: day.dayName,
                              initiallyExpanded: index == 0,
                              content: Column(
                                children: day.exercises.map((exercise) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: AppSpacing.xs,
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.fitness_center,
                                          size: 18,
                                          color: AppColors.textSecondary,
                                        ),
                                        const SizedBox(width: AppSpacing.md),
                                        Expanded(
                                          child: Text(
                                            exercise.name,
                                            style: AppTypography.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.screenPaddingH,
              right: AppSpacing.screenPaddingH,
              bottom: MediaQuery.of(context).padding.bottom + AppSpacing.lg,
              top: AppSpacing.md,
            ),
            child: AppButton(
              label: 'Start Program!',
              onPressed: () async {
                await ref
                    .read(programProvider.notifier)
                    .selectProgram(widget.programId);
                if (context.mounted) {
                  context.go(Routes.workout);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
