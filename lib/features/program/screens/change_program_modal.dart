import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../router/route_constants.dart';
import '../providers/program_provider.dart';
import '../widgets/program_card.dart';
import 'create_program_modal.dart';

class ChangeProgramModal extends ConsumerStatefulWidget {
  const ChangeProgramModal({super.key});

  @override
  ConsumerState<ChangeProgramModal> createState() =>
      _ChangeProgramModalState();
}

class _ChangeProgramModalState extends ConsumerState<ChangeProgramModal> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(programProvider.notifier).loadPrograms(),
    );
  }

  Future<void> _onCreateNewProgram() async {
    final programId = await showCreateProgramModal(context);
    if (programId != null && mounted) {
      context.go('\${Routes.workout}/\${Routes.selectExercise}');
    }
  }

  Future<void> _onSelectProgram(String programId) async {
    await ref.read(programProvider.notifier).selectProgram(programId);
    if (mounted) {
      context.go(Routes.workout);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(programProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPaddingH,
                vertical: AppSpacing.md,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go(Routes.workout),
                    child: const Icon(Icons.arrow_back_ios, size: 20),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    'Change Program',
                    style: AppTypography.headingMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPaddingH,
                ),
                children: [
                  AppCard(
                    onTap: _onCreateNewProgram,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.accentBlue.withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.cardRadius),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: AppColors.accentBlue,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Create New Program',
                                style: AppTypography.bodyLarge.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'Build your custom program from scratch, one day at a time!',
                                style: AppTypography.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Text(
                    'Your Programs',
                    style: AppTypography.headingSmall,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (state.isLoading)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.xxl),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  else if (state.programs.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: Center(
                        child: Text(
                          'No programs yet. Create your first one!',
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    ...state.programs.map(
                      (program) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: ProgramCard(
                          program: program,
                          isActive:
                              program.programId == state.selectedProgramId,
                          onTap: () =>
                              _onSelectProgram(program.programId),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
