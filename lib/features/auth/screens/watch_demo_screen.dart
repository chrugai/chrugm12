import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../router/route_constants.dart';

class WatchDemoScreen extends StatefulWidget {
  const WatchDemoScreen({super.key});

  @override
  State<WatchDemoScreen> createState() => _WatchDemoScreenState();
}

class _WatchDemoScreenState extends State<WatchDemoScreen> {
  bool _isPlaying = false;
  double _sliderValue = 0.39; // ~21:49 / 56:32

  String _formatTime(double fraction, double totalSeconds) {
    final seconds = (fraction * totalSeconds).toInt();
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString()}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const totalSeconds = 3392.0; // 56:32

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
          'Demo',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH,
          ),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              // Mock video player — phone frame
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 9 / 16,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(
                          color: AppColors.inputBorder,
                          width: 4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Mock screen content inside phone
                            Container(
                              color: AppColors.background,
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 24),
                                  // Mock status bar
                                  Row(
                                    children: [
                                      Text(
                                        '9:41',
                                        style: AppTypography.bodySmall
                                            .copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  // Mock header
                                  Row(
                                    children: [
                                      Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: AppColors.buttonDisabledBg,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Login or Signup!',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Mock card
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(
                                                  alpha: 0.05),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: AppColors.accentBlue
                                                .withValues(
                                                    alpha: 0.15),
                                            borderRadius:
                                                BorderRadius.circular(
                                                    4),
                                          ),
                                          child: const Icon(
                                            Icons.fitness_center,
                                            size: 10,
                                            color:
                                                AppColors.accentBlue,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                            children: [
                                              Text(
                                                'Create New Program',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontWeight:
                                                      FontWeight.bold,
                                                  color: AppColors
                                                      .textPrimary,
                                                ),
                                              ),
                                              Text(
                                                'Build your custom program from scratch, one day at a time!',
                                                style: TextStyle(
                                                  fontSize: 6,
                                                  color: AppColors
                                                      .textSecondary,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  // Mock bottom dark section
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.fitness_center,
                                          color: Colors.white38,
                                          size: 28,
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'How to get started?',
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Container(
                                          padding: const EdgeInsets
                                              .symmetric(
                                            horizontal: 12,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(
                                                    6),
                                          ),
                                          child: const Text(
                                            'Watch Video',
                                            style: TextStyle(
                                              fontSize: 7,
                                              fontWeight:
                                                  FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            // Play button overlay
                            Center(
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: Colors.black
                                      .withValues(alpha: 0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.play_arrow,
                                  color: Colors.white,
                                  size: 36,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),

              // Player controls
              Row(
                children: [
                  // Play/pause button
                  GestureDetector(
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: AppColors.textPrimary,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Time display
                  Expanded(
                    child: Row(
                      children: [
                        const Spacer(),
                        Text(
                          '${_formatTime(_sliderValue, totalSeconds)} / 56:32',
                          style: AppTypography.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Timeline slider
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  activeTrackColor: AppColors.textPrimary,
                  inactiveTrackColor:
                      AppColors.textHint.withValues(alpha: 0.3),
                  thumbColor: AppColors.textPrimary,
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                ),
                child: Slider(
                  value: _sliderValue,
                  onChanged: (v) => setState(() => _sliderValue = v),
                ),
              ),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
