# DATA_MODEL.md — Chrug MVP Phase 1

## Overview

This document specifies all Dart model classes, their properties, serialization (JSON), validation logic, and type definitions used throughout Chrug MVP Phase 1.

**Serialization Approach:** json_serializable (code generation via `build_runner`)

**Validation:** No server-side validation in Phase 1 (frontend accepts any input). Phase 2 adds validation at service layer.

---

## Core Models

### User Model

```dart
@freezed
class User with _$User {
  const factory User({
    required String userId,
    required String email,
    String? name,
    double? heightCm,
    double? weightKg,
    String? birthDate, // ISO 8601: "1990-01-15"
    String? gender, // "Male", "Female", "Other", "Prefer not to say"
    String? profilePicturePath,
    required bool isAuthenticated,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

// Freezed annotations for immutability + code generation
// Generates: .copyWith(), .toJson(), .fromJson(), equality
```

**Notes:**
- `userId`: Generated locally (UUID or hardcoded "local_user" in Phase 1)
- `birthDate`: Stored as ISO string, parsed when needed
- `heightCm`, `weightKg`: Always stored in metric (cm, kg), conversion only at display layer
- `gender`: Stored as string (not enum) for flexibility

### Program Model

```dart
@freezed
class Program with _$Program {
  const factory Program({
    required String programId,
    required String userId,
    required String name,
    String? description,
    required List<Day> days, // Eager loaded days
    required bool isActive,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Program;

  factory Program.fromJson(Map<String, dynamic> json) => _$ProgramFromJson(json);
}

@freezed
class Day with _$Day {
  const factory Day({
    required String dayId,
    required String programId,
    required int dayNumber,
    required String dayName, // "Day 1", "Push", "Monday", etc.
    required List<Exercise> exercises, // Eager loaded
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Day;

  factory Day.fromJson(Map<String, dynamic> json) => _$DayFromJson(json);
}

// Relationship: Program → List<Day> → List<Exercise>
// Loaded from database with joins
```

### Exercise Model

```dart
@freezed
class Exercise with _$Exercise {
  const factory Exercise({
    required String exerciseId,
    required String name,
    String? category, // "Chest", "Back", "Legs", etc.
    String? equipment, // "Barbell", "Dumbbell", "Machine", "Bodyweight"
    String? movementType, // "Compound", "Isolation"
    required List<String> muscleGroups, // ["Chest", "Triceps"]
    required bool isCompound,
    String? imageUrl,
    String? description,
    required bool isUserCustom,
    required DateTime createdAt,
  }) = _Exercise;

  factory Exercise.fromJson(Map<String, dynamic> json) => _$ExerciseFromJson(json);
}

// muscleGroups examples:
// Chest compound: ["Chest", "Triceps", "Front Delt"]
// Chest isolation: ["Chest"]
```

### Set Model

```dart
@freezed
class Set with _$Set {
  const factory Set({
    required String setId,
    required String exerciseId,
    required String dayId,
    required int reps,
    required double weightKg, // Always kg, conversion at display layer
    int? repsInReserve, // 0, 1, 2, 3 (or null if not set)
    String? tempoVariation, // "Normal", "Slow Eccentric", "Paused"
    String? notes,
    required DateTime timestamp,
    @Default(false) bool syncedToBackend,
  }) = _Set;

  factory Set.fromJson(Map<String, dynamic> json) => _$SetFromJson(json);

  // Validation (in service layer, Phase 1 not enforced):
  // - reps > 0
  // - weightKg > 0
  // - timestamp is valid datetime
}

// Example:
// Set(
//   setId: UUID(),
//   exerciseId: "bench_press_1",
//   dayId: "day_1",
//   reps: 8,
//   weightKg: 185.0,
//   repsInReserve: 2,
//   tempoVariation: "Normal",
//   notes: "Felt strong",
//   timestamp: DateTime.now(),
// )
```

### Meal & Food Models

```dart
@freezed
class Meal with _$Meal {
  const factory Meal({
    required String mealId,
    required String userId,
    required String mealDate, // ISO: "2025-01-30"
    String? mealName, // "Breakfast", "Lunch", "Dinner", or auto-generated
    required List<MealFood> foods, // Foods in this meal
    required double totalCalories,
    required double totalProteinG,
    required double totalCarbsG,
    required double totalFatG,
    required DateTime createdAt,
    @Default(false) bool syncedToBackend,
  }) = _Meal;

  factory Meal.fromJson(Map<String, dynamic> json) => _$MealFromJson(json);
}

@freezed
class MealFood with _$MealFood {
  const factory MealFood({
    required String mealFoodId,
    required String mealId,
    required Food food,
    required double quantityGrams,
    required DateTime createdAt,
  }) = _MealFood;

  factory MealFood.fromJson(Map<String, dynamic> json) => _$MealFoodFromJson(json);

  // Calculated properties (not stored, derived on-the-fly):
  double get calories => (food.caloriesPer100g * quantityGrams) / 100;
  double get proteinG => (food.proteinGPer100g * quantityGrams) / 100;
  double get carbsG => (food.carbsGPer100g * quantityGrams) / 100;
  double get fatG => (food.fatGPer100g * quantityGrams) / 100;
}

@freezed
class Food with _$Food {
  const factory Food({
    required String foodId,
    required String name,
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
    required bool isUserCustom,
    String? userId, // Only set if user custom
    required DateTime createdAt,
  }) = _Food;

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}

// Example:
// Food(
//   foodId: "chicken_breast_cooked",
//   name: "Chicken Breast (Cooked)",
//   caloriesPer100g: 165,
//   proteinGPer100g: 31,
//   carbsGPer100g: 0,
//   fatGPer100g: 3.6,
//   isUserCustom: false,
// )
//
// MealFood(
//   mealFoodId: UUID(),
//   mealId: "meal_1",
//   food: chickenBreast,
//   quantityGrams: 200,
// )
//
// Calculated:
// - calories: (165 * 200) / 100 = 330
// - protein: (31 * 200) / 100 = 62g
```

### Daily Goal & Totals Models

```dart
@freezed
class DailyGoal with _$DailyGoal {
  const factory DailyGoal({
    required double dailyCalories,
    required double dailyProteinG,
    required double dailyCarbsG,
    required double dailyFatG,
    required double dailyFiberG, // Optional
  }) = _DailyGoal;

  factory DailyGoal.fromJson(Map<String, dynamic> json) => _$DailyGoalFromJson(json);
}

// Default goals (can be customized in Phase 2):
const defaultDailyGoal = DailyGoal(
  dailyCalories: 2000,
  dailyProteinG: 150,
  dailyCarbsG: 200,
  dailyFatG: 65,
  dailyFiberG: 30,
);

@freezed
class DailyTotals with _$DailyTotals {
  const factory DailyTotals({
    required double totalCalories,
    required double totalProteinG,
    required double totalCarbsG,
    required double totalFatG,
    required double totalFiberG,
  }) = _DailyTotals;

  factory DailyTotals.fromJson(Map<String, dynamic> json) => _$DailyTotalsFromJson(json);

  // Derived property:
  int get remainingCalories => (2000 - totalCalories).toInt();
}
```

### Measurement Model

```dart
@freezed
class Measurement with _$Measurement {
  const factory Measurement({
    required String measurementId,
    required String userId,
    required String measurementDate, // ISO: "2025-01-27"
    double? neckCm,
    double? shouldersCm,
    double? chestCm,
    double? bicepsLCm,
    double? bicepsRCm,
    double? forearmsLCm,
    double? forearmsRCm,
    double? waistCm,
    double? hipsCm,
    double? thighsLCm,
    double? thighsRCm,
    double? calvesLCm,
    double? calvesRCm,
    required DateTime createdAt,
  }) = _Measurement;

  factory Measurement.fromJson(Map<String, dynamic> json) => _$MeasurementFromJson(json);

  // All fields in cm (metric standard)
  // Display layer converts to inches if needed
}
```

### Upload Model

```dart
@freezed
class Upload with _$Upload {
  const factory Upload({
    required String uploadId,
    required String userId,
    required String fileName,
    required String fileType, // "image/jpeg", "application/pdf"
    required String filePath, // Local file path or URL
    required String uploadDate, // ISO: "2025-01-30"
    required DateTime createdAt,
  }) = _Upload;

  factory Upload.fromJson(Map<String, dynamic> json) => _$UploadFromJson(json);
}

// Examples:
// - fileName: "Bloodwork_Report.pdf", fileType: "application/pdf"
// - fileName: "Progress_Photo.jpg", fileType: "image/jpeg"
```

### AI Coach Models

```dart
@freezed
class Chat with _$Chat {
  const factory Chat({
    required String chatId,
    required String userId,
    required String title, // "Should I deload?" (from first message)
    required List<Message> messages, // Full conversation
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    required String messageId,
    required String chatId,
    required String role, // "user" or "assistant"
    required String content,
    String? fileUrl, // Optional: image, document, etc.
    required DateTime timestamp,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
}

// Example:
// Chat(
//   chatId: UUID(),
//   userId: "local_user",
//   title: "Should I deload?",
//   messages: [
//     Message(
//       messageId: UUID(),
//       chatId: chatId,
//       role: "user",
//       content: "Should I deload?",
//       timestamp: DateTime.now(),
//     ),
//     Message(
//       messageId: UUID(),
//       chatId: chatId,
//       role: "assistant",
//       content: "Based on your training history, consider a deload...",
//       timestamp: DateTime.now(),
//     ),
//   ],
// )
```

### Integration Model

```dart
@freezed
class Integration with _$Integration {
  const factory Integration({
    required String integrationId,
    required String userId,
    required String integrationName, // "apple_health", "whoop", "oura", etc.
    required bool isConnected,
    String? lastSyncedAt, // ISO datetime
    String? syncError, // Error message if sync failed
  }) = _Integration;

  factory Integration.fromJson(Map<String, dynamic> json) => _$IntegrationFromJson(json);
}

// Supported integrations:
// - "apple_health" (iOS) / "health_connect" (Android)
// - "whoop"
// - "withings"
// - "oura"
// - "garmin"
// - "fitbit"
```

---

## Enums & Constants

### Movement Type Enum

```dart
enum MovementType {
  compound('Compound'),
  isolation('Isolation');

  final String displayName;
  const MovementType(this.displayName);

  String toJson() => name;
  static MovementType fromJson(String json) => values.byName(json);
}
```

### Muscle Group Enum

```dart
enum MuscleGroup {
  chest('Chest'),
  back('Back'),
  shoulders('Shoulders'),
  biceps('Biceps'),
  triceps('Triceps'),
  forearms('Forearms'),
  legs('Legs'),
  quads('Quads'),
  hamstring('Hamstring'),
  glutes('Glutes'),
  calves('Calves'),
  core('Core'),
  ;

  final String displayName;
  const MuscleGroup(this.displayName);

  String toJson() => name;
  static MuscleGroup fromJson(String json) => values.byName(json);
}
```

### Equipment Type Enum

```dart
enum Equipment {
  barbell('Barbell'),
  dumbbell('Dumbbell'),
  machine('Machine'),
  cable('Cable'),
  bodyweight('Bodyweight'),
  kettlebell('Kettlebell'),
  resistanceBand('Resistance Band'),
  ;

  final String displayName;
  const Equipment(this.displayName);

  String toJson() => name;
  static Equipment fromJson(String json) => values.byName(json);
}
```

### RIR (Reps in Reserve) Enum

```dart
enum RIR {
  zero(0, 'All out'),
  one(1, '1 rep left'),
  two(2, '2 reps left'),
  three(3, '3+ reps left'),
  ;

  final int value;
  final String displayName;
  const RIR(this.value, this.displayName);

  String toJson() => value.toString();
  static RIR fromJson(String json) => RIR.values.firstWhere((e) => e.value.toString() == json);
}
```

### Tempo Variation Enum

```dart
enum TempoVariation {
  normal('Normal'),
  slowEccentric('Slow Eccentric'),
  paused('Paused'),
  ;

  final String displayName;
  const TempoVariation(this.displayName);

  String toJson() => name;
  static TempoVariation fromJson(String json) => values.byName(json);
}
```

### Gender Enum

```dart
enum Gender {
  male('Male'),
  female('Female'),
  other('Other'),
  preferNotToSay('Prefer not to say'),
  ;

  final String displayName;
  const Gender(this.displayName);

  String toJson() => name;
  static Gender fromJson(String json) => values.byName(json);
}
```

---

## State Models (for Riverpod)

### Auth State

```dart
@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    required bool isAuthenticated,
    User? user,
    String? authToken,
    String? error,
    @Default(false) bool isLoading,
  }) = _AuthState;

  factory AuthState.initial() => const AuthState(isAuthenticated: false);

  factory AuthState.fromJson(Map<String, dynamic> json) => _$AuthStateFromJson(json);
}
```

### Workout State

```dart
@freezed
class WorkoutState with _$WorkoutState {
  const factory WorkoutState({
    String? selectedDayId,
    required List<Exercise> currentDayExercises,
    required List<Set> loggedSets,
    @Default(false) bool restTimerActive,
    @Default(180) int selectedRestTimeSeconds,
    @Default(false) bool isLoading,
    String? error,
  }) = _WorkoutState;

  factory WorkoutState.initial() => const WorkoutState(
    currentDayExercises: [],
    loggedSets: [],
  );

  factory WorkoutState.fromJson(Map<String, dynamic> json) => _$WorkoutStateFromJson(json);
}
```

### Nutrition State

```dart
@freezed
class NutritionState with _$NutritionState {
  const factory NutritionState({
    required String selectedDate, // ISO: "2025-01-30"
    required List<Meal> meals,
    required DailyGoal dailyGoal,
    required DailyTotals dailyTotals,
    @Default(false) bool isLoading,
    String? error,
  }) = _NutritionState;

  factory NutritionState.initial() => NutritionState(
    selectedDate: DateTime.now().toIso8601String().split('T')[0],
    meals: [],
    dailyGoal: defaultDailyGoal,
    dailyTotals: const DailyTotals(
      totalCalories: 0,
      totalProteinG: 0,
      totalCarbsG: 0,
      totalFatG: 0,
      totalFiberG: 0,
    ),
  );

  factory NutritionState.fromJson(Map<String, dynamic> json) => _$NutritionStateFromJson(json);
}
```

### AI Coach State

```dart
@freezed
class AiCoachState with _$AiCoachState {
  const factory AiCoachState({
    required List<Message> messages,
    required List<Chat> chats,
    String? currentChatId,
    @Default(false) bool isLoading,
    String? error,
  }) = _AiCoachState;

  factory AiCoachState.initial() => const AiCoachState(
    messages: [],
    chats: [],
  );

  factory AiCoachState.fromJson(Map<String, dynamic> json) => _$AiCoachStateFromJson(json);
}
```

### Program State

```dart
@freezed
class ProgramState with _$ProgramState {
  const factory ProgramState({
    required List<Program> programs,
    String? selectedProgramId,
    Program? currentProgram,
    @Default(false) bool isLoading,
    String? error,
  }) = _ProgramState;

  factory ProgramState.initial() => const ProgramState(programs: []);

  factory ProgramState.fromJson(Map<String, dynamic> json) => _$ProgramStateFromJson(json);
}
```

---

## Type Aliases

```dart
/// Date in ISO 8601 format: "2025-01-30"
typedef IsoDateString = String;

/// Time in HH:MM:SS format: "14:30:45"
typedef TimeString = String;

/// Unique identifier (UUID v4)
typedef UUID = String;

/// Unique user ID
typedef UserId = String;

/// Unique program ID
typedef ProgramId = String;

/// Unique day ID
typedef DayId = String;

/// Unique exercise ID
typedef ExerciseId = String;

/// Unique set ID
typedef SetId = String;

/// Unique meal ID
typedef MealId = String;

/// Unique food ID
typedef FoodId = String;

/// Unique chat ID
typedef ChatId = String;

/// Unique message ID
typedef MessageId = String;

/// Numeric value in kilograms
typedef WeightInKg = double;

/// Numeric value in centimeters
typedef HeightInCm = double;

/// Number of repetitions
typedef Reps = int;

/// Time in seconds
typedef Seconds = int;

/// Calorie amount
typedef Calories = double;

/// Gram amount (macros)
typedef Grams = double;
```

---

## Serialization Examples

### User Serialization

**Dart:**
```dart
final user = User(
  userId: 'user_123',
  email: 'jimmy@gmail.com',
  name: 'Jimmy Chen',
  heightCm: 178,
  weightKg: 85,
  birthDate: '1990-01-15',
  gender: 'Male',
  isAuthenticated: true,
  createdAt: DateTime(2025, 1, 30),
  updatedAt: DateTime(2025, 1, 30),
);

// Serialize to JSON:
final json = user.toJson();
// {
//   "userId": "user_123",
//   "email": "jimmy@gmail.com",
//   "name": "Jimmy Chen",
//   "heightCm": 178.0,
//   "weightKg": 85.0,
//   "birthDate": "1990-01-15",
//   "gender": "Male",
//   "isAuthenticated": true,
//   "createdAt": "2025-01-30T00:00:00.000Z",
//   "updatedAt": "2025-01-30T00:00:00.000Z"
// }

// Deserialize from JSON:
final userFromJson = User.fromJson(json);
```

### Set Serialization

**Dart:**
```dart
final set = Set(
  setId: 'set_abc123',
  exerciseId: 'bench_press_1',
  dayId: 'day_1',
  reps: 8,
  weightKg: 185.0,
  repsInReserve: 2,
  tempoVariation: 'Normal',
  notes: 'Felt strong',
  timestamp: DateTime(2025, 1, 30, 14, 30, 0),
  syncedToBackend: false,
);

// JSON:
// {
//   "setId": "set_abc123",
//   "exerciseId": "bench_press_1",
//   "dayId": "day_1",
//   "reps": 8,
//   "weightKg": 185.0,
//   "repsInReserve": 2,
//   "tempoVariation": "Normal",
//   "notes": "Felt strong",
//   "timestamp": "2025-01-30T14:30:00.000Z",
//   "syncedToBackend": false
// }
```

### Meal with Foods Serialization

**Dart:**
```dart
final meal = Meal(
  mealId: 'meal_xyz',
  userId: 'local_user',
  mealDate: '2025-01-30',
  mealName: 'Breakfast',
  foods: [
    MealFood(
      mealFoodId: 'mf_1',
      mealId: 'meal_xyz',
      food: Food(
        foodId: 'chicken_breast',
        name: 'Chicken Breast (Cooked)',
        caloriesPer100g: 165,
        proteinGPer100g: 31,
        carbsGPer100g: 0,
        fatGPer100g: 3.6,
        isUserCustom: false,
        createdAt: DateTime(2025, 1, 1),
      ),
      quantityGrams: 200,
      createdAt: DateTime(2025, 1, 30, 7, 30),
    ),
  ],
  totalCalories: 330,
  totalProteinG: 62,
  totalCarbsG: 0,
  totalFatG: 7.2,
  createdAt: DateTime(2025, 1, 30),
);

// JSON structure:
// {
//   "mealId": "meal_xyz",
//   "userId": "local_user",
//   "mealDate": "2025-01-30",
//   "mealName": "Breakfast",
//   "foods": [
//     {
//       "mealFoodId": "mf_1",
//       "mealId": "meal_xyz",
//       "food": {
//         "foodId": "chicken_breast",
//         "name": "Chicken Breast (Cooked)",
//         "caloriesPer100g": 165.0,
//         "proteinGPer100g": 31.0,
//         "carbsGPer100g": 0.0,
//         "fatGPer100g": 3.6,
//         "isUserCustom": false,
//         "createdAt": "2025-01-01T00:00:00.000Z"
//       },
//       "quantityGrams": 200.0,
//       "createdAt": "2025-01-30T07:30:00.000Z"
//     }
//   ],
//   "totalCalories": 330.0,
//   "totalProteinG": 62.0,
//   "totalCarbsG": 0.0,
//   "totalFatG": 7.2,
//   "createdAt": "2025-01-30T00:00:00.000Z",
//   "syncedToBackend": false
// }
```

---

## Null Safety & Defaults

### Nullable vs Non-Nullable

**Non-nullable (required):**
- `userId`, `email`, `name`, `reps`, `weightKg`, `calories`
- These fields MUST have a value

**Nullable (optional):**
- `description`, `notes`, `birthDate`, `profilePicturePath`
- These fields may be null

### Default Values

```dart
// Use @Default() annotation from Freezed:
@freezed
class Set with _$Set {
  const factory Set({
    // ... required fields
    @Default(false) bool syncedToBackend,
    @Default(0) int repsInReserve,
  }) = _Set;
}
```

---

## Validation Rules (Phase 1)

**Phase 1:** No validation enforced (all input accepted)

**Phase 2:** Validation added at service layer:

```dart
class SetValidation {
  static String? validateReps(int reps) {
    if (reps <= 0) return 'Reps must be > 0';
    if (reps > 999) return 'Reps too high';
    return null;
  }

  static String? validateWeight(double weight) {
    if (weight <= 0) return 'Weight must be > 0';
    return null;
  }
}
```

---

## Model Relationships (ER Diagram)

```
User
├── 1:N → Programs
│         ├── 1:N → Days
│                  ├── N:M → Exercises (via day_exercises)
│                  └── 1:N → Sets
├── 1:N → Meals
│         └── N:M → Foods (via meal_foods)
├── 1:N → Measurements
├── 1:N → Uploads
├── 1:N → Chats
│         └── 1:N → Messages
└── 1:N → Integrations
```

---

## JSON Parsing Best Practices

### Safe Parsing

```dart
// DO: Use fromJson with error handling
try {
  final user = User.fromJson(jsonData);
} on FormatException catch (e) {
  debugPrint('JSON format error: $e');
}

// DON'T: Assume JSON structure
// ❌ final name = jsonData['name']; // May be null/missing
// ✅ final user = User.fromJson(jsonData); // Type-safe
```

### Batch Operations

```dart
// Efficient: Parse list of items
List<Set> setsFromJson(List<dynamic> jsonList) {
  return jsonList.map((json) => Set.fromJson(json as Map<String, dynamic>)).toList();
}

// Usage:
final sets = setsFromJson(jsonResponse);
```

---

## Phase 2 Extensions

**No model changes needed for Phase 2**, but these fields will be populated:

- `Set.syncedToBackend` (boolean, toggled after sync)
- `Meal.syncedToBackend` (boolean, toggled after sync)
- `User.authToken` (string, from Supabase)
- `Integration.lastSyncedAt` (datetime, from wearable sync)
- `Chat.messages` (populated from backend history)

All models remain backward-compatible with Phase 1 data.

