import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_card.dart';
import '../../../router/route_constants.dart';

class FirstTimeUserScreen extends StatelessWidget {
  const FirstTimeUserScreen({super.key});

  void _showSignUpToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPaddingH,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    // Top bar: profile icon + notification bell
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _showSignUpToast(
                            context,
                            'Please sign up to access profile',
                          ),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: AppColors.buttonDisabledBg,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                              size: 22,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        // "Login or Signup!" tappable text
                        GestureDetector(
                          onTap: () => context.go(Routes.signup),
                          child: Text(
                            'Login or Signup!',
                            style: AppTypography.headingSmall.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _showSignUpToast(
                            context,
                            'Please sign up to view notifications',
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: AppColors.textSecondary,
                            size: 26,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: AppSpacing.xxl),

                    // Create New Program card
                    AppCard(
                      onTap: () => context.go(Routes.pickProgram),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.accentBlue
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(
                                AppSpacing.cardRadius,
                              ),
                            ),
                            child: const Icon(
                              Icons.fitness_center,
                              color: AppColors.accentBlue,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.lg),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Create New Program',
                                  style: AppTypography.headingSmall,
                                ),
                                const SizedBox(height: AppSpacing.xs),
                                Text(
                                  'Build your custom program from scratch, one day at a time!',
                                  style: AppTypography.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppSpacing.xxxl),
                    const SizedBox(height: AppSpacing.xxxl),

                    // Bottom dark section with dumbbell and Watch Video
                    _buildGetStartedSection(context),
                  ],
                ),
              ),
            ),

            // Bottom tab bar (non-functional for unauthenticated user)
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        children: [
          // Dumbbell icon placeholder
          const Icon(
            Icons.fitness_center,
            color: Colors.white54,
            size: 64,
          ),
          const SizedBox(height: AppSpacing.lg),
          const Text(
            'How to get started?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          // Watch Video button
          GestureDetector(
            onTap: () => context.go(Routes.watchDemo),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xxl,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              ),
              child: Text(
                'Watch Video',
                style: AppTypography.labelLarge.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      height: AppSpacing.tabBarHeight,
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomBarItem(
            icon: Icons.fitness_center_outlined,
            label: 'Workout',
            isSelected: true,
            onTap: () {},
          ),
          _BottomBarItem(
            icon: Icons.smart_toy_outlined,
            label: 'AI Coach',
            onTap: () => _showSignUpToast(
              context,
              'Please sign up to use this feature',
            ),
          ),
          _BottomBarItem(
            icon: Icons.restaurant_outlined,
            label: 'Food Log',
            onTap: () => _showSignUpToast(
              context,
              'Please sign up to use this feature',
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomBarItem extends StatelessWidget {
  const _BottomBarItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 80,
        height: AppSpacing.tabBarHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.secondary
                  : AppColors.textSecondary,
              size: 26,
            ),
          ],
        ),
      ),
    );
  }
}
