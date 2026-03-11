import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_progress_bar.dart';

class MacroSummaryBar extends StatelessWidget {
  const MacroSummaryBar({
    super.key,
    required this.proteinConsumed,
    required this.proteinTarget,
    required this.carbsConsumed,
    required this.carbsTarget,
    required this.fatConsumed,
    required this.fatTarget,
    required this.fiberConsumed,
    required this.fiberTarget,
  });

  final double proteinConsumed;
  final double proteinTarget;
  final double carbsConsumed;
  final double carbsTarget;
  final double fatConsumed;
  final double fatTarget;
  final double fiberConsumed;
  final double fiberTarget;

  static const _proteinColor = Color(0xFF579BFC);
  static const _carbsColor = Color(0xFFFDAB3D);
  static const _fatColor = Color(0xFF00C875);
  static const _fiberColor = Color(0xFFE63946);

  double _safeProgress(double consumed, double target) =>
      target > 0 ? consumed / target : 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _MacroColumn(
          label: 'Protein',
          consumed: proteinConsumed,
          target: proteinTarget,
          progress: _safeProgress(proteinConsumed, proteinTarget),
          color: _proteinColor,
        ),
        const SizedBox(width: AppSpacing.md),
        _MacroColumn(
          label: 'Carbs',
          consumed: carbsConsumed,
          target: carbsTarget,
          progress: _safeProgress(carbsConsumed, carbsTarget),
          color: _carbsColor,
        ),
        const SizedBox(width: AppSpacing.md),
        _MacroColumn(
          label: 'Fat',
          consumed: fatConsumed,
          target: fatTarget,
          progress: _safeProgress(fatConsumed, fatTarget),
          color: _fatColor,
        ),
        const SizedBox(width: AppSpacing.md),
        _MacroColumn(
          label: 'Fiber',
          consumed: fiberConsumed,
          target: fiberTarget,
          progress: _safeProgress(fiberConsumed, fiberTarget),
          color: _fiberColor,
        ),
      ],
    );
  }
}

class _MacroColumn extends StatelessWidget {
  const _MacroColumn({
    required this.label,
    required this.consumed,
    required this.target,
    required this.progress,
    required this.color,
  });

  final String label;
  final double consumed;
  final double target;
  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label, style: AppTypography.labelSmall),
          const SizedBox(height: AppSpacing.xs),
          AppProgressBar(progress: progress, color: color),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${consumed.toInt()}/${target.toInt()}g',
            style: AppTypography.caption,
          ),
        ],
      ),
    );
  }
}
