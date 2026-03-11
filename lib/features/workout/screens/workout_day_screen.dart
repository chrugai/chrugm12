import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../data/models/day.dart';
import '../../../data/models/exercise.dart';
import '../../../data/models/state/workout_state.dart';
import '../../../data/models/workout_set.dart';
import '../../program/providers/program_provider.dart';
import '../providers/workout_provider.dart';
import '../widgets/exercise_card.dart';
import '../widgets/rename_day_modal.dart';

class WorkoutDayScreen extends ConsumerStatefulWidget {
  const WorkoutDayScreen({super.key, required this.dayId});

  final String dayId;

  @override
  ConsumerState<WorkoutDayScreen> createState() => _WorkoutDayScreenState();
}

class _WorkoutDayScreenState extends ConsumerState<WorkoutDayScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(workoutProvider.notifier).selectDay(widget.dayId);
    });
  }

  Day? _findDay() {
    final programState = ref.watch(programProvider);
    final program = programState.currentProgram;
    if (program == null) return null;
    try {
      return program.days.firstWhere((d) => d.dayId == widget.dayId);
    } catch (_) {
      return null;
    }
  }

  WorkoutSet? _getLastSet(String exerciseId, List<WorkoutSet> allSets) {
    final exerciseSets = allSets.where((s) => s.exerciseId == exerciseId).toList();
    if (exerciseSets.isEmpty) return null;
    exerciseSets.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return exerciseSets.first;
  }

  Future<void> _handleReorder(Day day, int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) newIndex--;
    final exercises = List<Exercise>.from(day.exercises);
    final item = exercises.removeAt(oldIndex);
    exercises.insert(newIndex, item);
    final exerciseIds = exercises.map((e) => e.exerciseId).toList();
    HapticFeedback.lightImpact();
    await ref.read(programProvider.notifier).reorderExercises(widget.dayId, exerciseIds);
  }

  Future<void> _handleMoveUp(Day day, int index) async {
    if (index <= 0) return;
    await _handleReorder(day, index, index - 1);
  }

  Future<void> _handleMoveDown(Day day, int index) async {
    if (index >= day.exercises.length - 1) return;
    await _handleReorder(day, index, index + 2);
  }

  void _handleRenameDay(Day day) {
    RenameDayModal.show(
      context: context,
      currentName: day.dayName,
      onSave: (newName) async {
        await ref.read(programProvider.notifier).renameDay(widget.dayId, newName);
        if (mounted) {
          AppToast.showSuccess(context, 'Day renamed');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final day = _findDay();
    final workoutState = ref.watch(workoutProvider);

    if (day == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(day),
            Expanded(
              child: day.exercises.isEmpty
                  ? _buildEmptyState()
                  : _buildExerciseList(day, workoutState),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildHeader(Day day) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingH,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => context.pop(),
            child: const SizedBox(
              width: AppSpacing.minTapTarget,
              height: AppSpacing.minTapTarget,
              child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            child: Text(day.dayName, style: AppTypography.headingSmall, textAlign: TextAlign.center),
          ),
          GestureDetector(
            onTap: () => _handleRenameDay(day),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('rename day?', style: AppTypography.bodySmall.copyWith(color: AppColors.textSecondary)),
                const SizedBox(width: 2),
                const Icon(Icons.edit_outlined, size: 14, color: AppColors.textSecondary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseList(Day day, WorkoutState workoutState) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start your workout!', style: AppTypography.headingLarge),
                    const SizedBox(height: AppSpacing.xs),
                    Text('Click on an exercise to start instantly', style: AppTypography.bodySmall),
                  ],
                ),
              ),
              const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.search, size: 22, color: AppColors.textSecondary),
                  SizedBox(width: AppSpacing.md),
                  Icon(Icons.swap_vert, size: 22, color: AppColors.textSecondary),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Expanded(
          child: ReorderableListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            proxyDecorator: (child, index, animation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Material(
                  color: Colors.transparent,
                  elevation: 4,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  child: child,
                ),
                child: child,
              );
            },
            onReorder: (oldIndex, newIndex) => _handleReorder(day, oldIndex, newIndex),
            itemCount: day.exercises.length,
            itemBuilder: (context, index) {
              final exercise = day.exercises[index];
              final lastSet = _getLastSet(exercise.exerciseId, workoutState.loggedSets);
              return ExerciseCard(
                key: ValueKey(exercise.exerciseId),
                exercise: exercise,
                lastSet: lastSet,
                isFirst: index == 0,
                isLast: index == day.exercises.length - 1,
                onTap: () => context.go('/workout/day/${widget.dayId}/exercise/${exercise.exerciseId}'),
                onMoveUp: () => _handleMoveUp(day, index),
                onMoveDown: () => _handleMoveDown(day, index),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Add your first exercise', style: AppTypography.headingSmall),
          const SizedBox(height: AppSpacing.sm),
          Text('Tap the button below to get started', style: AppTypography.bodySmall),
        ],
      ),
    );
  }

  Widget _buildFab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
      child: SizedBox(
        width: double.infinity,
        height: AppSpacing.buttonHeight,
        child: FloatingActionButton.extended(
          onPressed: () => context.go('/workout/select-exercise'),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.cardRadius)),
          icon: const Icon(Icons.add, color: Colors.white),
          label: Text('Add Exercise', style: AppTypography.buttonText),
        ),
      ),
    );
  }
}
