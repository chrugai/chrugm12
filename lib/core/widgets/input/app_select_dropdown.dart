import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_input_styles.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class AppSelectDropdown extends StatelessWidget {
  const AppSelectDropdown({
    super.key,
    this.label,
    this.selectedValue,
    required this.hint,
    required this.options,
    required this.onSelected,
  });

  final String? label;
  final String? selectedValue;
  final String hint;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!, style: AppTypography.labelLarge),
          const SizedBox(height: AppSpacing.xs),
        ],
        GestureDetector(
          onTap: () => _showOptions(context),
          child: InputDecorator(
            decoration: AppInputStyles.defaultDecoration.copyWith(
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textSecondary,
              ),
            ),
            child: Text(
              selectedValue ?? hint,
              style: selectedValue != null
                  ? AppTypography.bodyLarge
                  : AppTypography.bodyLarge.copyWith(color: AppColors.textHint),
            ),
          ),
        ),
      ],
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.modalRadius),
        ),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.inputBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ...options.map(
              (option) => ListTile(
                title: Text(option, style: AppTypography.bodyLarge),
                trailing: option == selectedValue
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  onSelected(option);
                  Navigator.pop(context);
                },
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
