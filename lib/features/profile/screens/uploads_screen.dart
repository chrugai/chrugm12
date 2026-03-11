import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../providers/upload_provider.dart';
import '../widgets/upload_tile.dart';

class UploadsScreen extends ConsumerStatefulWidget {
  const UploadsScreen({super.key});

  @override
  ConsumerState<UploadsScreen> createState() => _UploadsScreenState();
}

class _UploadsScreenState extends ConsumerState<UploadsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(uploadProvider.notifier).loadUploads();
    });
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png', 'heic'],
    );

    if (result != null && result.files.single.path != null) {
      final file = result.files.single;
      await ref.read(uploadProvider.notifier).addUpload(
            fileName: file.name,
            fileType: file.extension ?? 'unknown',
            filePath: file.path!,
          );
      if (mounted) {
        AppToast.showSuccess(context, 'Report uploaded');
      }
    }
  }

  Future<void> _confirmDelete(String uploadId, String fileName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        ),
        title: Text('Delete Upload', style: AppTypography.headingSmall),
        content: Text(
          'Are you sure you want to delete "$fileName"? This action cannot be undone.',
          style: AppTypography.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: AppTypography.labelLarge.copyWith(
                color: AppColors.danger,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(uploadProvider.notifier).deleteUpload(uploadId);
      if (mounted) {
        AppToast.showSuccess(context, 'Upload deleted');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploadsAsync = ref.watch(uploadProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        onPressed: _pickFile,
        backgroundColor: AppColors.secondary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const SizedBox(
                      width: AppSpacing.minTapTarget,
                      height: AppSpacing.minTapTarget,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_back, color: AppColors.textPrimary),
                      ),
                    ),
                  ),
                  Text('My Uploads', style: AppTypography.headingLarge),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: uploadsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (e, _) => Center(
                    child: Text(
                      'Failed to load uploads',
                      style: AppTypography.bodyMedium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                  data: (uploads) {
                    if (uploads.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.upload_file,
                              size: 64,
                              color: AppColors.textHint.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            Text(
                              'No uploads yet',
                              style: AppTypography.headingSmall,
                            ),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              'Add your first report.',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.separated(
                      itemCount: uploads.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(height: AppSpacing.md),
                      itemBuilder: (context, index) {
                        final upload = uploads[index];
                        return UploadTile(
                          upload: upload,
                          onDelete: () => _confirmDelete(
                            upload.uploadId,
                            upload.fileName,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
