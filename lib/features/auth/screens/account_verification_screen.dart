import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_toast.dart';
import '../../../router/route_constants.dart';
import '../providers/auth_provider.dart';
import '../widgets/otp_input_field.dart';

class AccountVerificationScreen extends ConsumerStatefulWidget {
  const AccountVerificationScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState
    extends ConsumerState<AccountVerificationScreen> {
  final _otpKey = GlobalKey<OtpInputFieldState>();
  bool _hasError = false;
  bool _hasSuccess = false;
  bool _isVerifying = false;
  int _failedAttempts = 0;
  int _resendCountdown = 0;
  Timer? _resendTimer;

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  void _onOtpCompleted(String code) async {
    if (_isVerifying) return;
    setState(() {
      _isVerifying = true;
      _hasError = false;
      _hasSuccess = false;
    });

    // 500ms delay before verifying
    await Future<void>.delayed(const Duration(milliseconds: 500));

    if (!mounted) return;

    final success =
        await ref.read(authProvider.notifier).verifyOtp(widget.email, code);

    if (!mounted) return;

    if (success) {
      setState(() {
        _hasSuccess = true;
        _isVerifying = false;
      });
      // Brief green flash then navigate
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (mounted) context.go(Routes.workout);
    } else {
      setState(() {
        _hasError = true;
        _isVerifying = false;
        _failedAttempts++;
      });
      AppToast.showError(context, 'Invalid code. Try again.');
      // Brief red flash then clear
      await Future<void>.delayed(const Duration(milliseconds: 500));
      if (mounted) {
        setState(() => _hasError = false);
        _otpKey.currentState?.clear();
      }
    }
  }

  void _resendCode() {
    if (_resendCountdown > 0) return;

    ref.read(authProvider.notifier).signupWithEmail(widget.email);

    setState(() => _resendCountdown = 30);
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        _resendCountdown--;
        if (_resendCountdown <= 0) {
          timer.cancel();
        }
      });
    });
  }

  void _editEmail() {
    context.go(Routes.signup, extra: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go(Routes.signup),
        ),
        title: const Text('Account Verification'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPaddingH),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              // Shield icon
              const Icon(
                Icons.shield,
                color: AppColors.primary,
                size: 32,
              ),
              const SizedBox(height: AppSpacing.lg),
              // "Verify email" heading
              Text(
                'Verify email',
                style: AppTypography.headingLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              // Instruction text
              Text.rich(
                TextSpan(
                  text: 'Enter the 6 digits code we just sent you to ',
                  style: AppTypography.bodyMedium,
                  children: [
                    TextSpan(
                      text: widget.email,
                      style: AppTypography.bodyMedium
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),
              // OTP input
              OtpInputField(
                key: _otpKey,
                onCompleted: _onOtpCompleted,
                hasError: _hasError,
                hasSuccess: _hasSuccess,
              ),
              const SizedBox(height: AppSpacing.lg),
              // Loading indicator
              if (_isVerifying)
                const Padding(
                  padding: EdgeInsets.only(bottom: AppSpacing.md),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              // Resend / Edit email section
              _buildResendSection(),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendSection() {
    if (_resendCountdown > 0) {
      final seconds = _resendCountdown.toString().padLeft(2, '0');
      return Text(
        'You can request a new code in 00:$seconds',
        style: AppTypography.bodyMedium,
      );
    }

    return Row(
      children: [
        Text(
          "Didn't receive the code? ",
          style: AppTypography.bodyMedium,
        ),
        GestureDetector(
          onTap: _resendCode,
          child: Text(
            'Resend',
            style: AppTypography.bodyMedium
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        if (_failedAttempts >= 3) ...[
          Text(
            ' or ',
            style: AppTypography.bodyMedium,
          ),
          GestureDetector(
            onTap: _editEmail,
            child: Text(
              'Edit email',
              style: AppTypography.bodyMedium
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ],
    );
  }
}
