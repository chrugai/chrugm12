import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/measurement_provider.dart';
import '../widgets/add_measurement_form.dart';
import '../widgets/measurement_card.dart';

class MeasurementsScreen extends ConsumerStatefulWidget {
  const MeasurementsScreen({super.key});

  @override
  ConsumerState<MeasurementsScreen> createState() => _MeasurementsScreenState();
}

class _MeasurementsScreenState extends ConsumerState<MeasurementsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(measurementProvider.notifier).loadMeasurements(),
    );
  }

  void _openAddForm() {
    final measurements = ref.read(measurementProvider).valueOrNull ?? [];
    final lastEntry = measurements.isNotEmpty ? measurements.first : null;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMeasurementForm(
        prefill: lastEntry,
        onSave: (data) {
          ref.read(measurementProvider.notifier).addMeasurement(
                measurementDate: DateTime.now().toIso8601String().split('T').first,
                neckCm: data['neck'],
                shouldersCm: data['shoulders'],
                chestCm: data['chest'],
                bicepsLCm: data['bicepsL'],
                bicepsRCm: data['bicepsR'],
                forearmLCm: data['forearmL'],
                forearmRCm: data['forearmR'],
                waistCm: data['waist'],
                hipsCm: data['hips'],
                thighLCm: data['thighL'],
                thighRCm: data['thighR'],
                calvesLCm: data['calvesL'],
                calvesRCm: data['calvesR'],
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(measurementProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Measurements', style: AppTypography.headingMedium),
        backgroundColor: AppColors.surface,
        elevation: 0,
        foregroundColor: AppColors.textPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddForm,
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error: $e', style: AppTypography.bodyMedium),
        ),
        data: (measurements) {
          if (measurements.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.straighten,
                        size: 64, color: AppColors.textSecondary),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'No measurements yet',
                      style: AppTypography.headingSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Tap + to add your first measurement',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            itemCount: measurements.length,
            itemBuilder: (context, index) {
              final m = measurements[index];
              return Dismissible(
                key: ValueKey(m.measurementId),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding:
                      const EdgeInsets.only(right: AppSpacing.screenPaddingH),
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  ref
                      .read(measurementProvider.notifier)
                      .deleteMeasurement(m.measurementId);
                },
                child: MeasurementCard(measurement: m),
              );
            },
          );
        },
      ),
    );
  }
}
