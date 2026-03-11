# SYSTEM_ARCHITECTURE.md — Chrug MVP Phase 1

## Overview

Chrug MVP Phase 1 is a **frontend-only, offline-first** fitness app built on Flutter with local SQLite storage. No backend calls, no API dependencies, no authentication server. Phase 2 adds the backend layer (Supabase + FastAPI + Claude API).

---

## Tech Stack

### Mobile App
- **Framework:** Flutter 3.x (latest stable)
- **Language:** Dart 3.x
- **State Management:** Riverpod 2.x (provider-based, reactive)
  - Alternative considered: Bloc (more boilerplate, but popular)
  - Choice: Riverpod for simplicity and type safety
- **Local Database:** Drift (SQLite wrapper for Dart)
  - Tables: users, programs, days, exercises, sets, meals, foods, measurements, uploads, chats, integrations
- **UI Framework:** Flutter's built-in Material Design + custom widgets
- **Navigation:** go_router (declarative, nested navigation, deep linking support)
  - Alternative: GetX (less explicit, more magic)
  - Choice: go_router for clarity and control
- **HTTP Client:** http package (for Phase 2 API calls, unused in Phase 1)
- **JSON Serialization:** json_serializable (code generation via build_runner)
- **Form Handling:** flutter_form_builder (optional, or hand-rolled)
- **File Handling:** file_picker, image_picker (native iOS/Android integration)
- **Storage:** shared_preferences (user preferences, settings)

### Development Tools
- **IDE:** VS Code or Android Studio
- **CI/CD:** GitHub Actions (Flutter analyze, test, build)
- **Git Workflow:** GitHub (feature branches, PRs required before merge)
- **Package Manager:** pub.dev (Dart package repository)

### Design System
- **Colors:** Custom Flutter Color constants
  - Primary: #001F3F (dark navy)
  - Secondary: #06A77D (teal)
  - Danger: #E63946 (red)
  - Success: #06A77D (green, same as secondary)
  - Background: #F3F2F7 (lavender)
- **Typography:** Custom TextStyle definitions
  - Headings: bold, 18-24pt
  - Body: regular, 14-16pt
  - Labels: small, 12pt, gray
- **Icons:** Flutter Icons (Material Design icons) + custom SVGs (optional)

---

## Architecture Layers

```
┌─────────────────────────────────────────────────────┐
│                    UI Layer (Flutter)               │
│  ┌─────────────────────────────────────────────┐   │
│  │ Screens (Widgets)                           │   │
│  │ - WorkoutDaysScreen                         │   │
│  │ - ExerciseDetailsScreen                     │   │
│  │ - AddSetModalSheet                          │   │
│  │ - FoodLoggerScreen                          │   │
│  │ - AiCoachScreen                             │   │
│  │ - ProfileSidebar, etc.                      │   │
│  └─────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────┐   │
│  │ Custom Widgets & Components                 │   │
│  │ - ExerciseCard, SetHistoryItem              │   │
│  │ - MacroProgressBar, RestTimerPill           │   │
│  │ - BottomTabBar, HeaderBar                   │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────┐
│              State Management (Riverpod)            │
│  ┌─────────────────────────────────────────────┐   │
│  │ Providers                                   │   │
│  │ - authProvider (user state)                 │   │
│  │ - programProvider (current program)         │   │
│  │ - workoutProvider (current workout)         │   │
│  │ - nutritionProvider (daily totals)          │   │
│  │ - aiCoachProvider (chat state)              │   │
│  └─────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────┐   │
│  │ Services (Business Logic)                   │   │
│  │ - ProgramService                            │   │
│  │ - WorkoutService                            │   │
│  │ - NutritionService                          │   │
│  │ - AiCoachService (mock)                     │   │
│  │ - IntegrationService (permissions)          │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
           │
           ▼
┌─────────────────────────────────────────────────────┐
│           Data Layer (Drift + Local Storage)        │
│  ┌─────────────────────────────────────────────┐   │
│  │ SQLite Database (Drift)                     │   │
│  │ - users table                               │   │
│  │ - programs table                            │   │
│  │ - days table                                │   │
│  │ - exercises table                           │   │
│  │ - sets table                                │   │
│  │ - meals table                               │   │
│  │ - foods table                               │   │
│  │ - measurements table                        │   │
│  │ - uploads table                             │   │
│  │ - chats table (AI Coach history)            │   │
│  │ - integrations table (wearable status)      │   │
│  └─────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────┐   │
│  │ SharedPreferences                           │   │
│  │ - User preferences (units, rest time)       │   │
│  │ - App settings (theme, language)            │   │
│  │ - Device tokens (for future push notif)     │   │
│  └─────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────┐   │
│  │ File System                                 │   │
│  │ - Document directory (user data)            │   │
│  │ - Temp directory (scratch files)            │   │
│  │ - App bundle (assets, images, videos)       │   │
│  └─────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────┘
```

---

## Data Flow

### Set Logging Flow (Example)

```
User taps "+ Add Set"
        │
        ▼
AddSetModalSheet opens
(local state: reps=empty, weight=empty)
        │
        ├─ User enters: reps=8, weight=185
        │
        ▼
"Record Set" button enables
        │
        ▼
User taps "Record Set"
        │
        ▼
SetModel created:
  {
    exerciseId: "bench_press_1",
    dayId: "day_1",
    reps: 8,
    weight: 185,
    rir: 2 (if selected),
    tempo: "Normal" (if selected),
    notes: "...",
    timestamp: DateTime.now(),
    syncedToBackend: false
  }
        │
        ▼
WorkoutService.recordSet(set)
        │
        ├─ Insert into local SQLite: sets table
        │
        ├─ Update: workoutProvider (trigger UI refresh)
        │
        ├─ Trigger: RestTimerProvider (start timer)
        │
        └─ Toast: "Set recorded"
        │
        ▼
AddSetModalSheet closes
ExerciseDetailsScreen updates:
  - Set appears in history
  - RestTimerPill appears at bottom
        │
        ▼
User rests while timer counts down
        │
        ▼
User taps "+ Add Set" again
(repeat flow)
```

### Food Logging Flow (Example)

```
User taps "+ Add Food"
        │
        ▼
NavigateTo: AddFoodScreen
        │
        ├─ Load: food database from SQLite (foods table)
        │
        ├─ Load: recently logged foods
        │
        └─ Display: search bar + food list
        │
        ▼
User searches: "chicken"
        │
        ├─ Filter foods list in real-time
        │
        └─ Display: "Chicken Breast", "Rotisserie Chicken", etc.
        │
        ▼
User taps "+ Add" on "Chicken Breast (Cooked)"
        │
        ▼
FoodService.addFoodToMeal(food, selectedDate)
        │
        ├─ Create MealEntry object:
        │   {
        │     mealId: UUID,
        │     userId: "local_user",
        │     date: selectedDate,
        │     foods: [{foodId, quantity, unit}],
        │     totalCalories: 165,
        │     totalProtein: 31,
        │     totalCarbs: 0,
        │     totalFat: 3.6,
        │     timestamp: DateTime.now()
        │   }
        │
        ├─ Insert into local SQLite: meals table
        │
        ├─ Update: nutritionProvider
        │   - Recalculate dailyTotals (sum of all meals)
        │   - Recalculate remainingCalories
        │
        ├─ Update: macro progress bars
        │
        └─ Toast: "Food is added"
        │
        ▼
FoodLoggerScreen updates:
  - Meals list updated with new entry
  - Progress ring recalculated
  - Macro bars updated
        │
        ▼
User returns to AddFoodScreen (or another screen)
        │
        ▼
(Optional) User can continue adding foods
```

### Program Selection Flow (Example)

```
User taps "Change Program" OR "Create New Program"
        │
        ▼
ProgramManagementStack opens (full-screen modal)
        │
        ├─ If "Change Program":
        │  ├─ Load: user's programs from SQLite (programs table)
        │  └─ Display: program cards
        │
        └─ If "Create New Program":
           ├─ Bottom sheet opens
           ├─ User enters: "Push/Pull/Legs"
           └─ User taps "Create"
        │
        ▼
SelectExerciseModal opens
        │
        ├─ Load: exercise database from SQLite (exercises table)
        │
        ├─ Display: search bar + filter bubbles + exercise list
        │
        └─ User searches/filters and selects exercises:
           - Bench Press (selected)
           - Incline Dumbbell Press (selected)
           - Cable Flyes (selected)
        │
        ▼
User taps "Next"
        │
        ▼
ProgramService.createProgram(programName, selectedExercises)
        │
        ├─ Insert into SQLite: programs table
        │   {
        │     programId: UUID,
        │     name: "Push/Pull/Legs",
        │     userId: "local_user",
        │     createdDate: DateTime.now(),
        │     isActive: true
        │   }
        │
        ├─ Insert into SQLite: days table
        │   {
        │     dayId: UUID,
        │     programId: programId,
        │     dayNumber: 1,
        │     dayName: "Day 1",
        │     exercises: [exerciseIds]
        │   }
        │
        ├─ Update: programProvider
        │   - Set selectedProgramId
        │   - Set currentProgram (full program object)
        │
        └─ Toast: "Program created"
        │
        ▼
Modal closes
WorkoutDaysScreen updates:
  - Program name displayed
  - Days list populated with new days
```

---

## State Management Architecture (Riverpod)

### Core Providers

#### **authProvider** (StateNotifier)
```dart
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthState {
  bool isAuthenticated;
  User? user;
  String? authToken;
}

class AuthNotifier extends StateNotifier<AuthState> {
  // Methods:
  // - signupWithEmail(email)
  // - verifyOtp(email, code)
  // - signupWithApple()
  // - logout()
  // - getUser()
}
```

#### **programProvider** (StateNotifier)
```dart
final programProvider = StateNotifierProvider<ProgramNotifier, ProgramState>((ref) {
  return ProgramNotifier(ref.watch(databaseProvider));
});

class ProgramState {
  List<Program> programs;
  String? selectedProgramId;
  Program? currentProgram;
}

class ProgramNotifier extends StateNotifier<ProgramState> {
  // Methods:
  // - createProgram(name, exercises)
  // - selectProgram(programId)
  // - deleteProgram(programId)
  // - listPrograms()
}
```

#### **workoutProvider** (StateNotifier)
```dart
final workoutProvider = StateNotifierProvider<WorkoutNotifier, WorkoutState>((ref) {
  return WorkoutNotifier(ref.watch(databaseProvider));
});

class WorkoutState {
  String? selectedDayId;
  List<Exercise> currentDayExercises;
  List<Set> loggedSets;
  bool restTimerActive;
  int selectedRestTime;
}

class WorkoutNotifier extends StateNotifier<WorkoutState> {
  // Methods:
  // - recordSet(set)
  // - deleteSet(setId)
  // - updateSet(setId, newData)
  // - getExercisesForDay(dayId)
  // - getSetsForExercise(exerciseId)
  // - startRestTimer(durationSeconds)
}
```

#### **nutritionProvider** (StateNotifier)
```dart
final nutritionProvider = StateNotifierProvider<NutritionNotifier, NutritionState>((ref) {
  return NutritionNotifier(ref.watch(databaseProvider));
});

class NutritionState {
  Date selectedDate;
  List<Meal> meals;
  DailyGoal dailyGoal; // calories, protein, carbs, fat
  DailyTotals dailyTotals;
  int remainingCalories;
}

class NutritionNotifier extends StateNotifier<NutritionState> {
  // Methods:
  // - addFoodToMeal(food, date)
  // - deleteMeal(mealId)
  // - updateMeal(mealId, newData)
  // - selectDate(date)
  // - calculateDailyTotals(date)
  // - createCustomFood(name, macros)
}
```

#### **aiCoachProvider** (StateNotifier)
```dart
final aiCoachProvider = StateNotifierProvider<AiCoachNotifier, AiCoachState>((ref) {
  return AiCoachNotifier(ref.watch(databaseProvider));
});

class AiCoachState {
  List<Message> messages;
  List<Chat> chats;
  String? currentChatId;
  bool isLoading;
}

class AiCoachNotifier extends StateNotifier<AiCoachState> {
  // Methods:
  // - sendMessage(text)
  // - createNewChat()
  // - loadChatHistory(chatId)
  // - deleteChat(chatId)
  // - getMockAiResponse(userMessage) // Phase 1: hardcoded responses
}
```

### Database Provider

```dart
final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase(); // Singleton, lazily initialized
});
```

### Computed Providers (Derived State)

```dart
// Remaining calories for current day
final remainingCaloriesProvider = Provider<int>((ref) {
  final nutrition = ref.watch(nutritionProvider);
  return nutrition.dailyGoal.calories - nutrition.dailyTotals.calories;
});

// Total sets logged for current day
final todaysSetCountProvider = Provider<int>((ref) {
  final workout = ref.watch(workoutProvider);
  return workout.loggedSets.length;
});
```

---

## Service Layer

### ProgramService
```dart
class ProgramService {
  final AppDatabase database;

  // Create program with initial day + exercises
  Future<Program> createProgram(
    String name,
    List<Exercise> exercises,
  ) async {
    // Insert program record
    // Insert day record
    // Associate exercises with day
    // Return Program object
  }

  // Select program as active
  Future<void> selectProgram(String programId) async {
    // Update programProvider
    // Load day/exercise data
  }

  // List all user programs
  Future<List<Program>> listPrograms() async {
    // Query programs table
    // For each program, load days + exercises
    // Return list
  }

  // Delete program
  Future<void> deleteProgram(String programId) async {
    // Soft delete (archive) or hard delete?
    // Phase 1: hard delete
  }
}
```

### WorkoutService
```dart
class WorkoutService {
  final AppDatabase database;

  // Record a set
  Future<void> recordSet(Set set) async {
    // Insert into sets table
    // Update workoutProvider
    // Update any derived state
  }

  // Delete a set
  Future<void> deleteSet(String setId) async {
    // Mark as deleted (soft delete) or hard delete?
    // Update UI
  }

  // Get sets for exercise
  Future<List<Set>> getSetsForExercise(String exerciseId) async {
    // Query sets table
    // Filter by exerciseId
    // Order by timestamp (newest first)
    // Return list
  }

  // Start rest timer
  void startRestTimer(int durationSeconds) {
    // Create Timer
    // Update restTimerProvider
    // Tick every second
    // Clean up on completion
  }
}
```

### NutritionService
```dart
class NutritionService {
  final AppDatabase database;

  // Add food to meal for selected date
  Future<void> addFoodToMeal(Food food, Date date) async {
    // Create or get meal for date
    // Add food to meal
    // Recalculate totals
    // Update nutritionProvider
  }

  // Calculate daily totals
  Future<DailyTotals> calculateDailyTotals(Date date) async {
    // Query meals table for date
    // Sum calories, protein, carbs, fat
    // Return totals
  }

  // Create custom food
  Future<void> createCustomFood(String name, Map<String, num> macros) async {
    // Insert into foods table
    // Mark as custom (user_created=true)
    // Update My Foods list
  }
}
```

### AiCoachService (Mock in Phase 1)
```dart
class AiCoachService {
  final AppDatabase database;

  // Send message (mock in Phase 1)
  Future<Message> sendMessage(String userMessage, String chatId) async {
    // Insert user message into chats table
    // Generate mock AI response (hardcoded, based on keywords)
    // Insert AI response into chats table
    // Return AI message
  }

  // Get mock response
  String getMockAiResponse(String userMessage) {
    // Phase 1: hardcoded responses
    if (userMessage.toLowerCase().contains("deload")) {
      return "Based on your training history, consider a deload week...";
    }
    // etc.
  }

  // Create new chat
  Future<Chat> createNewChat() async {
    // Generate new chatId (UUID)
    // Create Chat record
    // Return Chat
  }
}
```

---

## Database Schema (Drift)

### Users Table
```sql
CREATE TABLE users (
  user_id TEXT PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  name TEXT,
  height_cm REAL,
  weight_kg REAL,
  birth_date TEXT,
  gender TEXT,
  profile_picture_path TEXT,
  is_authenticated BOOLEAN,
  created_at TEXT,
  updated_at TEXT
);
```

### Programs Table
```sql
CREATE TABLE programs (
  program_id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  name TEXT NOT NULL,
  description TEXT,
  created_at TEXT,
  updated_at TEXT,
  is_active BOOLEAN,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Days Table
```sql
CREATE TABLE days (
  day_id TEXT PRIMARY KEY,
  program_id TEXT NOT NULL,
  day_number INTEGER,
  day_name TEXT,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(program_id) REFERENCES programs(program_id)
);
```

### Exercises Table
```sql
CREATE TABLE exercises (
  exercise_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT,
  equipment TEXT,
  movement_type TEXT,
  muscle_groups TEXT, -- JSON array: ["chest", "triceps"]
  is_compound BOOLEAN,
  image_url TEXT,
  description TEXT,
  is_user_custom BOOLEAN,
  created_at TEXT
);
```

### Day_Exercise Junction Table
```sql
CREATE TABLE day_exercises (
  id TEXT PRIMARY KEY,
  day_id TEXT NOT NULL,
  exercise_id TEXT NOT NULL,
  exercise_order INTEGER,
  created_at TEXT,
  FOREIGN KEY(day_id) REFERENCES days(day_id),
  FOREIGN KEY(exercise_id) REFERENCES exercises(exercise_id)
);
```

### Sets Table
```sql
CREATE TABLE sets (
  set_id TEXT PRIMARY KEY,
  exercise_id TEXT NOT NULL,
  day_id TEXT NOT NULL,
  reps INTEGER NOT NULL,
  weight_kg REAL NOT NULL,
  reps_in_reserve INTEGER,
  tempo_variation TEXT,
  notes TEXT,
  timestamp TEXT,
  synced_to_backend BOOLEAN DEFAULT FALSE,
  FOREIGN KEY(exercise_id) REFERENCES exercises(exercise_id),
  FOREIGN KEY(day_id) REFERENCES days(day_id)
);
```

### Meals Table
```sql
CREATE TABLE meals (
  meal_id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  meal_date TEXT,
  meal_name TEXT,
  total_calories REAL,
  total_protein_g REAL,
  total_carbs_g REAL,
  total_fat_g REAL,
  created_at TEXT,
  synced_to_backend BOOLEAN DEFAULT FALSE,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Foods Table
```sql
CREATE TABLE foods (
  food_id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  calories_per_100g REAL,
  protein_g_per_100g REAL,
  carbs_g_per_100g REAL,
  fat_g_per_100g REAL,
  is_user_custom BOOLEAN,
  user_id TEXT,
  created_at TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Meal_Food Junction Table
```sql
CREATE TABLE meal_foods (
  id TEXT PRIMARY KEY,
  meal_id TEXT NOT NULL,
  food_id TEXT NOT NULL,
  quantity_grams REAL,
  created_at TEXT,
  FOREIGN KEY(meal_id) REFERENCES meals(meal_id),
  FOREIGN KEY(food_id) REFERENCES foods(food_id)
);
```

### Measurements Table
```sql
CREATE TABLE measurements (
  measurement_id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  measurement_date TEXT,
  neck_cm REAL,
  shoulders_cm REAL,
  chest_cm REAL,
  biceps_l_cm REAL,
  biceps_r_cm REAL,
  forearms_l_cm REAL,
  forearms_r_cm REAL,
  waist_cm REAL,
  hips_cm REAL,
  thighs_l_cm REAL,
  thighs_r_cm REAL,
  calves_l_cm REAL,
  calves_r_cm REAL,
  created_at TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Uploads Table
```sql
CREATE TABLE uploads (
  upload_id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  file_name TEXT,
  file_type TEXT,
  file_path TEXT,
  upload_date TEXT,
  created_at TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Chats Table (AI Coach)
```sql
CREATE TABLE chats (
  chat_id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  title TEXT,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

### Messages Table (AI Coach)
```sql
CREATE TABLE messages (
  message_id TEXT PRIMARY KEY,
  chat_id TEXT NOT NULL,
  role TEXT, -- "user" or "assistant"
  content TEXT,
  file_url TEXT,
  timestamp TEXT,
  FOREIGN KEY(chat_id) REFERENCES chats(chat_id)
);
```

### Integrations Table
```sql
CREATE TABLE integrations (
  integration_id TEXT PRIMARY KEY,
  user_id TEXT NOT NULL,
  integration_name TEXT, -- "apple_health", "whoop", "oura", etc.
  is_connected BOOLEAN DEFAULT FALSE,
  last_synced_at TEXT,
  sync_error TEXT,
  FOREIGN KEY(user_id) REFERENCES users(user_id)
);
```

---

## Navigation Structure (go_router)

### Route Configuration
```dart
final appRoutes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const RootScreen(),
    routes: [
      // Auth routes (conditional)
      GoRoute(
        path: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: 'first-time-user',
        builder: (context, state) => const FirstTimeUserScreen(),
      ),
      GoRoute(
        path: 'signup',
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        path: 'account-verification',
        builder: (context, state) => AccountVerificationScreen(
          email: state.extra as String,
        ),
      ),
      
      // Main routes (conditional)
      GoRoute(
        path: 'workout',
        builder: (context, state) => const WorkoutDaysScreen(),
        routes: [
          GoRoute(
            path: 'day/:dayId',
            builder: (context, state) => WorkoutDayScreen(
              dayId: state.pathParameters['dayId']!,
            ),
            routes: [
              GoRoute(
                path: 'exercise/:exerciseId',
                builder: (context, state) => ExerciseDetailsScreen(
                  exerciseId: state.pathParameters['exerciseId']!,
                  dayId: state.pathParameters['dayId']!,
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: 'nutrition/food-log',
        builder: (context, state) => const FoodLoggerScreen(),
        routes: [
          GoRoute(
            path: 'add-food',
            builder: (context, state) => const AddFoodScreen(),
          ),
        ],
      ),
      GoRoute(
        path: 'ai-coach',
        builder: (context, state) => const AiCoachScreen(),
      ),
      GoRoute(
        path: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: 'profile/uploads',
        builder: (context, state) => const UploadsScreen(),
      ),
      // ... etc. for all screens
    ],
  ),
];
```

---

## Error Handling Strategy

### Try-Catch Pattern
```dart
try {
  await workoutService.recordSet(set);
} on DatabaseException catch (e) {
  // Log error
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Failed to save set: ${e.message}')),
  );
} catch (e) {
  // Unexpected error
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: const Text('An error occurred')),
  );
}
```

### Custom Exceptions
```dart
class DatabaseException implements Exception {
  final String message;
  DatabaseException(this.message);
}

class ValidationException implements Exception {
  final String message;
  ValidationException(this.message);
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}
```

### Logging
```dart
// Use logger package (or custom)
import 'package:logger/logger.dart';

final logger = Logger();

logger.i('User recorded set: ${set.id}');
logger.w('Failed to sync data');
logger.e('Database error', error: exception);
```

---

## Performance Considerations

### List Rendering
- Use `ListView.builder()` for scrollable lists (not ListView with huge item count)
- Implement item caching for exercise list (~5K exercises)
- Lazy-load food database (load on first search, not on screen open)

### Database Queries
- Index frequently queried fields: `set_id`, `exercise_id`, `meal_date`
- Batch inserts where possible (e.g., adding multiple foods to a meal)
- Avoid N+1 queries (e.g., don't query each day's exercises separately)

### State Management
- Use `.select()` in Riverpod to watch only changed fields (not entire state)
- Example: watch only `dailyTotals` from nutritionProvider, not entire state

### Animations
- Keep animations < 300ms for UI responsiveness
- Use `const` constructors where possible
- Profile with Flutter DevTools (performance overlay)

---

## Offline-First Design

### Sync Queue (Phase 2)
```dart
class SyncQueue {
  List<PendingSyncItem> queue = [];
  
  void addToQueue(String entityType, String entityId, String operation) {
    queue.add(PendingSyncItem(
      id: UUID(),
      entityType: entityType,
      entityId: entityId,
      operation: operation, // "create", "update", "delete"
      timestamp: DateTime.now(),
      isSynced: false,
    ));
  }
  
  Future<void> syncWhenOnline() async {
    // Check network availability
    // Iterate through queue
    // Send each item to backend
    // Mark as synced
    // Remove from queue
  }
}
```

### Conflict Resolution (Phase 2)
```dart
// Last-write-wins for sets (simple, works for fitness app)
// Client ID deduplication: if same setId recorded twice locally, dedup by timestamp
// For programs: merge strategies (user keeps local, backend overwrites, or manual merge)
```

---

## Testing Strategy

### Unit Tests
- Test Services (ProgramService, WorkoutService, NutritionService)
- Test Providers (verify state changes correctly)
- Test Models (serialization, validation)

### Widget Tests
- Test individual screens in isolation
- Mock Riverpod providers (use ProviderContainer)
- Verify UI updates on state change

### Integration Tests
- Test full user flows (signup → create program → log set → view results)
- Simulate database state
- Verify navigation

### Test Example
```dart
test('recordSet updates workout state', () async {
  final container = ProviderContainer();
  final service = WorkoutService(mockDatabase);
  
  final set = Set(
    exerciseId: 'bench_1',
    dayId: 'day_1',
    reps: 8,
    weightKg: 185,
  );
  
  await service.recordSet(set);
  
  final state = container.read(workoutProvider);
  expect(state.loggedSets, contains(set));
});
```

---

## Phase 1 → Phase 2 Migration

### What Changes in Phase 2
1. **Authentication:** Replace local mock with Supabase Auth
2. **Backend API:** Add Supabase + FastAPI
   - AI Coach: Replace mock responses with Claude API
   - Nutrition resolver: LLM intent parser
   - Vision analysis: Claude Vision for form review
3. **Sync Engine:** Implement SyncQueue, conflict resolution
4. **Notifications:** OneSignal integration
5. **Wearables:** Terra API integration for Whoop, Oura, etc.

### What Stays the Same
- Flutter UI layer (99% unchanged)
- Navigation structure
- Local database schema (may extend, not replace)
- State management (Riverpod architecture)

### Migration Path
- Phase 1 production build: fully functional offline
- Phase 2 development: add backend services incrementally
- Gradual integration: service layer abstraction allows swapping mock for real API
- Testing: all existing tests still pass (backends transparent to UI)

