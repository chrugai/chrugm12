import 'package:chrugm12/data/models/chat.dart';
import 'package:chrugm12/data/models/message.dart';
import 'package:chrugm12/data/models/state/ai_coach_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AiCoachState', () {
    test('initial state has empty lists', () {
      final state = AiCoachState.initial();
      expect(state.messages, isEmpty);
      expect(state.chats, isEmpty);
      expect(state.currentChatId, isNull);
      expect(state.isLoading, isFalse);
      expect(state.error, isNull);
    });

    test('copyWith sets current chat', () {
      final state = AiCoachState.initial();
      final updated = state.copyWith(currentChatId: 'chat_1');
      expect(updated.currentChatId, 'chat_1');
    });

    test('copyWith adds messages', () {
      final state = AiCoachState.initial();
      final msg = Message(
        messageId: 'msg_1',
        chatId: 'chat_1',
        role: 'user',
        content: 'Should I deload this week?',
        timestamp: DateTime(2026, 3, 11),
      );
      final updated = state.copyWith(messages: [msg]);
      expect(updated.messages.length, 1);
      expect(updated.messages.first.role, 'user');
      expect(updated.messages.first.content, 'Should I deload this week?');
    });

    test('copyWith adds chats', () {
      final state = AiCoachState.initial();
      final chat = Chat(
        chatId: 'chat_1',
        userId: 'local_user',
        title: 'Deload question',
        messages: [],
        createdAt: DateTime(2026, 3, 11),
        updatedAt: DateTime(2026, 3, 11),
      );
      final updated = state.copyWith(chats: [chat]);
      expect(updated.chats.length, 1);
      expect(updated.chats.first.title, 'Deload question');
    });

    test('delete chat clears current if matching', () {
      final chat1 = Chat(
        chatId: 'chat_1',
        userId: 'local_user',
        title: 'Chat 1',
        messages: [],
        createdAt: DateTime(2026, 3, 11),
        updatedAt: DateTime(2026, 3, 11),
      );
      final chat2 = Chat(
        chatId: 'chat_2',
        userId: 'local_user',
        title: 'Chat 2',
        messages: [],
        createdAt: DateTime(2026, 3, 11),
        updatedAt: DateTime(2026, 3, 11),
      );
      final state = AiCoachState.initial().copyWith(
        chats: [chat1, chat2],
        currentChatId: 'chat_1',
      );

      // Simulate delete of current chat
      final chats = state.chats.where((c) => c.chatId != 'chat_1').toList();
      final isCurrent = state.currentChatId == 'chat_1';
      final afterDelete = state.copyWith(
        chats: chats,
        currentChatId: isCurrent ? null : state.currentChatId,
        messages: isCurrent ? const [] : state.messages,
      );

      expect(afterDelete.chats.length, 1);
      expect(afterDelete.currentChatId, isNull);
      expect(afterDelete.messages, isEmpty);
    });

    test('message supports file attachment', () {
      final msg = Message(
        messageId: 'msg_1',
        chatId: 'chat_1',
        role: 'user',
        content: 'Check this form',
        fileUrl: '/uploads/squat_form.mp4',
        timestamp: DateTime(2026, 3, 11),
      );
      expect(msg.fileUrl, '/uploads/squat_form.mp4');
    });
  });
}
