import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_animations.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

enum AppButtonVariant { primary, secondary, danger }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isDisabled = false,
    this.icon,
    this.fullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isDisabled;
  final IconData? icon;
  final bool fullWidth;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  bool _pressed = false;

  bool get _isInteractive =>
      !widget.isDisabled && !widget.isLoading && widget.onPressed != null;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      lowerBound: 0.8,
      upperBound: 1.0,
    );
    if (widget.isLoading) _pulseController.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(AppButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _pulseController.repeat(reverse: true);
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _pulseController
        ..stop()
        ..value = 1.0;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  Color get _backgroundColor {
    if (widget.isDisabled) return AppColors.buttonDisabledBg;
    switch (widget.variant) {
      case AppButtonVariant.primary:
        return AppColors.primary;
      case AppButtonVariant.secondary:
        return AppColors.surface;
      case AppButtonVariant.danger:
        return AppColors.danger;
    }
  }

  Color get _textColor {
    if (widget.isDisabled) return AppColors.buttonDisabledText;
    switch (widget.variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.danger:
        return Colors.white;
      case AppButtonVariant.secondary:
        return AppColors.primary;
    }
  }

  BoxBorder? get _border {
    if (widget.variant == AppButtonVariant.secondary && !widget.isDisabled) {
      return Border.all(color: AppColors.primary);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _isInteractive ? (_) => setState(() => _pressed = true) : null,
      onTapUp: _isInteractive
          ? (_) {
              setState(() => _pressed = false);
              HapticFeedback.lightImpact();
              widget.onPressed!();
            }
          : null,
      onTapCancel:
          _isInteractive ? () => setState(() => _pressed = false) : null,
      child: AnimatedBuilder(
        animation: _pulseController,
        builder: (context, child) => AnimatedScale(
          scale: _pressed ? AppAnimations.buttonScaleFactor : 1.0,
          duration: AppAnimations.buttonPress,
          child: Opacity(
            opacity: widget.isDisabled
                ? 0.5
                : widget.isLoading
                    ? _pulseController.value
                    : 1.0,
            child: Container(
              height: AppSpacing.buttonHeight,
              width: widget.fullWidth ? double.infinity : null,
              padding: widget.fullWidth
                  ? null
                  : const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              decoration: BoxDecoration(
                color: _backgroundColor,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: _border,
              ),
              child: Center(child: _buildContent()),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final textStyle = AppTypography.buttonText.copyWith(color: _textColor);

    if (widget.isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation(_textColor),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(widget.label, style: textStyle),
        ],
      );
    }

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, color: _textColor, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Text(widget.label, style: textStyle),
        ],
      );
    }

    return Text(widget.label, style: textStyle);
  }
}
