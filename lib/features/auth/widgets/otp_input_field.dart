import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class OtpInputField extends StatefulWidget {
  const OtpInputField({
    super.key,
    required this.onCompleted,
    this.hasError = false,
    this.hasSuccess = false,
  });

  final ValueChanged<String> onCompleted;
  final bool hasError;
  final bool hasSuccess;

  @override
  State<OtpInputField> createState() => OtpInputFieldState();
}

class OtpInputFieldState extends State<OtpInputField> {
  static const _length = 6;
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(_length, (_) => TextEditingController());
    _focusNodes = List.generate(_length, (_) => FocusNode());

    // Auto-focus first field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void clear() {
    for (final c in _controllers) {
      c.clear();
    }
    if (mounted) _focusNodes[0].requestFocus();
  }

  String get _code => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.length > 1) {
      // Paste support: distribute digits across fields
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (var i = 0; i < _length && i < digits.length; i++) {
        _controllers[i].text = digits[i];
      }
      final lastFilled =
          digits.length >= _length ? _length - 1 : digits.length;
      if (lastFilled < _length) {
        _focusNodes[lastFilled].requestFocus();
      }
      if (digits.length >= _length) {
        _checkComplete();
      }
      return;
    }

    if (value.isNotEmpty) {
      // Auto-advance to next field
      if (index < _length - 1) {
        _focusNodes[index + 1].requestFocus();
      }
      _checkComplete();
    }
  }

  void _onKeyEvent(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _controllers[index - 1].clear();
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  void _checkComplete() {
    final code = _code;
    if (code.length == _length) {
      widget.onCompleted(code);
    }
  }

  Color get _borderColor {
    if (widget.hasError) return AppColors.danger;
    if (widget.hasSuccess) return AppColors.success;
    return AppColors.inputBorder;
  }

  Color get _focusedBorderColor {
    if (widget.hasError) return AppColors.danger;
    if (widget.hasSuccess) return AppColors.success;
    return AppColors.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_length, (index) {
        return Container(
          width: 44,
          height: 50,
          margin: EdgeInsets.only(right: index < _length - 1 ? 8 : 0),
          child: KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (event) => _onKeyEvent(index, event),
            child: TextField(
              controller: _controllers[index],
              focusNode: _focusNodes[index],
              onChanged: (v) => _onChanged(index, v),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(1),
              ],
              style: AppTypography.headingMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                filled: false,
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: _borderColor, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _borderColor, width: 2),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: _focusedBorderColor, width: 2),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
