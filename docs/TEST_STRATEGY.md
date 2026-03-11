# TEST_STRATEGY.md — Chrug MVP Phase 1

## Overview

Chrug MVP Phase 1 testing strategy focuses on **fast, reliable local testing**. No network mocking needed (no API calls). All data in SQLite, no external dependencies.

**Goal:** 80% code coverage, zero flaky tests, < 2 minute full test suite runtime.

---

## Testing Pyramid

```
        /\
       /  \  E2E & Integration Tests (10% of tests)
      /    \ - Full user flows
     /______\- Database state validation
    
    /        \
   /          \ Widget Tests (30% of tests)
  /            \- Screen rendering
 /              \- UI interactions
/________________\

|                |
|                | Unit Tests (60% of tests)
|                |- Services, Providers, Models
|________________|-Utilities, Helpers
```

---

## Unit Tests

### Test Coverage Areas

#### **1. Services Layer**

**ProgramService Tests**

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('ProgramService', () {
    late ProgramService service;
    late MockDatabase mockDb;

    setUp(() {
      mockDb = MockDatabase();
      service = ProgramService(mockDb);
    });

    test('createProgram inserts into database', () async {
      // Arrange
      const programName = 'Push/Pull/Legs';
      final exercises = [
        Exercise(exerciseId: 'ex_1', name: 'Bench Press', ...),
      ];
      
      // Act
      final result = await service.createProgram(programName, exercises);
      
      // Assert
      expect(result.name, equals(programName));
      expect(result.programId, isNotEmpty);
      verify(mockDb.insert(any, any)).called(1);
    });

    test('selectProgram updates active program', () async {
      // Arrange
      const programId = 'prog_1';
      
      // Act
      await service.selectProgram(programId);
      
      // Assert
      verify(mockDb.update(any, any)).called(1);
    });

    test('listPrograms returns all programs', () async {
      // Arrange
      final expectedPrograms = [
        Program(programId: 'prog_1', name: 'PPL', ...),
        Program(programId: 'prog_2', name: 'UL', ...),
      ];
      when(mockDb.select(any)).thenAnswer((_) => Future.value(expectedPrograms));
      
      // Act
      final result = await service.listPrograms();
      
      // Assert
      expect(result.length, equals(2));
      expect(result.first.name, equals('PPL'));
    });

    test('deleteProgram removes from database', () async {
      // Arrange
      const programId = 'prog_1';
      
      // Act
      await service.deleteProgram(programId);
      
      // Assert
      verify(mockDb.delete(any, any)).called(1);
    });
  });
}
```

**WorkoutService Tests**

```dart
void main() {
  group('WorkoutService', () {
    late WorkoutService service;
    late MockDatabase mockDb;

    setUp(() {
      mockDb = MockDatabase();
      service = WorkoutService(mockDb);
    });

    test('recordSet inserts set into database', () async {
      // Arrange
      final set = Set(
        setId: UUID(),
        exerciseId: 'bench_1',
        dayId: 'day_1',
        reps: 8,
        weightKg: 185.0,
        timestamp: DateTime.now(),
      );

      // Act
      await service.recordSet(set);

      // Assert
      verify(mockDb.insert(any, any)).called(1);
    });

    test('deleteSet removes set from database', () async {
      // Arrange
      const setId = 'set_1';

      // Act
      await service.deleteSet(setId);

      // Assert
      verify(mockDb.delete(any, any)).called(1);
    });

    test('getSetsForExercise returns sorted by timestamp', () async {
      // Arrange
      const exerciseId = 'bench_1';
      final sets = [
        Set(setId: 's1', ..., timestamp: DateTime(2025, 1, 30, 14, 30)),
        Set(setId: 's2', ..., timestamp: DateTime(2025, 1, 30, 14, 35)),
        Set(setId: 's3', ..., timestamp: DateTime(2025, 1, 30, 14, 25)),
      ];
      when(mockDb.select(any, exerciseId: exerciseId))
          .thenAnswer((_) => Future.value(sets.where((s) => s.exerciseId == exerciseId).toList()));

      // Act
      final result = await service.getSetsForExercise(exerciseId);

      // Assert
      expect(result[0].timestamp.isAfter(result[1].timestamp), isTrue); // Newest first
    });

    test('startRestTimer updates rest state', () {
      // Arrange
      const duration = 180; // seconds

      // Act
      service.startRestTimer(duration);

      // Assert
      expect(service.restTimerActive, isTrue);
      expect(service.restTimerDuration, equals(duration));
    });
  });
}
```

**NutritionService Tests**

```dart
void main() {
  group('NutritionService', () {
    late NutritionService service;
    late MockDatabase mockDb;

    setUp(() {
      mockDb = MockDatabase();
      service = NutritionService(mockDb);
    });

    test('addFoodToMeal creates or updates meal', () async {
      // Arrange
      final food = Food(
        foodId: 'chicken_breast',
        name: 'Chicken Breast (Cooked)',
        caloriesPer100g: 165,
        proteinGPer100g: 31,
        carbsGPer100g: 0,
        fatGPer100g: 3.6,
        isUserCustom: false,
        createdAt: DateTime.now(),
      );
      const date = '2025-01-30';
      const quantityGrams = 200;

      // Act
      await service.addFoodToMeal(food, date, quantityGrams);

      // Assert
      verify(mockDb.insert(any, any)).called(atLeastOnce);
    });

    test('calculateDailyTotals sums all meals for date', () async {
      // Arrange
      const date = '2025-01-30';
      final meals = [
        Meal(
          mealId: 'meal_1',
          foods: [
            MealFood(food: Food(..., caloriesPer100g: 165), quantityGrams: 200),
          ],
          totalCalories: 330,
          totalProteinG: 62,
          totalCarbsG: 0,
          totalFatG: 7.2,
        ),
        Meal(
          mealId: 'meal_2',
          foods: [...],
          totalCalories: 400,
          totalProteinG: 40,
          totalCarbsG: 50,
          totalFatG: 12,
        ),
      ];
      when(mockDb.select(any, date: date))
          .thenAnswer((_) => Future.value(meals));

      // Act
      final totals = await service.calculateDailyTotals(date);

      // Assert
      expect(totals.totalCalories, equals(730));
      expect(totals.totalProteinG, equals(102));
    });

    test('createCustomFood inserts into database', () async {
      // Arrange
      const name = 'My Protein Shake';
      const calories = 250;
      const protein = 30;

      // Act
      await service.createCustomFood(name, calories, protein, 10, 5);

      // Assert
      verify(mockDb.insert(any, any)).called(1);
    });
  });
}
```

#### **2. Providers (Riverpod State Management)**

```dart
void main() {
  group('authProvider', () {
    test('authProvider.signupWithEmail updates state', () async {
      // Arrange
      final container = ProviderContainer();
      const email = 'test@example.com';

      // Act
      await container.read(authProvider.notifier).signupWithEmail(email);

      // Assert
      final state = container.read(authProvider);
      expect(state.isAuthenticated, isTrue);
      expect(state.user?.email, equals(email));
    });

    test('authProvider.logout clears state', () {
      // Arrange
      final container = ProviderContainer();
      
      // Act
      container.read(authProvider.notifier).logout();
      
      // Assert
      final state = container.read(authProvider);
      expect(state.isAuthenticated, isFalse);
      expect(state.user, isNull);
    });
  });

  group('workoutProvider', () {
    test('workoutProvider.recordSet adds to loggedSets', () async {
      // Arrange
      final container = ProviderContainer();
      final set = Set(
        setId: UUID(),
        exerciseId: 'bench_1',
        dayId: 'day_1',
        reps: 8,
        weightKg: 185.0,
        timestamp: DateTime.now(),
      );

      // Act
      await container.read(workoutProvider.notifier).recordSet(set);

      // Assert
      final state = container.read(workoutProvider);
      expect(state.loggedSets, contains(set));
    });
  });
}
```

#### **3. Model Serialization**

```dart
void main() {
  group('User Model Serialization', () {
    test('User.fromJson deserializes correctly', () {
      // Arrange
      final json = {
        'userId': 'user_123',
        'email': 'jimmy@gmail.com',
        'name': 'Jimmy Chen',
        'heightCm': 178,
        'weightKg': 85,
        'isAuthenticated': true,
        'createdAt': '2025-01-30T00:00:00.000Z',
        'updatedAt': '2025-01-30T00:00:00.000Z',
      };

      // Act
      final user = User.fromJson(json);

      // Assert
      expect(user.userId, equals('user_123'));
      expect(user.email, equals('jimmy@gmail.com'));
      expect(user.heightCm, equals(178));
    });

    test('User.toJson serializes correctly', () {
      // Arrange
      final user = User(
        userId: 'user_123',
        email: 'jimmy@gmail.com',
        name: 'Jimmy Chen',
        heightCm: 178,
        weightKg: 85,
        isAuthenticated: true,
        createdAt: DateTime(2025, 1, 30),
        updatedAt: DateTime(2025, 1, 30),
      );

      // Act
      final json = user.toJson();

      // Assert
      expect(json['userId'], equals('user_123'));
      expect(json['email'], equals('jimmy@gmail.com'));
      expect(json['heightCm'], equals(178));
    });
  });

  group('Set Model Serialization', () {
    test('Set with optional fields serializes correctly', () {
      // Arrange
      final set = Set(
        setId: 'set_1',
        exerciseId: 'bench_1',
        dayId: 'day_1',
        reps: 8,
        weightKg: 185.0,
        repsInReserve: 2,
        tempoVariation: 'Normal',
        notes: 'Felt strong',
        timestamp: DateTime(2025, 1, 30, 14, 30),
      );

      // Act
      final json = set.toJson();
      final deserialized = Set.fromJson(json);

      // Assert
      expect(deserialized, equals(set));
    });
  });
}
```

#### **4. Utilities & Helpers**

```dart
void main() {
  group('MacroCalculations', () {
    test('calculateMacrosForMealFood calculates correctly', () {
      // Arrange
      final food = Food(
        foodId: 'chicken_breast',
        name: 'Chicken Breast (Cooked)',
        caloriesPer100g: 165,
        proteinGPer100g: 31,
        carbsGPer100g: 0,
        fatGPer100g: 3.6,
        isUserCustom: false,
        createdAt: DateTime.now(),
      );
      const quantityGrams = 200;

      // Act
      final macros = calculateMacrosForQuantity(food, quantityGrams);

      // Assert
      expect(macros.calories, equals(330)); // (165 * 200) / 100
      expect(macros.protein, equals(62)); // (31 * 200) / 100
      expect(macros.fat, equals(7.2)); // (3.6 * 200) / 100
    });

    test('calculateDailyTotals sums macros correctly', () {
      // Arrange
      final meals = [
        MealWithMacros(calories: 330, protein: 62, carbs: 0, fat: 7.2),
        MealWithMacros(calories: 400, protein: 40, carbs: 50, fat: 12),
      ];

      // Act
      final totals = calculateDailyTotals(meals);

      // Assert
      expect(totals.calories, equals(730));
      expect(totals.protein, equals(102));
      expect(totals.carbs, equals(50));
      expect(totals.fat, equals(19.2));
    });
  });

  group('DateFormatting', () {
    test('formatDateForDisplay returns readable format', () {
      // Arrange
      final date = DateTime(2025, 1, 30);

      // Act
      final formatted = formatDateForDisplay(date);

      // Assert
      expect(formatted, equals('Jan 30'));
    });

    test('isoStringToDateTime parses ISO date correctly', () {
      // Arrange
      const isoString = '2025-01-30';

      // Act
      final date = isoStringToDateTime(isoString);

      // Assert
      expect(date.year, equals(2025));
      expect(date.month, equals(1));
      expect(date.day, equals(30));
    });
  });
}
```

---

## Widget Tests

### Test Coverage Areas

#### **1. Screen Rendering**

```dart
void main() {
  group('WorkoutDaysScreen Widget Tests', () {
    testWidgets('WorkoutDaysScreen renders program name', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            programProvider.overrideWithValue(
              AsyncValue.data(
                Program(
                  programId: 'prog_1',
                  name: 'Push/Pull/Legs',
                  days: [...],
                  ...
                ),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Push/Pull/Legs'), findsOneWidget);
    });

    testWidgets('WorkoutDaysScreen displays day cards', (WidgetTester tester) async {
      // Arrange
      final days = [
        Day(dayId: 'day_1', dayName: 'Push', ...),
        Day(dayId: 'day_2', dayName: 'Pull', ...),
        Day(dayId: 'day_3', dayName: 'Legs', ...),
      ];

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            workoutProvider.overrideWithValue(
              WorkoutState(currentDayExercises: [], loggedSets: []),
            ),
          ],
          child: const MyApp(),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(DayCard), findsWidgets);
      expect(find.text('Push'), findsOneWidget);
      expect(find.text('Pull'), findsOneWidget);
      expect(find.text('Legs'), findsOneWidget);
    });
  });

  group('ExerciseDetailsScreen Widget Tests', () {
    testWidgets('Displays exercise image', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        ProviderScope(
          child: const MyApp(),
        ),
      );

      // Navigate to ExerciseDetailsScreen
      // (use navigation or direct pumpWidget)

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Image), findsWidgets); // Exercise image
      expect(find.text('Bench Press'), findsOneWidget); // Exercise name
    });

    testWidgets('Shows "+ Add Set" button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('+ Add Set'), findsOneWidget);
      expect(find.byType(FloatingActionButton), findsOneWidget);
    });
  });
}
```

#### **2. User Interactions**

```dart
void main() {
  group('AddSetModalSheet Interactions', () {
    testWidgets('Entering reps enables Record Set button', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to ExerciseDetailsScreen and tap "+ Add Set"
      // (mock navigation as needed)

      // Act
      // Tap Reps field
      await tester.tap(find.byType(TextField).first);
      await tester.pumpAndSettle();

      // Type "8"
      await tester.enterText(find.byType(TextField).first, '8');
      await tester.pumpAndSettle();

      // Tap Weight field
      await tester.tap(find.byType(TextField).last);
      await tester.pumpAndSettle();

      // Type "185"
      await tester.enterText(find.byType(TextField).last, '185');
      await tester.pumpAndSettle();

      // Assert
      expect(
        find.byWidgetPredicate(
          (widget) => widget is ElevatedButton && widget.enabled,
        ),
        findsOneWidget,
      ); // Record Set button is enabled
    });

    testWidgets('Tapping Record Set closes modal and starts timer', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act
      // Enter reps and weight (as above)
      await tester.tap(find.byType(TextField).first);
      await tester.enterText(find.byType(TextField).first, '8');
      await tester.pumpAndSettle();

      // Tap "Record Set" button
      await tester.tap(find.byWidgetPredicate(
        (widget) => widget is ElevatedButton && widget.enabled,
      ));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AddSetModalSheet), findsNothing); // Modal closed
      expect(find.byType(RestTimerPill), findsOneWidget); // Timer started
    });
  });

  group('FoodLoggerScreen Interactions', () {
    testWidgets('Tapping "+ Add Food" navigates to AddFoodScreen', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to FoodLoggerScreen
      // (mock tab navigation)

      // Act
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(AddFoodScreen), findsOneWidget);
    });

    testWidgets('Selecting a food updates progress bars', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act
      // Navigate to AddFoodScreen, search for food, tap "+ Add"
      // (detailed steps omitted for brevity)

      // Assert
      expect(find.byType(ProgressBar), findsWidgets); // Progress bars updated
    });
  });
}
```

---

## Integration Tests

### Full User Flows

```dart
void main() {
  group('Full Workout Logging Flow', () {
    testWidgets('Complete flow: create program → log sets', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Act & Assert - Create Program
      // Tap "Create New Program"
      await tester.tap(find.text('Create New Program'));
      await tester.pumpAndSettle();

      // Enter program name
      await tester.enterText(
        find.byType(TextField).first,
        'Push/Pull/Legs',
      );
      await tester.pumpAndSettle();

      // Tap "Create"
      await tester.tap(find.byType(ElevatedButton).first);
      await tester.pumpAndSettle();

      // Select exercises
      // ... (select bench press, incline press, flyes)

      // Assert - Program created
      expect(find.text('Push/Pull/Legs'), findsOneWidget);
      expect(find.byType(DayCard), findsWidgets);

      // Act & Assert - Log Set
      // Tap first exercise
      await tester.tap(find.byType(ExerciseCard).first);
      await tester.pumpAndSettle();

      // Tap "+ Add Set"
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Enter reps and weight
      await tester.enterText(find.byType(TextField).first, '8');
      await tester.enterText(find.byType(TextField).last, '185');
      await tester.pumpAndSettle();

      // Tap "Record Set"
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Assert - Set recorded and timer started
      expect(find.byType(RestTimerPill), findsOneWidget);
      expect(find.text('3:00'), findsOneWidget); // 180 seconds
    });
  });

  group('Full Nutrition Logging Flow', () {
    testWidgets('Complete flow: log foods → verify totals', (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();

      // Navigate to FoodLoggerScreen
      await tester.tap(find.byIcon(Icons.restaurant));
      await tester.pumpAndSettle();

      // Act & Assert - Add Food
      // Tap "+ Add Food"
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Search for food
      await tester.enterText(find.byType(SearchBar), 'chicken');
      await tester.pumpAndSettle();

      // Tap "+ Add" on chicken breast
      await tester.tap(find.byWidgetPredicate(
        (widget) => widget is ElevatedButton && widget.onPressed != null,
      ));
      await tester.pumpAndSettle();

      // Assert - Food added and totals updated
      expect(find.byType(ProgressBar), findsWidgets);
      expect(find.text('330'), findsOneWidget); // 330 calories
    });
  });
}
```

---

## Test Coverage Targets

| Component | Target Coverage | Files |
|-----------|-----------------|-------|
| Services | 90% | workout_service_test.dart, nutrition_service_test.dart, program_service_test.dart |
| Providers | 85% | auth_provider_test.dart, workout_provider_test.dart, nutrition_provider_test.dart |
| Models | 95% | user_model_test.dart, set_model_test.dart, meal_model_test.dart |
| Screens | 80% | workout_days_screen_test.dart, exercise_details_screen_test.dart, food_logger_screen_test.dart |
| Utilities | 90% | macro_calculations_test.dart, date_formatting_test.dart, validation_test.dart |
| **Overall** | **80%** | |

---

## CI/CD Test Configuration

### GitHub Actions Workflow (`.github/workflows/test.yml`)

```yaml
name: Tests

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.x'
      
      - run: flutter pub get
      
      - run: flutter analyze
        name: Analyze
      
      - run: flutter test --coverage
        name: Unit & Widget Tests
      
      - run: flutter test integration_test
        name: Integration Tests
      
      - uses: codecov/codecov-action@v2
        with:
          files: ./coverage/lcov.info
```

---

## Running Tests Locally

### All Tests
```bash
flutter test
```

### Specific Test File
```bash
flutter test test/services/workout_service_test.dart
```

### With Coverage
```bash
flutter test --coverage
```

### Watch Mode
```bash
flutter test --watch
```

### Integration Tests Only
```bash
flutter test integration_test
```

---

## Mocking Strategy

### Mocking Database

```dart
class MockDatabase extends Mock implements AppDatabase {
  @override
  Future<void> insert(String table, Map<String, dynamic> values) async {
    // Mock implementation
  }

  @override
  Future<List<Map<String, dynamic>>> select(String query) async {
    return [];
  }
}
```

### Mocking Providers (Riverpod)

```dart
final mockProgramProvider = StateNotifierProvider<ProgramNotifier, ProgramState>((ref) {
  return ProgramNotifier(mockDatabase);
});

// Override in test:
testWidgets('test', (WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        programProvider.overrideWithValue(
          AsyncValue.data(testProgram),
        ),
      ],
      child: const MyApp(),
    ),
  );
});
```

---

## Test Data Fixtures

### Reusable Test Data

```dart
// test/fixtures/test_data.dart

final testUser = User(
  userId: 'test_user',
  email: 'test@example.com',
  name: 'Test User',
  isAuthenticated: true,
  createdAt: DateTime(2025, 1, 30),
  updatedAt: DateTime(2025, 1, 30),
);

final testProgram = Program(
  programId: 'test_program',
  userId: 'test_user',
  name: 'Test Program',
  days: [testDay1, testDay2],
  isActive: true,
  createdAt: DateTime(2025, 1, 30),
  updatedAt: DateTime(2025, 1, 30),
);

final testDay1 = Day(
  dayId: 'day_1',
  programId: 'test_program',
  dayNumber: 1,
  dayName: 'Push',
  exercises: [testExercise1],
  createdAt: DateTime(2025, 1, 30),
  updatedAt: DateTime(2025, 1, 30),
);

final testExercise1 = Exercise(
  exerciseId: 'bench_press',
  name: 'Bench Press',
  muscleGroups: ['Chest', 'Triceps'],
  isCompound: true,
  isUserCustom: false,
  createdAt: DateTime(2025, 1, 30),
);

final testSet1 = Set(
  setId: 'set_1',
  exerciseId: 'bench_press',
  dayId: 'day_1',
  reps: 8,
  weightKg: 185.0,
  timestamp: DateTime(2025, 1, 30, 14, 30),
);
```

---

## Performance Testing

### Widget Test Performance

```dart
testWidgets('FoodLoggerScreen renders large meal list efficiently', (WidgetTester tester) async {
  // Arrange: 1000 meals
  final meals = List.generate(1000, (i) => Meal(
    mealId: 'meal_$i',
    userId: 'test_user',
    foods: [],
    totalCalories: 500,
    totalProteinG: 50,
    totalCarbsG: 50,
    totalFatG: 15,
    createdAt: DateTime.now(),
  ));

  // Act & Assert
  final stopwatch = Stopwatch()..start();
  
  await tester.pumpWidget(const MyApp());
  await tester.pumpAndSettle();

  stopwatch.stop();
  
  // Should render within 500ms
  expect(stopwatch.elapsedMilliseconds, lessThan(500));
});
```

---

## Flakiness Detection & Retry

### Retry Flaky Tests

```dart
testWidgets('flaky async operation', (WidgetTester tester) async {
  // Add retry logic at the test level (via test runner config)
  // Or use flutter_test's built-in timeout management
}, timeout: Timeout(Duration(seconds: 30)));
```

---

## Phase 2 Test Additions

When Phase 2 adds backend:
- Add HTTP mocking (mockito, http_mock)
- Add sync queue testing
- Add conflict resolution testing
- Add auth token refresh testing
- Add API error handling testing

