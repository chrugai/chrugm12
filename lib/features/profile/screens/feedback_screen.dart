import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../core/widgets/input/app_text_input.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _commentController = TextEditingController();
  int? _rating;
  bool _isSubmitting = false;

  bool get _canSubmit => _rating != null && !_isSubmitting;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    if (!_canSubmit) return;
    setState(() => _isSubmitting = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isSubmitting = false);
    AppToast.showSuccess(context, 'Thanks for your feedback!');
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Feedback', style: AppTypography.headingSmall),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxxl),
              const Text(
                "How's your experience?",
                style: AppTypography.headingLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxxl),
              _buildRatingRow(),
              const SizedBox(height: AppSpacing.xxxl),
              AppTextInput(
                label: 'Tell us more (optional)',
                hint: 'Share your thoughts...',
                controller: _commentController,
                maxLines: 4,
              ),
              const Spacer(),
              AppButton(
                label: 'Submit',
                isLoading: _isSubmitting,
                isDisabled: !_canSubmit,
                onPressed: _canSubmit ? _handleSubmit : null,
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        final isSelected = _rating != null && starIndex <= _rating!;
        return GestureDetector(
          onTap: () {
            HapticFeedback.lightImpact();
            setState(() => _rating = starIndex);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            child: Icon(
              isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
              size: AppSpacing.minTapTarget,
              color: isSelected ? AppColors.warning : AppColors.textSecondary,
            ),
          ),
        );
      }),
    );
  }
}
