import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/chat.dart' as models;
import '../../../data/models/message.dart' as models;
import '../../../data/seeds/ai_response_seeds.dart';

const _uuid = Uuid();

class AiCoachService {
  AiCoachService(this._db);

  final AppDatabase _db;

  Future<models.Chat> createNewChat(String userId) async {
    final chatId = _uuid.v4();
    final now = DateTime.now().toIso8601String();

    await _db.chatDao.insertChat(ChatsCompanion(
      chatId: Value(chatId),
      userId: Value(userId),
      title: const Value('New Chat'),
      createdAt: Value(now),
      updatedAt: Value(now),
    ));

    return models.Chat(
      chatId: chatId,
      userId: userId,
      title: 'New Chat',
      messages: const [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<List<models.Chat>> getAllChats(String userId) async {
    final rows = await (_db.select(_db.chats)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.updatedAt)]))
        .get();

    final chats = <models.Chat>[];
    for (final row in rows) {
      final msgRows = await _db.chatDao.getMessagesForChat(row.chatId);
      chats.add(_chatFromRow(
        row,
        msgRows.map(_messageFromRow).toList(),
      ));
    }
    return chats;
  }

  Future<List<models.Message>> getMessagesForChat(String chatId) async {
    final rows = await _db.chatDao.getMessagesForChat(chatId);
    return rows.map(_messageFromRow).toList();
  }

  Future<void> deleteChat(String chatId) async {
    // Delete messages first (cascade)
    await (_db.delete(_db.messages)
          ..where((t) => t.chatId.equals(chatId)))
        .go();
    await _db.chatDao.deleteChat(chatId);
  }

  Future<models.Message> sendMessage(
    String chatId,
    String content,
    String? fileUrl,
  ) async {
    final now = DateTime.now();
    final nowIso = now.toIso8601String();

    // Insert user message
    final userMsgId = _uuid.v4();
    await _db.chatDao.insertMessage(MessagesCompanion(
      messageId: Value(userMsgId),
      chatId: Value(chatId),
      role: const Value('user'),
      content: Value(content),
      fileUrl: Value(fileUrl),
      timestamp: Value(nowIso),
    ));

    // Simulate AI delay
    await Future<void>.delayed(const Duration(milliseconds: 500));

    // Generate and insert AI response
    final aiResponse = generateMockResponse(content);
    final aiMsgId = _uuid.v4();
    final aiNow = DateTime.now().toIso8601String();
    await _db.chatDao.insertMessage(MessagesCompanion(
      messageId: Value(aiMsgId),
      chatId: Value(chatId),
      role: const Value('assistant'),
      content: Value(aiResponse),
      timestamp: Value(aiNow),
    ));

    // Update chat updatedAt
    final chat = await _db.chatDao.getChatById(chatId);
    if (chat != null) {
      await (_db.update(_db.chats)..where((t) => t.chatId.equals(chatId)))
          .write(ChatsCompanion(updatedAt: Value(aiNow)));
    }

    return models.Message(
      messageId: aiMsgId,
      chatId: chatId,
      role: 'assistant',
      content: aiResponse,
      timestamp: DateTime.now(),
    );
  }

  String generateMockResponse(String userMessage) {
    final lower = userMessage.toLowerCase();
    final responses = getAiResponses();

    for (final entry in responses.entries) {
      if (lower.contains(entry.key)) {
        return entry.value;
      }
    }

    return aiFallbackResponse;
  }

  Future<void> updateChatTitle(
      String chatId, String firstMessageContent) async {
    final title = firstMessageContent.length > 50
        ? '${firstMessageContent.substring(0, 50)}...'
        : firstMessageContent;

    await (_db.update(_db.chats)..where((t) => t.chatId.equals(chatId)))
        .write(ChatsCompanion(title: Value(title)));
  }

  // -- Private helpers --

  models.Chat _chatFromRow(Chat row, List<models.Message> messages) {
    return models.Chat(
      chatId: row.chatId,
      userId: row.userId,
      title: row.title,
      messages: messages,
      createdAt: DateTime.parse(row.createdAt),
      updatedAt: DateTime.parse(row.updatedAt),
    );
  }

  models.Message _messageFromRow(Message row) {
    return models.Message(
      messageId: row.messageId,
      chatId: row.chatId,
      role: row.role,
      content: row.content,
      fileUrl: row.fileUrl,
      timestamp: DateTime.parse(row.timestamp),
    );
  }
}
