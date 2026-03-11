import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/input/app_text_input.dart';

class RenameDayModal extends StatefulWidget {
  const RenameDayModal({
    super.key,
    required this.currentName,
    required this.onSave,
  });

  final String currentName;
  final ValueChanged<String> onSave;

  static Future<void> show({
    required BuildContext context,
    required String currentName,
    required ValueChanged<String> onSave,
  }) {
    return showDialog(
      context: context,
      barrierColor: AppColors.overlayDim,
      builder: (_) => RenameDayModal(currentName: currentName, onSave: onSave),
    );
  }

  @override
  State<RenameDayModal> createState() => _RenameDayModalState();
}

class _RenameDayModalState extends State<RenameDayModal> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      widget.onSave(name);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacing.modalRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rename Day', style: AppTypography.headingSmall),
            const SizedBox(height: AppSpacing.lg),
            AppTextInput(controller: _controller, hint: 'Day name', autofocus: true),
            const SizedBox(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Cancel',
                    variant: AppButtonVariant.secondary,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: AppButton(label: 'Save', onPressed: _save)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
