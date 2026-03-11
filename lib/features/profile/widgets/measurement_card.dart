import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../data/models/measurement.dart';

class MeasurementCard extends StatelessWidget {
  const MeasurementCard({super.key, required this.measurement});

  final Measurement measurement;

  @override
  Widget build(BuildContext context) {
    final entries = _buildEntries();

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              measurement.measurementDate,
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.accentBlue,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.lg,
              runSpacing: AppSpacing.sm,
              children: entries,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildEntries() {
    final fields = <String, double?>{
      'Neck': measurement.neckCm,
      'Shoulders': measurement.shouldersCm,
      'Chest': measurement.chestCm,
      'Biceps L': measurement.bicepsLCm,
      'Biceps R': measurement.bicepsRCm,
      'Forearm L': measurement.forearmLCm,
      'Forearm R': measurement.forearmRCm,
      'Waist': measurement.waistCm,
      'Hips': measurement.hipsCm,
      'Thigh L': measurement.thighLCm,
      'Thigh R': measurement.thighRCm,
      'Calves L': measurement.calvesLCm,
      'Calves R': measurement.calvesRCm,
    };

    return fields.entries
        .where((e) => e.value != null)
        .map((e) => _MeasurementChip(label: e.key, value: e.value!))
        .toList();
  }
}

class _MeasurementChip extends StatelessWidget {
  const _MeasurementChip({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    final formatted =
        value == value.roundToDouble() ? value.toInt().toString() : value.toStringAsFixed(1);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppTypography.bodySmall),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '\$formatted cm',
          style: AppTypography.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
