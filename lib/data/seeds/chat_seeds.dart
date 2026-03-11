import 'package:drift/drift.dart';
import '../database/app_database.dart';

Future<void> seedChats(AppDatabase db) async {
  final now = DateTime.now();

  await db.chatDao.insertChat(ChatsCompanion(chatId: const Value('chat_1'), userId: const Value('local_user'), title: const Value('Should I deload?'), createdAt: Value(now.subtract(const Duration(days: 2)).toIso8601String()), updatedAt: Value(now.subtract(const Duration(days: 2)).toIso8601String())));
  await db.chatDao.insertChat(ChatsCompanion(chatId: const Value('chat_2'), userId: const Value('local_user'), title: const Value('Protein intake'), createdAt: Value(now.subtract(const Duration(days: 5)).toIso8601String()), updatedAt: Value(now.subtract(const Duration(days: 5)).toIso8601String())));

  await db.transaction(() async {
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_1_1'), chatId: const Value('chat_1'), role: const Value('user'), content: const Value("I've been training hard for 6 weeks straight and my lifts are starting to stall. Should I take a deload week?"), timestamp: Value(now.subtract(const Duration(days: 2, hours: 3)).toIso8601String())));
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_1_2'), chatId: const Value('chat_1'), role: const Value('assistant'), content: const Value("6 weeks of consistent hard training is a solid block. If your lifts are stalling and you're feeling more fatigued than usual, a deload week is a smart move. Reduce your working weight by 40-50% and keep the same rep scheme."), timestamp: Value(now.subtract(const Duration(days: 2, hours: 2, minutes: 55)).toIso8601String())));
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_1_3'), chatId: const Value('chat_1'), role: const Value('user'), content: const Value('Should I still train the same number of days during a deload?'), timestamp: Value(now.subtract(const Duration(days: 2, hours: 2, minutes: 50)).toIso8601String())));
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_1_4'), chatId: const Value('chat_1'), role: const Value('assistant'), content: const Value("Yes, keep the same training schedule and exercise selection. The goal is to reduce intensity and volume, not stop training entirely. You'll come back feeling refreshed and ready to push past those plateaus."), timestamp: Value(now.subtract(const Duration(days: 2, hours: 2, minutes: 45)).toIso8601String())));
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_2_1'), chatId: const Value('chat_2'), role: const Value('user'), content: const Value("How much protein should I be eating daily? I'm 85kg and trying to build muscle."), timestamp: Value(now.subtract(const Duration(days: 5, hours: 1)).toIso8601String())));
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_2_2'), chatId: const Value('chat_2'), role: const Value('assistant'), content: const Value("For muscle growth at 85kg, aim for 1.6-2.2g of protein per kg of bodyweight daily. That puts you at roughly 136-187g per day. Spread it across 4-5 meals for optimal muscle protein synthesis."), timestamp: Value(now.subtract(const Duration(days: 5, minutes: 55)).toIso8601String())));
    await db.chatDao.insertMessage(MessagesCompanion(messageId: const Value('msg_2_3'), chatId: const Value('chat_2'), role: const Value('user'), content: const Value("Got it, thanks! I'll aim for around 170g."), timestamp: Value(now.subtract(const Duration(days: 5, minutes: 50)).toIso8601String())));
  });
}
