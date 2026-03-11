import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/features/auth/screens/watch_demo_screen.dart';

void main() {
  Widget buildTestWidget() {
    return const MaterialApp(
      home: WatchDemoScreen(),
    );
  }

  group('WatchDemoScreen', () {
    testWidgets('renders play button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.byIcon(Icons.play_arrow), findsWidgets);
    });

    testWidgets('renders "Demo" title', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      expect(find.text('Demo'), findsOneWidget);
    });

    testWidgets('renders time display', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      // Should show time in format X:XX / 56:32
      expect(find.textContaining('56:32'), findsOneWidget);
    });

    testWidgets('play/pause icon toggles on tap', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      // Initially shows play icon in controls
      expect(find.byIcon(Icons.play_arrow), findsWidgets);
      expect(find.byIcon(Icons.pause), findsNothing);

      // Find the play button in the controls area (bottom, not the overlay)
      // Tap it to toggle
      final playButtons = find.byIcon(Icons.play_arrow);
      await tester.tap(playButtons.last);
      await tester.pump();

      // Now should show pause icon
      expect(find.byIcon(Icons.pause), findsOneWidget);
    });
  });
}
