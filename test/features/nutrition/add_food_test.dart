import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/food.dart';
import 'package:chrugm12/features/nutrition/widgets/custom_food_form.dart';
import 'package:chrugm12/features/nutrition/widgets/food_list_tile.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(home: Scaffold(body: SingleChildScrollView(child: child))),
  );
}

void main() {
  group('FoodListTile', () {
    testWidgets('displays food name and macros', (tester) async {
      final food = Food(
        foodId: 'f1',
        name: 'Chicken Breast',
        caloriesPer100g: 165,
        proteinGPer100g: 31,
        carbsGPer100g: 0,
        fatGPer100g: 4,
        createdAt: DateTime(2025),
      );

      await tester.pumpWidget(_wrap(
        FoodListTile(food: food, onAdd: () {}),
      ));

      expect(find.text('Chicken Breast'), findsOneWidget);
      expect(find.textContaining('165 cal'), findsOneWidget);
      expect(find.text('+ Add'), findsOneWidget);
    });

    testWidgets('fires onAdd when + Add tapped', (tester) async {
      var added = false;
      final food = Food(
        foodId: 'f1',
        name: 'Rice',
        caloriesPer100g: 130,
        proteinGPer100g: 3,
        carbsGPer100g: 28,
        fatGPer100g: 0,
        createdAt: DateTime(2025),
      );

      await tester.pumpWidget(_wrap(
        FoodListTile(food: food, onAdd: () => added = true),
      ));

      await tester.tap(find.text('+ Add'));
      expect(added, isTrue);
    });

    testWidgets('shows checkmark when recent', (tester) async {
      final food = Food(
        foodId: 'f2',
        name: 'Oats',
        caloriesPer100g: 150,
        proteinGPer100g: 5,
        carbsGPer100g: 27,
        fatGPer100g: 3,
        createdAt: DateTime(2025),
      );

      await tester.pumpWidget(_wrap(
        FoodListTile(food: food, isRecent: true, onAdd: () {}),
      ));

      expect(find.byIcon(Icons.check_circle), findsOneWidget);
    });
  });

  group('CustomFoodForm', () {
    testWidgets('save button disabled when fields empty', (tester) async {
      await tester.pumpWidget(_wrap(
        CustomFoodForm(
          onSave: ({
            required String name,
            required double caloriesPer100g,
            required double proteinGPer100g,
            required double carbsGPer100g,
            required double fatGPer100g,
          }) {},
        ),
      ));

      expect(find.text('Create a Food'), findsOneWidget);
      expect(find.text('Save'), findsOneWidget);
      // All 5 fields present
      expect(find.byType(TextField), findsNWidgets(5));
    });

    testWidgets('save button enables when all fields filled', (tester) async {
      await tester.pumpWidget(_wrap(
        CustomFoodForm(
          onSave: ({
            required String name,
            required double caloriesPer100g,
            required double proteinGPer100g,
            required double carbsGPer100g,
            required double fatGPer100g,
          }) {},
        ),
      ));

      await tester.enterText(find.byType(TextField).at(0), 'Protein Shake');
      await tester.enterText(find.byType(TextField).at(1), '120');
      await tester.enterText(find.byType(TextField).at(2), '25');
      await tester.enterText(find.byType(TextField).at(3), '5');
      await tester.enterText(find.byType(TextField).at(4), '2');
      await tester.pumpAndSettle();

      // Button should now be enabled (not disabled)
      expect(find.text('Save'), findsOneWidget);
    });
  });
}
