import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/daily_goal.dart';
import 'package:chrugm12/data/models/food.dart';
import 'package:chrugm12/data/models/meal.dart';
import 'package:chrugm12/data/models/meal_food.dart';
import 'package:chrugm12/features/nutrition/widgets/calorie_progress_ring.dart';
import 'package:chrugm12/features/nutrition/widgets/macro_summary_bar.dart';
import 'package:chrugm12/features/nutrition/widgets/meal_card.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('CalorieProgressRing', () {
    testWidgets('displays goal, remaining, and eaten values', (tester) async {
      await tester.pumpWidget(_wrap(
        const CalorieProgressRing(
          goalCalories: 2000,
          eatenCalories: 1409,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('2000'), findsOneWidget);
      expect(find.text('Goal'), findsOneWidget);
      expect(find.text('591'), findsOneWidget);
      expect(find.text('Remaining'), findsOneWidget);
      expect(find.text('1409'), findsOneWidget);
      expect(find.text('Eaten'), findsOneWidget);
    });

    testWidgets('shows "Over" when eaten exceeds goal', (tester) async {
      await tester.pumpWidget(_wrap(
        const CalorieProgressRing(
          goalCalories: 2000,
          eatenCalories: 2200,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('200'), findsOneWidget);
      expect(find.text('Over'), findsOneWidget);
    });
  });

  group('MacroSummaryBar', () {
    testWidgets('renders 4 macro bars with labels', (tester) async {
      await tester.pumpWidget(_wrap(
        const MacroSummaryBar(
          proteinConsumed: 80,
          proteinTarget: 150,
          carbsConsumed: 120,
          carbsTarget: 200,
          fatConsumed: 30,
          fatTarget: 65,
          fiberConsumed: 10,
          fiberTarget: 30,
        ),
      ));

      expect(find.text('Protein'), findsOneWidget);
      expect(find.text('Carbs'), findsOneWidget);
      expect(find.text('Fat'), findsOneWidget);
      expect(find.text('Fiber'), findsOneWidget);
      expect(find.text('80/150g'), findsOneWidget);
      expect(find.text('120/200g'), findsOneWidget);
      expect(find.text('30/65g'), findsOneWidget);
      expect(find.text('10/30g'), findsOneWidget);
    });
  });

  group('MealCard', () {
    testWidgets('renders meal name, foods, and calories', (tester) async {
      final meal = Meal(
        mealId: 'm1',
        userId: 'u1',
        mealDate: '2025-01-15',
        mealName: 'Breakfast',
        foods: [
          MealFood(
            mealFoodId: 'mf1',
            mealId: 'm1',
            food: Food(
              foodId: 'f1',
              name: 'Oatmeal',
              caloriesPer100g: 150,
              proteinGPer100g: 5,
              carbsGPer100g: 27,
              fatGPer100g: 3,
              createdAt: DateTime(2025),
            ),
            quantityGrams: 200,
            createdAt: DateTime(2025, 1, 15, 8, 0),
          ),
          MealFood(
            mealFoodId: 'mf2',
            mealId: 'm1',
            food: Food(
              foodId: 'f2',
              name: 'Boiled Egg',
              caloriesPer100g: 155,
              proteinGPer100g: 13,
              carbsGPer100g: 1,
              fatGPer100g: 11,
              createdAt: DateTime(2025),
            ),
            quantityGrams: 100,
            createdAt: DateTime(2025, 1, 15, 8, 0),
          ),
        ],
        totalCalories: 455,
        totalProteinG: 23,
        totalCarbsG: 55,
        totalFatG: 17,
        createdAt: DateTime(2025, 1, 15, 8, 0),
      );

      await tester.pumpWidget(_wrap(MealCard(meal: meal)));

      expect(find.text('Breakfast'), findsOneWidget);
      expect(find.text('Oatmeal'), findsOneWidget);
      expect(find.text('Boiled Egg'), findsOneWidget);
      expect(find.text('300 cal'), findsOneWidget);
      expect(find.text('155 cal'), findsOneWidget);
      expect(find.textContaining('455 cal'), findsOneWidget);
    });

    testWidgets('shows edit button when onEdit provided', (tester) async {
      final meal = Meal(
        mealId: 'm2',
        userId: 'u1',
        mealDate: '2025-01-15',
        mealName: 'Lunch',
        foods: [],
        totalCalories: 0,
        totalProteinG: 0,
        totalCarbsG: 0,
        totalFatG: 0,
        createdAt: DateTime(2025, 1, 15, 12, 0),
      );

      var editTapped = false;
      await tester.pumpWidget(_wrap(
        MealCard(meal: meal, onEdit: () => editTapped = true),
      ));

      expect(find.text('Edit'), findsOneWidget);
      await tester.tap(find.text('Edit'));
      expect(editTapped, isTrue);
    });
  });
}
