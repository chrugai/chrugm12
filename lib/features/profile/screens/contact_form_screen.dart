import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_button.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../core/widgets/input/app_select_dropdown.dart';
import '../../../core/widgets/input/app_text_input.dart';

class ContactFormScreen extends StatefulWidget {
  const ContactFormScreen({super.key});

  @override
  State<ContactFormScreen> createState() => _ContactFormScreenState();
}

class _ContactFormScreenState extends State<ContactFormScreen> {
  final _messageController = TextEditingController();
  String? _selectedSubject;
  bool _isSending = false;
  bool _sent = false;

  static const _subjectOptions = [
    'General Question',
    'Bug Report',
    'Feature Request',
    'Account Issue',
    'Other',
  ];

  bool get _canSend =>
      _selectedSubject != null &&
      _messageController.text.trim().isNotEmpty &&
      !_isSending;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    if (!_canSend) return;
    setState(() => _isSending = true);
    await Future<void>.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() {
      _isSending = false;
      _sent = true;
    });
    AppToast.showSuccess(
      context,
      "Message sent! We'll get back to you soon.",
    );
  }

  void _resetForm() {
    setState(() {
      _sent = false;
      _selectedSubject = null;
      _messageController.clear();
    });
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
        title: const Text('Contact Us', style: AppTypography.headingSmall),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          child: _sent ? _buildSuccessState() : _buildForm(),
        ),
      ),
    );
  }

  Widget _buildSuccessState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle,
            color: AppColors.success,
            size: 80,
          ),
          const SizedBox(height: AppSpacing.xxl),
          const Text(
            'Thanks for reaching out!',
            style: AppTypography.headingMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "We'll get back to you soon.",
            style: AppTypography.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxxl),
          AppButton(
            label: 'Send Another Message',
            variant: AppButtonVariant.secondary,
            onPressed: _resetForm,
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: AppSpacing.lg),
        AppSelectDropdown(
          label: 'Subject',
          hint: 'Select a subject',
          selectedValue: _selectedSubject,
          options: _subjectOptions,
          onSelected: (value) => setState(() => _selectedSubject = value),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppTextInput(
          label: 'Message',
          hint: 'Type your message here...',
          controller: _messageController,
          maxLines: 6,
          onChanged: (_) => setState(() {}),
        ),
        const Spacer(),
        AppButton(
          label: 'Send',
          isLoading: _isSending,
          isDisabled: !_canSend,
          onPressed: _canSend ? _handleSend : null,
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
