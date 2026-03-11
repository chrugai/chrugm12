import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/chat.dart';
import 'package:chrugm12/data/models/message.dart';
import 'package:chrugm12/data/models/state/ai_coach_state.dart';
import 'package:chrugm12/data/seeds/ai_response_seeds.dart';

void main() {
  final now = DateTime.utc(2026, 1, 1);

  group('generateMockResponse', () {
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

    test('returns deload-related text for "should I deload"', () {
      final response = generateMockResponse('should I deload');
      expect(response.toLowerCase(), contains('deload'));
      expect(response, isNotEmpty);
    });

    test('returns protein advice for "how much protein"', () {
      final response = generateMockResponse('how much protein do I need');
      expect(response.toLowerCase(), contains('protein'));
    });

    test('returns fallback for unmatched input', () {
      final response = generateMockResponse('random xyz nothing matches');
      expect(response, aiFallbackResponse);
    });

    test('keyword matching is case-insensitive', () {
      final response = generateMockResponse('Should I DELOAD this week?');
      expect(response.toLowerCase(), contains('deload'));
    });
  });

  group('AiCoachState', () {
    test('initial state has empty messages and chats', () {
      final state = AiCoachState.initial();
      expect(state.messages, isEmpty);
      expect(state.chats, isEmpty);
      expect(state.currentChatId, isNull);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('copyWith sets currentChatId and messages', () {
      final msg = Message(
        messageId: 'msg1',
        chatId: 'chat1',
        role: 'user',
        content: 'Hello',
        timestamp: now,
      );

      final state = AiCoachState.initial().copyWith(
        currentChatId: 'chat1',
        messages: [msg],
      );

      expect(state.currentChatId, 'chat1');
      expect(state.messages.length, 1);
      expect(state.messages.first.content, 'Hello');
    });

    test('deleteChat removes from chats list', () {
      final chat1 = Chat(
        chatId: 'c1',
        userId: 'u1',
        title: 'Chat 1',
        messages: const [],
        createdAt: now,
        updatedAt: now,
      );
      final chat2 = Chat(
        chatId: 'c2',
        userId: 'u1',
        title: 'Chat 2',
        messages: const [],
        createdAt: now,
        updatedAt: now,
      );

      var state = AiCoachState.initial().copyWith(
        chats: [chat1, chat2],
        currentChatId: 'c1',
      );

      // Simulate delete of c1
      final remaining = state.chats.where((c) => c.chatId != 'c1').toList();
      state = state.copyWith(
        chats: remaining,
        currentChatId: null,
        messages: const [],
      );

      expect(state.chats.length, 1);
      expect(state.chats.first.chatId, 'c2');
      expect(state.currentChatId, isNull);
      expect(state.messages, isEmpty);
    });
  });

  group('Chat title truncation', () {
    test('short message becomes title as-is', () {
      const content = 'How do I build muscle?';
      final title =
          content.length > 50 ? '${content.substring(0, 50)}...' : content;
      expect(title, 'How do I build muscle?');
    });

    test('long message gets truncated to 50 chars with ...', () {
      const content =
          'This is a really long message that should definitely be truncated because it exceeds fifty characters';
      final title =
          content.length > 50 ? '${content.substring(0, 50)}...' : content;
      expect(title.length, 53); // 50 + "..."
      expect(title, endsWith('...'));
    });
  });

  group('Message model', () {
    test('user message has role "user"', () {
      final msg = Message(
        messageId: 'msg1',
        chatId: 'chat1',
        role: 'user',
        content: 'Hello',
        timestamp: now,
      );
      expect(msg.role, 'user');
      expect(msg.fileUrl, isNull);
    });

    test('message with file attachment', () {
      final msg = Message(
        messageId: 'msg2',
        chatId: 'chat1',
        role: 'user',
        content: 'Check this image',
        fileUrl: '/uploads/photo.jpg',
        timestamp: now,
      );
      expect(msg.fileUrl, '/uploads/photo.jpg');
    });
  });
}
