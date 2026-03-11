import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/features/program/providers/program_provider.dart';
import 'package:chrugm12/features/program/screens/pick_program_screen.dart';
import 'package:chrugm12/features/program/services/program_service.dart';

class FakeProgramNotifier extends ProgramNotifier {
  FakeProgramNotifier() : super(FakeProgramService());

  void setPrograms(List<Program> programs) {
    state = state.copyWith(programs: programs, isLoading: false);
  }
}

class FakeProgramService extends ProgramService {
  FakeProgramService() : super(null as dynamic);

  @override
  dynamic noSuchMethod(Invocation invocation) => null;
}

final _testPrograms = [
  Program(
    programId: 'prog_ppl',
    userId: 'local_user',
    name: 'Push / Pull / Legs',
    description: 'Classic 3-day split targeting push muscles, pull muscles, and legs.',
    days: [],
    isActive: true,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  Program(
    programId: 'prog_ul',
    userId: 'local_user',
    name: 'Upper / Lower',
    description: '4-day split alternating upper and lower body workouts.',
    days: [],
    isActive: false,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  Program(
    programId: 'prog_fb',
    userId: 'local_user',
    name: 'Full Body',
    description: '3-day full body program hitting every major muscle group each session.',
    days: [],
    isActive: false,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  Program(
    programId: 'prog_bro',
    userId: 'local_user',
    name: 'Bro Split',
    description: 'Classic 5-day bodybuilding split with one muscle group per day.',
    days: [],
    isActive: false,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
];

Widget _buildTestWidget(FakeProgramNotifier notifier) {
  return ProviderScope(
    overrides: [
      programProvider.overrideWith((_) => notifier),
    ],
    child: const MaterialApp(
      home: PickAProgramScreen(),
    ),
  );
}

void main() {
  group('PickAProgramScreen', () {
    late FakeProgramNotifier notifier;

    setUp(() {
      notifier = FakeProgramNotifier();
      notifier.setPrograms(_testPrograms);
    });

    testWidgets('renders all program template cards', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Push / Pull / Legs'), findsOneWidget);
      expect(find.text('Upper / Lower'), findsOneWidget);
      expect(find.text('Full Body'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Bro Split'),
        200,
        scrollable: find.byType(Scrollable).last,
      );
      expect(find.text('Bro Split'), findsOneWidget);
    });

    testWidgets('shows Select Program heading', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Select Program'), findsOneWidget);
    });

    testWidgets('shows motivational text', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(
        find.text('Consistency beats perfection \u2014 pick a plan and start today.'),
        findsOneWidget,
      );
    });

    testWidgets('shows search bar', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.text('Search programs'), findsOneWidget);
    });

    testWidgets('search filters program list', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'push');
      await tester.pumpAndSettle();

      expect(find.text('Push / Pull / Legs'), findsOneWidget);
      expect(find.text('Upper / Lower'), findsNothing);
      expect(find.text('Full Body'), findsNothing);
    });

    testWidgets('shows empty state when no programs match search', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'zzzzz');
      await tester.pumpAndSettle();

      expect(find.text('No programs found'), findsOneWidget);
    });

    testWidgets('shows back arrow', (tester) async {
      await tester.pumpWidget(_buildTestWidget(notifier));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
