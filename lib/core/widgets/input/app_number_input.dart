import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_spacing.dart';
import '../../theme/app_typography.dart';

class AppNumberInput extends StatefulWidget {
  const AppNumberInput({
    super.key,
    required this.value,
    required this.onChanged,
    this.min,
    this.max,
    this.step = 1,
    this.label,
    this.unit,
    this.showButtons = true,
    this.autofocus = false,
  });

  final num value;
  final ValueChanged<num> onChanged;
  final num? min;
  final num? max;
  final num step;
  final String? label;
  final String? unit;
  final bool showButtons;
  final bool autofocus;

  @override
  State<AppNumberInput> createState() => _AppNumberInputState();
}

class _AppNumberInputState extends State<AppNumberInput> {
  Timer? _autoRepeatTimer;

  bool get _canDecrement =>
      widget.min == null || widget.value > widget.min!;

  bool get _canIncrement =>
      widget.max == null || widget.value < widget.max!;

  void _increment() {
    if (!_canIncrement) return;
    final newValue = widget.value + widget.step;
    final clamped = widget.max != null && newValue > widget.max!
        ? widget.max!
        : newValue;
    HapticFeedback.lightImpact();
    widget.onChanged(clamped);
  }

  void _decrement() {
    if (!_canDecrement) return;
    final newValue = widget.value - widget.step;
    final clamped = widget.min != null && newValue < widget.min!
        ? widget.min!
        : newValue;
    HapticFeedback.lightImpact();
    widget.onChanged(clamped);
  }

  void _startAutoRepeat(VoidCallback action) {
    _autoRepeatTimer?.cancel();
    _autoRepeatTimer = Timer.periodic(
      const Duration(milliseconds: 100),
      (_) => action(),
    );
  }

  void _stopAutoRepeat() {
    _autoRepeatTimer?.cancel();
    _autoRepeatTimer = null;
  }

  @override
  void dispose() {
    _stopAutoRepeat();
    super.dispose();
  }

  String _formatValue() {
    if (widget.value is int) return widget.value.toString();
    final d = widget.value.toDouble();
    return d == d.roundToDouble() ? d.toInt().toString() : d.toStringAsFixed(1);
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.showButtons)
              GestureDetector(
                onTap: _canDecrement ? _decrement : null,
                onLongPressStart: _canDecrement
                    ? (_) => _startAutoRepeat(_decrement)
                    : null,
                onLongPressEnd: (_) => _stopAutoRepeat(),
                child: _StepperButton(
                  icon: Icons.remove,
                  enabled: _canDecrement,
                ),
              ),
            if (widget.showButtons) const SizedBox(width: AppSpacing.md),
            Text(_formatValue(), style: AppTypography.headingMedium),
            if (widget.unit != null)
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.xs),
                child: Text(widget.unit!, style: AppTypography.bodySmall),
              ),
            if (widget.showButtons) const SizedBox(width: AppSpacing.md),
            if (widget.showButtons)
              GestureDetector(
                onTap: _canIncrement ? _increment : null,
                onLongPressStart: _canIncrement
                    ? (_) => _startAutoRepeat(_increment)
                    : null,
                onLongPressEnd: (_) => _stopAutoRepeat(),
                child: _StepperButton(
                  icon: Icons.add,
                  enabled: _canIncrement,
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  const _StepperButton({required this.icon, required this.enabled});

  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSpacing.minTapTarget,
      height: AppSpacing.minTapTarget,
      decoration: BoxDecoration(
        color: enabled ? AppColors.primary : AppColors.buttonDisabledBg,
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: enabled ? Colors.white : AppColors.buttonDisabledText,
        size: 20,
      ),
    );
  }
}
