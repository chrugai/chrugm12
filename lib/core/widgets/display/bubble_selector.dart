import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class BubbleSelector extends StatelessWidget {
  const BubbleSelector({
    super.key,
    required this.options,
    required this.selectedOptions,
    required this.onSelected,
    this.multiSelect = false,
    this.scrollable = true,
  });

  final List<String> options;
  final List<String> selectedOptions;
  final ValueChanged<List<String>> onSelected;
  final bool multiSelect;
  final bool scrollable;

  void _onTap(String option) {
    HapticFeedback.selectionClick();
    if (multiSelect) {
      final updated = List<String>.from(selectedOptions);
      if (updated.contains(option)) {
        updated.remove(option);
      } else {
        updated.add(option);
      }
      onSelected(updated);
    } else {
      onSelected([option]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bubbles = options.map((option) {
      final isSelected = selectedOptions.contains(option);
      return GestureDetector(
        onTap: () => _onTap(option),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            option,
            style: AppTypography.bodyMedium.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
        ),
      );
    }).toList();

    if (scrollable) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: bubbles
              .expand((b) => [b, const SizedBox(width: AppSpacing.sm)])
              .toList()
            ..removeLast(),
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: bubbles,
    );
  }
}
