import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/core/theme/app_animations.dart';
import 'package:chrugm12/core/theme/app_colors.dart';
import 'package:chrugm12/core/theme/app_spacing.dart';
import 'package:chrugm12/core/theme/app_theme.dart';
import 'package:chrugm12/core/theme/app_typography.dart';

void main() {
  group('AppColors', () {
    test('primary is dark navy', () {
      expect(AppColors.primary, const Color(0xFF001F3F));
    });

    test('background is lavender', () {
      expect(AppColors.background, const Color(0xFFF3F2F7));
    });
  });

  group('AppTypography', () {
    test('headingLarge fontSize is 24', () {
      expect(AppTypography.headingLarge.fontSize, 24);
    });
  });

  group('AppSpacing', () {
    test('cardRadius is 12', () {
      expect(AppSpacing.cardRadius, 12);
    });
  });

  group('AppAnimations', () {
    test('modalOpen is 300ms', () {
      expect(AppAnimations.modalOpen, const Duration(milliseconds: 300));
    });
  });

  group('AppTheme', () {
    test('lightTheme is valid ThemeData', () {
      final theme = AppTheme.lightTheme;
      expect(theme, isNotNull);
      expect(theme.scaffoldBackgroundColor, AppColors.background);
    });

    testWidgets('MaterialApp renders with AppTheme.lightTheme', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.lightTheme,
          home: const Scaffold(
            body: Center(child: Text('Test')),
          ),
        ),
      );
      expect(find.text('Test'), findsOneWidget);
    });
  });
}
