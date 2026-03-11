import 'package:flutter/material.dart';

abstract class AppColors {
  // Brand colors
  static const Color primary = Color(0xFF001F3F);
  static const Color secondary = Color(0xFF06A77D);
  static const Color accentBlue = Color(0xFF579BFC);

  // Semantic colors
  static const Color danger = Color(0xFFE63946);
  static const Color success = Color(0xFF06A77D);
  static const Color warning = Color(0xFFFFCB00);

  // Background & surface
  static const Color background = Color(0xFFF3F2F7);
  static const Color surface = Color(0xFFFFFFFF);

  // Text colors
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF999999);
  static const Color textHint = Color(0xFF999999);

  // Input field colors
  static const Color inputBorder = Color(0xFFD0D0D0);
  static const Color inputBorderFocused = Color(0xFF001F3F);
  static const Color inputBorderError = Color(0xFFE63946);
  static const Color inputBorderSuccess = Color(0xFF06A77D);
  static const Color inputBackgroundError = Color(0xFFFFE5E5);
  static const Color inputBackgroundSuccess = Color(0xFFE8F5F0);

  // Button colors
  static const Color buttonDisabledBg = Color(0xFFE0E0E0);
  static const Color buttonDisabledText = Color(0xFF999999);

  // Toast colors
  static const Color toastSuccess = Color(0xFF06A77D);
  static const Color toastError = Color(0xFFE63946);
  static const Color toastInfo = Color(0xFF579BFC);
  static const Color toastWarning = Color(0xFFFFCB00);

  // Overlay
  static const Color overlayDim = Color(0x66000000);
}
