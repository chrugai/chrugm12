import 'dart:io';

import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../theme/app_typography.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.onTap,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget avatar;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      final isFile =
          imageUrl!.startsWith('/') || imageUrl!.startsWith('file://');
      avatar = CircleAvatar(
        radius: size / 2,
        backgroundImage:
            isFile ? FileImage(File(imageUrl!)) : NetworkImage(imageUrl!),
        backgroundColor: AppColors.inputBorder,
      );
    } else {
      avatar = CircleAvatar(
        radius: size / 2,
        backgroundColor: AppColors.primary,
        child: Text(
          initials ?? '',
          style: AppTypography.bodyMedium.copyWith(
            color: Colors.white,
            fontSize: size * 0.35,
          ),
        ),
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }
    return avatar;
  }
}
