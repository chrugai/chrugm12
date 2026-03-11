import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/chats_table.dart';
import '../tables/messages_table.dart';

part 'chat_dao.g.dart';

@DriftAccessor(tables: [Chats, Messages])
class ChatDao extends DatabaseAccessor<AppDatabase> with _$ChatDaoMixin {
  ChatDao(super.db);

  Future<List<Chat>> getAllChats() => select(chats).get();

  Future<Chat?> getChatById(String id) =>
      (select(chats)..where((t) => t.chatId.equals(id))).getSingleOrNull();

  Future<void> insertChat(ChatsCompanion chat) => into(chats).insert(chat);

  Future<int> deleteChat(String id) =>
      (delete(chats)..where((t) => t.chatId.equals(id))).go();

  Future<List<Message>> getMessagesForChat(String chatId) =>
      (select(messages)
            ..where((t) => t.chatId.equals(chatId))
            ..orderBy([(t) => OrderingTerm.asc(t.timestamp)]))
          .get();

  Future<void> insertMessage(MessagesCompanion message) =>
      into(messages).insert(message);

  Future<int> deleteMessage(String id) =>
      (delete(messages)..where((t) => t.messageId.equals(id))).go();
}
