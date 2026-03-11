import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/display/app_accordion.dart';
import '../../../data/seeds/faq_seeds.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final faqs = getFaqs();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: Text('FAQs', style: AppTypography.headingMedium),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: faqs.length,
        separatorBuilder: (_, _) =>
            const Divider(height: 1, color: AppColors.inputBorder),
        itemBuilder: (context, index) {
          final faq = faqs[index];
          return AppAccordion(
            title: faq.question,
            content: Text(
              faq.answer,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
          );
        },
      ),
    );
  }
}
