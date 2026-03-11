import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/models.dart';

void main() {
  group('User', () {
    test('fromJson round-trips correctly', () {
      final now = DateTime.utc(2026, 1, 1);
      final user = User(
        userId: 'u1',
        email: 'test@example.com',
        name: 'Test User',
        isAuthenticated: true,
        createdAt: now,
        updatedAt: now,
      );
      final json = user.toJson();
      final restored = User.fromJson(json);
      expect(restored, equals(user));
      expect(restored.email, 'test@example.com');
      expect(restored.name, 'Test User');
    });
  });

  group('WorkoutSet', () {
    test('fromJson handles all fields including nullable repsInReserve', () {
      final ts = DateTime.utc(2026, 3, 1);
      final set1 = WorkoutSet(
        setId: 's1',
        exerciseId: 'e1',
        dayId: 'd1',
        reps: 10,
        weightKg: 80.0,
        repsInReserve: 2,
        tempoVariation: 'normal',
        notes: 'Good form',
        timestamp: ts,
      );
      final json = set1.toJson();
      final restored = WorkoutSet.fromJson(json);
      expect(restored, equals(set1));
      expect(restored.repsInReserve, 2);

      // Test with null repsInReserve
      final set2 = WorkoutSet(
        setId: 's2',
        exerciseId: 'e1',
        dayId: 'd1',
        reps: 8,
        weightKg: 60.0,
        timestamp: ts,
      );
      final json2 = set2.toJson();
      final restored2 = WorkoutSet.fromJson(json2);
      expect(restored2.repsInReserve, isNull);
    });
  });

  group('MealFood', () {
    test('calories computed getter calculates correctly', () {
      final food = Food(
        foodId: 'f1',
        name: 'Chicken Breast',
        caloriesPer100g: 165.0,
        proteinGPer100g: 31.0,
        carbsGPer100g: 0.0,
        fatGPer100g: 3.6,
        createdAt: DateTime.utc(2026, 1, 1),
      );
      final mealFood = MealFood(
        mealFoodId: 'mf1',
        mealId: 'm1',
        food: food,
        quantityGrams: 200.0,
        createdAt: DateTime.utc(2026, 1, 1),
      );
      expect(mealFood.calories, closeTo(330.0, 0.01));
      expect(mealFood.proteinG, closeTo(62.0, 0.01));
      expect(mealFood.carbsG, closeTo(0.0, 0.01));
      expect(mealFood.fatG, closeTo(7.2, 0.01));
    });
  });

  group('AuthState', () {
    test('initial() has isAuthenticated == false', () {
      final state = AuthState.initial();
      expect(state.isAuthenticated, false);
      expect(state.user, isNull);
      expect(state.isLoading, false);
    });
  });

  group('NutritionState', () {
    test('initial() uses defaultDailyGoal with 2000 calories', () {
      final state = NutritionState.initial();
      expect(state.dailyGoal.dailyCalories, 2000);
      expect(state.dailyGoal.dailyProteinG, 150);
      expect(state.dailyGoal.dailyCarbsG, 200);
      expect(state.dailyGoal.dailyFatG, 65);
      expect(state.dailyGoal.dailyFiberG, 30);
      expect(state.meals, isEmpty);
    });
  });

  group('Program', () {
    test('copyWith returns new instance with updated name', () {
      final now = DateTime.utc(2026, 1, 1);
      final program = Program(
        programId: 'p1',
        userId: 'u1',
        name: 'Old Name',
        days: const [],
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );
      final updated = program.copyWith(name: 'New Name');
      expect(updated.name, 'New Name');
      expect(updated.programId, 'p1');
      expect(updated, isNot(equals(program)));
    });
  });

  group('Enums', () {
    test('MuscleGroup.chest.displayName == Chest', () {
      expect(MuscleGroup.chest.displayName, 'Chest');
      expect(MuscleGroup.back.displayName, 'Back');
      expect(MuscleGroup.core.displayName, 'Core');
    });

    test('Equipment.barbell.name == barbell', () {
      expect(Equipment.barbell.name, 'barbell');
      expect(Equipment.resistanceBand.displayName, 'Resistance Band');
    });
  });
}
