import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../data/models/workout_set.dart';
import '../providers/workout_provider.dart';
import '../widgets/add_set_modal.dart';
import '../widgets/rest_time_picker_modal.dart';
import '../widgets/rest_timer_pill.dart';
import '../widgets/set_history_item.dart';

class ExerciseDetailsScreen extends ConsumerStatefulWidget {
  const ExerciseDetailsScreen({
    super.key,
    required this.exerciseId,
    required this.dayId,
  });

  final String exerciseId;
  final String dayId;

  @override
  ConsumerState<ExerciseDetailsScreen> createState() =>
      _ExerciseDetailsScreenState();
}

class _ExerciseDetailsScreenState extends ConsumerState<ExerciseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(workoutProvider.notifier).selectDay(widget.dayId);
    });
  }

  List<WorkoutSet> get _exerciseSets {
    final state = ref.watch(workoutProvider);
    return state.loggedSets
        .where((s) => s.exerciseId == widget.exerciseId)
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  String? get _exerciseName {
    final state = ref.watch(workoutProvider);
    final match = state.currentDayExercises
        .where((e) => e.exerciseId == widget.exerciseId);
    return match.isNotEmpty ? match.first.name : null;
  }

  Map<String, List<WorkoutSet>> _groupByDate(List<WorkoutSet> sets) {
    final grouped = <String, List<WorkoutSet>>{};
    for (final s in sets) {
      final key = s.timestamp.toIso8601String().substring(0, 10);
      grouped.putIfAbsent(key, () => []).add(s);
    }
    return grouped;
  }

  void _showAddSetModal({int? prefillReps, double? prefillWeight}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.modalRadius),
        ),
      ),
      builder: (_) => AddSetModal(
        prefillReps: prefillReps,
        prefillWeight: prefillWeight,
        onRecord: ({
          required int reps,
          required double weightKg,
          int? repsInReserve,
          String? tempoVariation,
          String? notes,
        }) {
          ref.read(workoutProvider.notifier).recordSet(
                exerciseId: widget.exerciseId,
                reps: reps,
                weightKg: weightKg,
                repsInReserve: repsInReserve,
                tempoVariation: tempoVariation,
                notes: notes,
              );
          ref.read(workoutProvider.notifier).toggleRestTimer();
          AppToast.showSuccess(context, 'Set recorded');
        },
      ),
    );
  }

  void _showRestTimePicker() {
    final currentRest = ref.read(workoutProvider).selectedRestTimeSeconds;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.modalRadius),
        ),
      ),
      builder: (_) => RestTimePickerModal(
        currentSeconds: currentRest,
        onSelected: (seconds) {
          ref.read(workoutProvider.notifier).setRestTime(seconds);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final workoutState = ref.watch(workoutProvider);
    final sets = _exerciseSets;
    final name = _exerciseName ?? 'Exercise';
    final grouped = _groupByDate(sets);
    final dateKeys = grouped.keys.toList()..sort();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                title: Text(name),
                expandedHeight: 120,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(color: AppColors.primary),
                ),
              ),

              // Action chips
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
                  child: Wrap(
                    spacing: AppSpacing.sm,
                    children: [
                      ActionChip(
                        avatar: const Icon(Icons.timer, size: 16),
                        label: const Text('Change rest time'),
                        onPressed: _showRestTimePicker,
                      ),
                      ActionChip(
                        avatar: const Icon(Icons.play_circle_outline, size: 16),
                        label: const Text('Watch tutorial'),
                        onPressed: () {
                          AppToast.showInfo(context, 'Tutorials coming soon');
                        },
                      ),
                    ],
                  ),
                ),
              ),

              // Quick tip
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPaddingH,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.accentBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.lightbulb_outline,
                            size: 18, color: AppColors.accentBlue),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Text(
                            'Swipe left to delete, right to duplicate a set.',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.accentBlue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SliverToBoxAdapter(
                child: SizedBox(height: AppSpacing.lg),
              ),

              // Set history grouped by date
              if (sets.isEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.xxxl),
                    child: Center(
                      child: Text(
                        'No sets logged yet.\nTap + to add your first set.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
              else
                ...dateKeys.expand((dateKey) {
                  final daySets = grouped[dateKey]!;
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.screenPaddingH,
                          vertical: AppSpacing.sm,
                        ),
                        child: Text(
                          dateKey,
                          style: AppTypography.labelLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final s = daySets[index];
                          return SetHistoryItem(
                            workoutSet: s,
                            setNumber: index + 1,
                            onDelete: () {
                              ref
                                  .read(workoutProvider.notifier)
                                  .deleteSet(s.setId);
                              AppToast.showInfo(context, 'Set deleted');
                            },
                            onDuplicate: () {
                              _showAddSetModal(
                                prefillReps: s.reps,
                                prefillWeight: s.weightKg,
                              );
                            },
                          );
                        },
                        childCount: daySets.length,
                      ),
                    ),
                  ];
                }),

              // Bottom padding for FAB
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),

          // Rest timer pill
          if (workoutState.restTimerActive)
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: RestTimerPill(
                  totalSeconds: workoutState.selectedRestTimeSeconds,
                  onComplete: () {
                    ref.read(workoutProvider.notifier).stopRestTimer();
                    AppToast.showSuccess(context, 'Rest complete!');
                  },
                  onSkip: () {
                    ref.read(workoutProvider.notifier).stopRestTimer();
                  },
                  onAdjust: _showRestTimePicker,
                  onClose: () {
                    ref.read(workoutProvider.notifier).stopRestTimer();
                  },
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSetModal(),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Set'),
      ),
    );
  }
}
