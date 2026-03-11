import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/route_constants.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key, this.initialEmail});

  final String? initialEmail;

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late final TextEditingController _emailController;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail ?? '');
    _emailController.addListener(() {
      if (_emailError != null) {
        setState(() => _emailError = null);
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool get _hasEmail => _emailController.text.trim().isNotEmpty;

  void _submitEmail() {
    final email = _emailController.text.trim();
    if (!email.contains('@')) {
      setState(() => _emailError = 'Enter valid email');
      return;
    }

    ref.read(authProvider.notifier).signupWithEmail(email);
    context.go(Routes.verify, extra: email);
  }

  void _signInWithApple() async {
    await ref.read(authProvider.notifier).signInWithApple();
    if (!mounted) return;
    final authState = ref.read(authProvider);
    if (authState.isAuthenticated) {
      context.go(Routes.workout);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Colors.black],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Column(
              children: [
                // Cancel button (top-right)
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => context.go(Routes.firstTime),
                    child: Text(
                      'Cancel',
                      style: AppTypography.bodyLarge
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
                const Spacer(),
                // Dumbbell icon
                const Icon(
                  Icons.fitness_center,
                  color: Colors.white,
                  size: 64,
                ),
                const SizedBox(height: AppSpacing.xl),
                // Apple Sign-In button
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: _signInWithApple,
                    icon: const Icon(Icons.apple, color: Colors.black,
                        size: 24),
                    label: Text(
                      'Continue with Apple',
                      style: AppTypography.buttonText
                          .copyWith(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // Google Sign-In button
                SizedBox(
                  width: double.infinity,
                  height: AppSpacing.buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Text(
                      'G',
                      style: AppTypography.headingMedium
                          .copyWith(color: Colors.black),
                    ),
                    label: Text(
                      'Continue with Google',
                      style: AppTypography.buttonText
                          .copyWith(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppSpacing.cardRadius),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                // "or" divider
                Row(
                  children: [
                    const Expanded(child: Divider(color: Colors.white38)),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm),
                      child: Text(
                        'or',
                        style: AppTypography.bodyMedium
                            .copyWith(color: Colors.white60),
                      ),
                    ),
                    const Expanded(child: Divider(color: Colors.white38)),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                // "Email" label
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    style: AppTypography.labelLarge
                        .copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                // Email input with arrow button
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: AppSpacing.inputHeight,
                        child: TextField(
                          controller: _emailController,
                          autofocus: widget.initialEmail == null,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _submitEmail(),
                          style: AppTypography.bodyLarge,
                          decoration: InputDecoration(
                            hintText: 'example@mail.com',
                            hintStyle: AppTypography.bodyLarge
                                .copyWith(color: AppColors.textHint),
                            errorText: _emailError,
                            errorStyle: AppTypography.bodySmall
                                .copyWith(color: AppColors.danger),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.lg,
                              vertical: AppSpacing.md,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.cardRadius),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.cardRadius),
                              borderSide: BorderSide.none,
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.cardRadius),
                              borderSide: const BorderSide(
                                  color: AppColors.danger),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  AppSpacing.cardRadius),
                              borderSide: const BorderSide(
                                  color: AppColors.danger),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_hasEmail) ...[
                      const SizedBox(width: AppSpacing.sm),
                      GestureDetector(
                        onTap: _submitEmail,
                        child: Container(
                          width: AppSpacing.inputHeight,
                          height: AppSpacing.inputHeight,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(
                                AppSpacing.cardRadius),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const Spacer(),
                // Privacy Policy & Terms of Service
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Privacy Policy',
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white60,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white60,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xxl),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Terms of Service',
                          style: AppTypography.bodySmall.copyWith(
                            color: Colors.white60,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white60,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
