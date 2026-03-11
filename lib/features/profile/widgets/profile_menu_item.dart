import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.badge,
    this.isDestructive = false,
    this.trailing,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final String? badge;
  final bool isDestructive;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.danger : AppColors.textPrimary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenPaddingH,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyLarge.copyWith(color: color),
              ),
            ),
            if (badge != null)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(AppSpacing.md),
                ),
                child: Text(
                  badge!,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            if (trailing != null) trailing!,
            if (!isDestructive && badge == null && trailing == null)
              const Icon(
                Icons.chevron_right,
                color: AppColors.textSecondary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}
