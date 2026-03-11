import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/features/program/providers/program_provider.dart';
import 'package:chrugm12/features/program/screens/create_program_modal.dart';
import 'package:chrugm12/features/program/screens/change_program_modal.dart';
import 'package:chrugm12/features/program/widgets/program_card.dart';

class FakeProgramNotifier extends StateNotifier<ProgramState>
    implements ProgramNotifier {
  FakeProgramNotifier(ProgramState initial) : super(initial);

  @override
  Future<void> loadPrograms() async {}

  @override
  Future<void> createProgram(String name, {String? description}) async {
    final program = Program(
      programId: 'test-id',
      userId: 'local_user',
      name: name,
      days: const [],
      isActive: true,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    state = state.copyWith(
      programs: [...state.programs, program],
      currentProgram: program,
      selectedProgramId: program.programId,
    );
  }

  @override
  Future<void> selectProgram(String programId) async {
    state = state.copyWith(selectedProgramId: programId);
  }

  @override
  Future<void> deleteProgram(String programId) async {}

  @override
  Future<void> addDay(String programId, String dayName) async {}

  @override
  Future<void> renameDay(String dayId, String newName) async {}

  @override
  Future<void> reorderExercises(
      String dayId, List<String> exerciseIds) async {}

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final _testPrograms = [
  Program(
    programId: 'p1',
    userId: 'local_user',
    name: 'Push/Pull/Leg',
    days: const [],
    isActive: true,
    createdAt: DateTime(2026, 1, 1),
    updatedAt: DateTime(2026, 1, 1),
  ),
  Program(
    programId: 'p2',
    userId: 'local_user',
    name: 'Iron Forge',
    days: const [],
    isActive: false,
    createdAt: DateTime(2026, 1, 2),
    updatedAt: DateTime(2026, 1, 2),
  ),
];

void main() {
  group('CreateProgramModal', () {
    testWidgets('Create button is disabled when input is empty', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState.initial()),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: CreateProgramModal())),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Create'), findsOneWidget);
      final opacity = tester.widgetList<Opacity>(find.byType(Opacity));
      expect(opacity.where((o) => o.opacity == 0.5).toList(), isNotEmpty);
    });

    testWidgets('Create button enables when text is entered', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState.initial()),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: CreateProgramModal())),
        ),
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'My Program');
      await tester.pumpAndSettle();
      final opacity = tester.widgetList<Opacity>(find.byType(Opacity));
      expect(opacity.where((o) => o.opacity == 0.5).toList(), isEmpty);
    });

    testWidgets('Suggestion bubble tap fills input', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState.initial()),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: SingleChildScrollView(child: CreateProgramModal())),
          ),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Push/Pull/Leg'));
      await tester.pumpAndSettle();
      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, 'Push/Pull/Leg');
    });

    testWidgets('renders title and close button', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState.initial()),
            ),
          ],
          child: const MaterialApp(home: Scaffold(body: CreateProgramModal())),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Enter Program Name'), findsOneWidget);
      expect(find.byIcon(Icons.close), findsOneWidget);
    });
  });

  group('ChangeProgramModal', () {
    testWidgets('renders program list', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState(
                programs: _testPrograms,
                selectedProgramId: 'p1',
                currentProgram: _testPrograms.first,
              )),
            ),
          ],
          child: const MaterialApp(home: ChangeProgramModal()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('Change Program'), findsOneWidget);
      expect(find.text('Create New Program'), findsOneWidget);
      expect(find.text('Your Programs'), findsOneWidget);
      expect(find.text('Push/Pull/Leg'), findsOneWidget);
      expect(find.text('Iron Forge'), findsOneWidget);
    });

    testWidgets('shows active indicator on selected program', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState(
                programs: _testPrograms,
                selectedProgramId: 'p1',
                currentProgram: _testPrograms.first,
              )),
            ),
          ],
          child: const MaterialApp(home: ChangeProgramModal()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('shows empty state when no programs', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWith(
              (ref) => FakeProgramNotifier(ProgramState.initial()),
            ),
          ],
          child: const MaterialApp(home: ChangeProgramModal()),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('No programs yet. Create your first one!'), findsOneWidget);
    });
  });

  group('ProgramCard', () {
    testWidgets('renders program name', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ProgramCard(program: _testPrograms.first, onTap: () {}))),
      );
      expect(find.text('Push/Pull/Leg'), findsOneWidget);
    });

    testWidgets('shows check_circle when active', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ProgramCard(program: _testPrograms.first, isActive: true, onTap: () {}))),
      );
      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });

    testWidgets('does not show check_circle when inactive', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: ProgramCard(program: _testPrograms.first, isActive: false, onTap: () {}))),
      );
      expect(find.byIcon(Icons.check_circle), findsNothing);
    });
  });
}
