import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';

abstract class AppInputStyles {
  static InputDecoration get defaultDecoration => InputDecoration(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: const TextStyle(color: AppColors.textHint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(
            color: AppColors.inputBorderFocused,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(
            color: AppColors.inputBorderError,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(
            color: AppColors.inputBorderError,
            width: 2,
          ),
        ),
      );

  static InputDecoration get errorDecoration => defaultDecoration.copyWith(
        filled: true,
        fillColor: AppColors.inputBackgroundError,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(
            color: AppColors.inputBorderError,
            width: 2,
          ),
        ),
        errorStyle: const TextStyle(color: AppColors.danger),
      );

  static InputDecoration get successDecoration => defaultDecoration.copyWith(
        filled: true,
        fillColor: AppColors.inputBackgroundSuccess,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          borderSide: const BorderSide(color: AppColors.inputBorderSuccess),
        ),
      );
}
