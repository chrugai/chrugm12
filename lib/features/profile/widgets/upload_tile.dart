import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../data/models/upload.dart';

class UploadTile extends StatelessWidget {
  const UploadTile({
    super.key,
    required this.upload,
    required this.onDelete,
  });

  final Upload upload;
  final VoidCallback onDelete;

  IconData _fileIcon(String fileType) {
    final type = fileType.toLowerCase();
    if (type == 'pdf' || type == 'application/pdf') {
      return Icons.picture_as_pdf;
    }
    if (['jpg', 'jpeg', 'png', 'heic', 'image/jpeg', 'image/png']
        .contains(type)) {
      return Icons.image;
    }
    return Icons.insert_drive_file;
  }

  Color _iconColor(String fileType) {
    final type = fileType.toLowerCase();
    if (type == 'pdf' || type == 'application/pdf') {
      return AppColors.danger;
    }
    if (['jpg', 'jpeg', 'png', 'heic', 'image/jpeg', 'image/png']
        .contains(type)) {
      return AppColors.accentBlue;
    }
    return AppColors.textSecondary;
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(upload.uploadId),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        onDelete();
        return false;
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.xl),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: AppCard(
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _iconColor(upload.fileType).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: Icon(
                _fileIcon(upload.fileType),
                color: _iconColor(upload.fileType),
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    upload.fileName,
                    style: AppTypography.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    upload.uploadDate,
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onDelete,
              child: const SizedBox(
                width: AppSpacing.minTapTarget,
                height: AppSpacing.minTapTarget,
                child: Icon(
                  Icons.delete_outline,
                  color: AppColors.textHint,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
