import 'package:flutter/material.dart';

import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/bubble_selector.dart';

class RestTimePickerModal extends StatelessWidget {
  const RestTimePickerModal({
    super.key,
    required this.currentSeconds,
    required this.onSelected,
  });

  final int currentSeconds;
  final ValueChanged<int> onSelected;

  static const _presets = [30, 45, 60, 90, 120, 180];

  static String _formatSeconds(int s) {
    if (s < 60) return '${s}s';
    final min = s ~/ 60;
    final sec = s % 60;
    return sec == 0 ? '${min}m' : '${min}m ${sec}s';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Rest Time', style: AppTypography.headingSmall),
          const SizedBox(height: AppSpacing.lg),
          BubbleSelector(
            scrollable: false,
            options: _presets.map(_formatSeconds).toList(),
            selectedOptions: [_formatSeconds(currentSeconds)],
            onSelected: (selected) {
              if (selected.isNotEmpty) {
                final idx = _presets
                    .indexWhere((p) => _formatSeconds(p) == selected.first);
                if (idx >= 0) {
                  onSelected(_presets[idx]);
                  Navigator.of(context).pop();
                }
              }
            },
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}
