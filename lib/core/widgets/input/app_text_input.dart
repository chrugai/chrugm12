import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_input_styles.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    super.key,
    this.label,
    this.hint,
    this.errorText,
    this.successText,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.autofocus = false,
  });

  final String? label;
  final String? hint;
  final String? errorText;
  final String? successText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final bool autofocus;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  InputDecoration _getDecoration() {
    if (widget.errorText != null) {
      return AppInputStyles.errorDecoration.copyWith(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        errorText: widget.errorText,
        errorStyle: AppTypography.bodySmall.copyWith(color: AppColors.danger),
      );
    }
    if (widget.successText != null) {
      return AppInputStyles.successDecoration.copyWith(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      );
    }
    return AppInputStyles.defaultDecoration.copyWith(
      hintText: widget.hint,
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.suffixIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: AppTypography.labelLarge),
          const SizedBox(height: AppSpacing.xs),
        ],
        SizedBox(
          height: widget.maxLines > 1 ? null : AppSpacing.inputHeight,
          child: TextField(
            controller: widget.controller,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            maxLines: widget.maxLines,
            enabled: widget.enabled,
            autofocus: widget.autofocus,
            style: AppTypography.bodyLarge,
            decoration: _getDecoration(),
          ),
        ),
        if (widget.successText != null) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            widget.successText!,
            style: AppTypography.bodySmall.copyWith(color: AppColors.success),
          ),
        ],
      ],
    );
  }
}
