import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_button_styles.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../router/route_constants.dart';

class WatchDemoScreen extends StatefulWidget {
  const WatchDemoScreen({super.key});

  @override
  State<WatchDemoScreen> createState() => _WatchDemoScreenState();
}

class _WatchDemoScreenState extends State<WatchDemoScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  static const _pages = [
    _DemoPage(
      icon: Icons.fitness_center,
      title: 'Track Your Workouts',
      description:
          'Log sets, reps, and weight for every exercise. See your progress over time with detailed history.',
    ),
    _DemoPage(
      icon: Icons.restaurant_menu,
      title: 'Log Your Nutrition',
      description:
          'Search thousands of foods, track macros, and create custom meals. Hit your daily targets effortlessly.',
    ),
    _DemoPage(
      icon: Icons.smart_toy_outlined,
      title: 'AI-Powered Coaching',
      description:
          'Ask your AI coach about training, nutrition, recovery, and more. Get personalized answers instantly.',
    ),
    _DemoPage(
      icon: Icons.straighten,
      title: 'Body Measurements',
      description:
          'Track 14 body measurements over time. Visualize your transformation with weekly snapshots.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.go(Routes.firstTime),
        ),
        title: const Text(
          'How It Works',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemBuilder: (context, i) => _pages[i],
              ),
            ),
            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColors.secondary
                        : AppColors.textHint.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxxl),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPaddingH,
              ),
              child: _currentPage == _pages.length - 1
                  ? ElevatedButton(
                      style: AppButtonStyles.primary,
                      onPressed: () => context.go(Routes.signup),
                      child: const Text('Get Started'),
                    )
                  : ElevatedButton(
                      style: AppButtonStyles.secondary,
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      ),
                      child: const Text('Next'),
                    ),
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _DemoPage extends StatelessWidget {
  const _DemoPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingH * 2,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 56, color: AppColors.secondary),
          ),
          const SizedBox(height: AppSpacing.xxxl),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
