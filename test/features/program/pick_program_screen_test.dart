import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/features/program/providers/program_provider.dart';
import 'package:chrugm12/features/program/screens/pick_program_screen.dart';

class FakeProgramNotifier extends StateNotifier<ProgramState>
    implements ProgramNotifier {
  FakeProgramNotifier() : super(ProgramState.initial());

  void setPrograms(List<Program> programs) {
    state = state.copyWith(programs: programs, isLoading: false);
  }

  @override
  Future<void> loadPrograms() async {}

  @override
  Future<void> selectProgram(String programId) async {}

  @override
  Future<void> createProgram(String name, {String? description}) async {}

  @override
  Future<void> deleteProgram(String programId) async {}

  @override
  Future<void> addDay(String programId, String dayName) async {}

  @override
  Future<void> renameDay(String dayId, String newName) async {}

  @override
  Future<void> reorderExercises(String dayId, List<String> exerciseIds) async {}
}

final _testPrograms = [
  Program(
    programId: 'prog_ppl',
    userId: 'local_user',
    name: 'Push / Pull / Legs',
    description: 'Classic 3-day split targeting push muscles, pull muscles, and legs.',
    days: const [],
    isActive: true,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  Program(
    programId: 'prog_ul',
    userId: 'local_user',
    name: 'Upper / Lower',
    description: '4-day split alternating upper and lower body workouts.',
    days: const [],
    isActive: false,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  Program(
    programId: 'prog_fb',
    userId: 'local_user',
    name: 'Full Body',
    description: '3-day full body program hitting every major muscle group each session.',
    days: const [],
    isActive: false,
    createdAt: DateTime(2024),
    updatedAt: DateTime(2024),
  ),
  Program(
    programId: 'prog_bro',
    userId: 'local_user',
    name: 'Bro Split',
    description: 'Classic 5-day bodybuilding split with one muscle group per day.',
    days: const [],
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
        find.textContaining('Consistency beats perfection'),
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
