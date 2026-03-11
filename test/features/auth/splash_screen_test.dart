import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/core/theme/app_colors.dart';
import 'package:chrugm12/features/auth/screens/splash_screen.dart';

void main() {
  group('SplashScreen', () {
    testWidgets('renders branded splash with CHRUG text and spinner',
        (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SplashScreen(),
          ),
        ),
      );

      // Verify primary background
      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(scaffold.backgroundColor, AppColors.primary);

      // Verify CHRUG text
      expect(find.text('CHRUG'), findsOneWidget);
      final text = tester.widget<Text>(find.text('CHRUG'));
      expect(text.style?.color, Colors.white);
      expect(text.style?.fontWeight, FontWeight.w900);

      // Verify loading spinner
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('does not show app bar', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SplashScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsNothing);
    });
  });
}
