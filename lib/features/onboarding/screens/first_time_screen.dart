import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_button_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../router/route_constants.dart';

class FirstTimeScreen extends StatelessWidget {
  const FirstTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH,
          ),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo / branding
              const Text(
                'CHRUG',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primary,
                  letterSpacing: 8,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Your AI-powered fitness companion',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const Spacer(flex: 3),
              // Feature highlights
              const _FeatureRow(
                icon: Icons.fitness_center,
                title: 'Smart Workouts',
                subtitle: 'Track sets, reps, and rest with ease',
              ),
              const SizedBox(height: AppSpacing.xl),
              const _FeatureRow(
                icon: Icons.restaurant_menu,
                title: 'Nutrition Logging',
                subtitle: 'Hit your macros every day',
              ),
              const SizedBox(height: AppSpacing.xl),
              const _FeatureRow(
                icon: Icons.smart_toy_outlined,
                title: 'AI Coach',
                subtitle: 'Get personalized advice anytime',
              ),
              const Spacer(flex: 2),
              // Actions
              ElevatedButton(
                style: AppButtonStyles.primary,
                onPressed: () => context.go(Routes.signup),
                child: const Text('Get Started'),
              ),
              const SizedBox(height: AppSpacing.md),
              ElevatedButton(
                style: AppButtonStyles.secondary,
                onPressed: () => context.go(Routes.watchDemo),
                child: const Text('Watch Demo'),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  const _FeatureRow({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.secondary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          ),
          child: Icon(icon, color: AppColors.secondary, size: 24),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
