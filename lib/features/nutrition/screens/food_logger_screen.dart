import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/input/app_date_picker.dart';
import '../providers/nutrition_provider.dart';
import '../widgets/calorie_progress_ring.dart';
import '../widgets/macro_summary_bar.dart';
import '../widgets/meal_card.dart';

class FoodLoggerScreen extends ConsumerStatefulWidget {
  const FoodLoggerScreen({super.key});

  @override
  ConsumerState<FoodLoggerScreen> createState() => _FoodLoggerScreenState();
}

class _FoodLoggerScreenState extends ConsumerState<FoodLoggerScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final state = ref.read(nutritionProvider);
      ref.read(nutritionProvider.notifier).loadMealsForDate(state.selectedDate);
    });
  }

  bool _isToday(String isoDate) {
    final today = DateTime.now().toIso8601String().substring(0, 10);
    return isoDate == today;
  }

  String _formatDateLabel(String isoDate) {
    if (_isToday(isoDate)) return 'Today';
    final parts = isoDate.split('-');
    final months = [
      '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[int.parse(parts[1])]} ${int.parse(parts[2])}';
  }

  void _openDatePicker() {
    final state = ref.read(nutritionProvider);
    final parts = state.selectedDate.split('-');
    final current = DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
    showAppDatePicker(
      context,
      initialDate: current,
      onDateSelected: (date) {
        final iso = date.toIso8601String().substring(0, 10);
        ref.read(nutritionProvider.notifier).selectDate(iso);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(nutritionProvider);
    final goal = state.dailyGoal;
    final totals = state.dailyTotals;
    final meals = state.meals.toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.person_outline, color: AppColors.textPrimary),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: GestureDetector(
          onTap: _openDatePicker,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatDateLabel(state.selectedDate),
                style: AppTypography.headingSmall,
              ),
              const SizedBox(width: AppSpacing.xs),
              const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // Calorie progress ring
                  CalorieProgressRing(
                    goalCalories: goal.dailyCalories,
                    eatenCalories: totals.totalCalories,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  // Macro bars
                  MacroSummaryBar(
                    proteinConsumed: totals.totalProteinG,
                    proteinTarget: goal.dailyProteinG,
                    carbsConsumed: totals.totalCarbsG,
                    carbsTarget: goal.dailyCarbsG,
                    fatConsumed: totals.totalFatG,
                    fatTarget: goal.dailyFatG,
                    fiberConsumed: totals.totalFiberG,
                    fiberTarget: goal.dailyFiberG,
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  // Meals
                  Text('Meals', style: AppTypography.headingSmall),
                  const SizedBox(height: AppSpacing.md),
                  if (meals.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xxxl,
                      ),
                      child: Center(
                        child: Text(
                          'No meals logged yet.\nStart adding food!',
                          textAlign: TextAlign.center,
                          style: AppTypography.bodyMedium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    )
                  else
                    ...meals.map((meal) => Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppSpacing.md),
                          child: MealCard(meal: meal),
                        )),
                  const SizedBox(height: 80),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to add food - route may not exist yet
        },
        backgroundColor: AppColors.accentBlue,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Food'),
      ),
    );
  }
}
