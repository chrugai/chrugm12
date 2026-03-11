import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_avatar.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../data/models/program.dart';
import '../../../router/route_constants.dart';
import '../../profile/providers/notification_provider.dart';
import '../../program/providers/program_provider.dart';
import '../widgets/day_card.dart';

class WorkoutDaysScreen extends ConsumerStatefulWidget {
  const WorkoutDaysScreen({super.key});

  @override
  ConsumerState<WorkoutDaysScreen> createState() => _WorkoutDaysScreenState();
}

class _WorkoutDaysScreenState extends ConsumerState<WorkoutDaysScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(programProvider.notifier).loadPrograms();
    });
  }

  @override
  Widget build(BuildContext context) {
    final programState = ref.watch(programProvider);
    final currentProgram = programState.currentProgram;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, currentProgram),
            Expanded(
              child: currentProgram == null
                  ? _buildEmptyState(context)
                  : _buildDaysList(context, currentProgram),
            ),
          ],
        ),
      ),
      floatingActionButton: currentProgram != null
          ? _buildFab(currentProgram)
          : null,
    );
  }

  Widget _buildHeader(BuildContext context, Program? program) {
    final unreadCount = ref.watch(
      notificationProvider.select((notifications) =>
          notifications.where((n) => !n.isRead).length),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenPaddingH,
        AppSpacing.md,
        AppSpacing.screenPaddingH,
        AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatar(
                initials: 'U',
                size: 36,
                onTap: () => Scaffold.of(context).openDrawer(),
              ),
              const Spacer(),
              if (program != null)
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  color: AppColors.textPrimary,
                  onPressed: () => _onShare(program),
                ),
              Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    color: AppColors.textPrimary,
                    onPressed: () => context.push(Routes.notifications),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.danger,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (program != null)
            Row(
              children: [
                Expanded(
                  child: Text(
                    program.name,
                    style: AppTypography.headingLarge,
                  ),
                ),
                GestureDetector(
                  onTap: () => context.push(Routes.programChange),
                  child: Text(
                    'Change Program >',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildDaysList(BuildContext context, Program program) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingH,
        vertical: AppSpacing.sm,
      ),
      itemCount: program.days.length,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final day = program.days[index];
        return DayCard(
          day: day,
          onTap: () => context.go(
            '${Routes.workout}/day/${day.dayId}',
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPaddingH,
        ),
        child: AppCard(
          onTap: () => context.push(Routes.programCreate),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add_circle_outline,
                size: 48,
                color: AppColors.secondary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Create New Program',
                style: AppTypography.headingSmall,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Get started by creating your first workout program',
                style: AppTypography.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFab(Program program) {
    return FloatingActionButton.extended(
      backgroundColor: AppColors.primary,
      onPressed: () {
        final nextDay = program.days.length + 1;
        ref.read(programProvider.notifier).addDay(
              program.programId,
              'Day $nextDay',
            );
      },
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        'Add Workout Day',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  void _onShare(Program program) {
    Share.share(
      'Check out my program: ${program.name}\nchrug.app/program/${program.programId}',
    );
  }
}
