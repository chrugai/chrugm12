import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/database/app_database.dart';

AppDatabase _createTestDb() =>
    AppDatabase.forTesting(NativeDatabase.memory());

void main() {
  late AppDatabase db;

  setUp(() {
    db = _createTestDb();
  });

  tearDown(() async {
    await db.close();
  });

  group('AppDatabase', () {
    test('can be created with in-memory database', () {
      expect(db, isNotNull);
    });
  });

  group('UserDao', () {
    test('upsertUser inserts and returns user', () async {
      final now = DateTime.now().toIso8601String();
      await db.userDao.upsertUser(UsersCompanion.insert(
        userId: 'user-1',
        email: 'test@example.com',
        createdAt: now,
        updatedAt: now,
      ));

      final user = await db.userDao.getUser();
      expect(user, isNotNull);
      expect(user!.email, 'test@example.com');
    });
  });

  group('ProgramDao', () {
    test('insertProgram creates program, getAllPrograms returns it', () async {
      final now = DateTime.now().toIso8601String();

      // First create a user for FK
      await db.userDao.upsertUser(UsersCompanion.insert(
        userId: 'user-1',
        email: 'test@example.com',
        createdAt: now,
        updatedAt: now,
      ));

      await db.programDao.insertProgram(ProgramsCompanion.insert(
        programId: 'prog-1',
        userId: 'user-1',
        name: 'PPL Program',
        createdAt: now,
        updatedAt: now,
      ));

      final programs = await db.programDao.getAllPrograms();
      expect(programs.length, 1);
      expect(programs.first.name, 'PPL Program');
    });
  });

  group('WorkoutDao', () {
    test('insertSet creates set, getSetsForExercise returns it', () async {
      final now = DateTime.now().toIso8601String();

      // Create dependencies
      await db.userDao.upsertUser(UsersCompanion.insert(
        userId: 'user-1',
        email: 'test@example.com',
        createdAt: now,
        updatedAt: now,
      ));
      await db.programDao.insertProgram(ProgramsCompanion.insert(
        programId: 'prog-1',
        userId: 'user-1',
        name: 'Test',
        createdAt: now,
        updatedAt: now,
      ));

      // Create a day
      await db.into(db.days).insert(DaysCompanion.insert(
            dayId: 'day-1',
            programId: 'prog-1',
            dayNumber: 1,
            dayName: 'Push',
            createdAt: now,
            updatedAt: now,
          ));

      // Create an exercise
      await db.exerciseDao.insertExercise(ExercisesCompanion.insert(
        exerciseId: 'ex-1',
        name: 'Bench Press',
        createdAt: now,
      ));

      await db.workoutDao.insertSet(SetsCompanion.insert(
        setId: 'set-1',
        exerciseId: 'ex-1',
        dayId: 'day-1',
        reps: 10,
        weightKg: 60.0,
        timestamp: now,
      ));

      final sets = await db.workoutDao.getSetsForExercise('ex-1');
      expect(sets.length, 1);
      expect(sets.first.reps, 10);
      expect(sets.first.weightKg, 60.0);
    });
  });

  group('NutritionDao', () {
    test('insertMeal creates meal, getMealsForDate returns it', () async {
      final now = DateTime.now().toIso8601String();
      const date = '2026-03-11';

      await db.userDao.upsertUser(UsersCompanion.insert(
        userId: 'user-1',
        email: 'test@example.com',
        createdAt: now,
        updatedAt: now,
      ));

      await db.nutritionDao.insertMeal(MealsCompanion.insert(
        mealId: 'meal-1',
        userId: 'user-1',
        mealDate: date,
        totalCalories: 500,
        totalProteinG: 30,
        totalCarbsG: 50,
        totalFatG: 20,
        createdAt: now,
      ));

      final meals = await db.nutritionDao.getMealsForDate(date);
      expect(meals.length, 1);
      expect(meals.first.totalCalories, 500);
    });
  });

  group('ChatDao', () {
    test('insertChat + insertMessage, getMessagesForChat returns messages',
        () async {
      final now = DateTime.now().toIso8601String();

      await db.userDao.upsertUser(UsersCompanion.insert(
        userId: 'user-1',
        email: 'test@example.com',
        createdAt: now,
        updatedAt: now,
      ));

      await db.chatDao.insertChat(ChatsCompanion.insert(
        chatId: 'chat-1',
        userId: 'user-1',
        title: 'Test Chat',
        createdAt: now,
        updatedAt: now,
      ));

      await db.chatDao.insertMessage(MessagesCompanion.insert(
        messageId: 'msg-1',
        chatId: 'chat-1',
        role: 'user',
        content: 'Hello',
        timestamp: now,
      ));

      await db.chatDao.insertMessage(MessagesCompanion.insert(
        messageId: 'msg-2',
        chatId: 'chat-1',
        role: 'assistant',
        content: 'Hi there!',
        timestamp: now,
      ));

      final messages = await db.chatDao.getMessagesForChat('chat-1');
      expect(messages.length, 2);
      expect(messages.first.content, 'Hello');
    });
  });

  group('ExerciseDao', () {
    test('searchExercises with query returns matching exercises', () async {
      final now = DateTime.now().toIso8601String();

      await db.exerciseDao.insertExercise(ExercisesCompanion.insert(
        exerciseId: 'ex-1',
        name: 'Bench Press',
        createdAt: now,
      ));
      await db.exerciseDao.insertExercise(ExercisesCompanion.insert(
        exerciseId: 'ex-2',
        name: 'Incline Bench Press',
        createdAt: now,
      ));
      await db.exerciseDao.insertExercise(ExercisesCompanion.insert(
        exerciseId: 'ex-3',
        name: 'Squat',
        createdAt: now,
      ));

      final results = await db.exerciseDao.searchExercises('bench');
      expect(results.length, 2);
    });
  });
}
