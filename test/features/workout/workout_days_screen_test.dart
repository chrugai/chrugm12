import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/day.dart';
import 'package:chrugm12/data/models/program.dart';
import 'package:chrugm12/data/models/state/program_state.dart';
import 'package:chrugm12/data/models/notification_item.dart';
import 'package:chrugm12/features/profile/providers/notification_provider.dart';
import 'package:chrugm12/features/program/providers/program_provider.dart';
import 'package:chrugm12/features/program/services/program_service.dart';
import 'package:chrugm12/features/workout/screens/workout_days_screen.dart';
import 'package:chrugm12/features/workout/widgets/day_card.dart';

final _now = DateTime.utc(2026, 1, 1);

Program _mockProgram({List<Day>? days}) {
  return Program(
    programId: 'p1',
    userId: 'u1',
    name: 'Push/Pull/Leg',
    days: days ??
        [
          Day(dayId: 'd1', programId: 'p1', dayNumber: 1, dayName: 'Chest', exercises: const [], createdAt: _now, updatedAt: _now),
          Day(dayId: 'd2', programId: 'p1', dayNumber: 2, dayName: 'Back', exercises: const [], createdAt: _now, updatedAt: _now),
          Day(dayId: 'd3', programId: 'p1', dayNumber: 3, dayName: 'Leg', exercises: const [], createdAt: _now, updatedAt: _now),
        ],
    isActive: true,
    createdAt: _now,
    updatedAt: _now,
  );
}

class _FakeProgramNotifier extends ProgramNotifier {
  _FakeProgramNotifier(this._state) : super(_FakeProgramService());
  final ProgramState _state;
  @override ProgramState get state => _state;
  @override set state(ProgramState value) {}
  @override Future<void> loadPrograms() async {}
  @override Future<void> addDay(String programId, String dayName) async {}
}

class _FakeProgramService extends Fake implements ProgramService {}

class _FakeNotificationNotifier extends NotificationNotifier {
  _FakeNotificationNotifier(List<NotificationItem> items) { state = items; }
}

Widget _buildApp({Program? program}) {
  final programState = program != null
      ? ProgramState(programs: [program], currentProgram: program, selectedProgramId: program.programId)
      : ProgramState.initial();
  return ProviderScope(
    overrides: [
      programProvider.overrideWith((_) => _FakeProgramNotifier(programState)),
      notificationProvider.overrideWith((_) => _FakeNotificationNotifier(const [])),
    ],
    child: const MaterialApp(home: WorkoutDaysScreen()),
  );
}

void main() {
  group('WorkoutDaysScreen', () {
    testWidgets('renders day cards with mock program', (tester) async {
      await tester.pumpWidget(_buildApp(program: _mockProgram()));
      await tester.pumpAndSettle();
      expect(find.text('Push/Pull/Leg'), findsOneWidget);
      expect(find.text('Chest'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Leg'), findsOneWidget);
      expect(find.byType(DayCard), findsNWidgets(3));
    });

    testWidgets('empty state shows when no program', (tester) async {
      await tester.pumpWidget(_buildApp());
      await tester.pumpAndSettle();
      expect(find.text('Create New Program'), findsOneWidget);
      expect(find.byType(DayCard), findsNothing);
    });

    testWidgets('tap day card triggers navigation', (tester) async {
      await tester.pumpWidget(_buildApp(program: _mockProgram()));
      await tester.pumpAndSettle();
      expect(find.text('Chest'), findsOneWidget);
      expect(find.byIcon(Icons.share_outlined), findsOneWidget);
      expect(find.byIcon(Icons.notifications_outlined), findsOneWidget);
      expect(find.text('Add Workout Day'), findsOneWidget);
      expect(find.text('Change Program >'), findsOneWidget);
    });
  });
}
