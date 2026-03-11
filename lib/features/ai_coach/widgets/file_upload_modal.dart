import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';

class FileUploadModal extends StatelessWidget {
  const FileUploadModal({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Attach File', style: AppTypography.headingSmall),
            const SizedBox(height: AppSpacing.xxl),
            _buildOption(
              context,
              icon: Icons.camera_alt,
              label: 'Camera',
              onTap: () {
                Navigator.pop(context);
                onSelected('camera_photo.jpg');
              },
            ),
            _buildOption(
              context,
              icon: Icons.photo_library,
              label: 'Photo Library',
              onTap: () {
                Navigator.pop(context);
                onSelected('gallery_photo.jpg');
              },
            ),
            _buildOption(
              context,
              icon: Icons.insert_drive_file,
              label: 'Files',
              onTap: () {
                Navigator.pop(context);
                onSelected('document.pdf');
              },
            ),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(label, style: AppTypography.bodyLarge),
      onTap: onTap,
    );
  }
}
