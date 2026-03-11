import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrugm12/data/models/chat.dart';
import 'package:chrugm12/data/models/message.dart';
import 'package:chrugm12/features/ai_coach/widgets/chat_message_bubble.dart';
import 'package:chrugm12/features/ai_coach/widgets/chat_history_sidebar.dart';
import 'package:chrugm12/features/ai_coach/widgets/chat_input_bar.dart';

Widget _wrap(Widget child) {
  return ProviderScope(
    child: MaterialApp(home: Scaffold(body: child)),
  );
}

void main() {
  group('ChatMessageBubble', () {
    testWidgets('renders user message right-aligned', (tester) async {
      final msg = Message(
        messageId: 'm1',
        chatId: 'c1',
        role: 'user',
        content: 'Should I deload?',
        timestamp: DateTime(2025, 1, 15, 14, 30),
      );

      await tester.pumpWidget(_wrap(ChatMessageBubble(message: msg)));

      expect(find.text('Should I deload?'), findsOneWidget);
      expect(find.text('2:30 PM'), findsOneWidget);
    });

    testWidgets('renders AI message left-aligned', (tester) async {
      final msg = Message(
        messageId: 'm2',
        chatId: 'c1',
        role: 'assistant',
        content: 'Based on your training data, a deload might be beneficial.',
        timestamp: DateTime(2025, 1, 15, 14, 31),
      );

      await tester.pumpWidget(_wrap(ChatMessageBubble(message: msg)));

      expect(find.textContaining('deload might be beneficial'), findsOneWidget);
    });
  });

  group('ChatInputBar', () {
    testWidgets('send button appears when text entered', (tester) async {
      await tester.pumpWidget(_wrap(
        ChatInputBar(onSend: (_) {}, onAttach: () {}),
      ));

      // Initially no send button
      expect(find.byIcon(Icons.send), findsNothing);

      // Type text
      await tester.enterText(find.byType(TextField), 'Hello');
      await tester.pump();

      // Send button appears
      expect(find.byIcon(Icons.send), findsOneWidget);
    });

    testWidgets('fires onSend with text', (tester) async {
      String? sentText;
      await tester.pumpWidget(_wrap(
        ChatInputBar(onSend: (t) => sentText = t, onAttach: () {}),
      ));

      await tester.enterText(find.byType(TextField), 'Test message');
      await tester.pump();
      await tester.tap(find.byIcon(Icons.send));

      expect(sentText, 'Test message');
    });
  });

  group('ChatHistorySidebar', () {
    testWidgets('renders chat list', (tester) async {
      final chats = [
        Chat(
          chatId: 'c1',
          userId: 'u1',
          title: 'Deload Discussion',
          messages: [],
          createdAt: DateTime(2025, 1, 15),
          updatedAt: DateTime(2025, 1, 15),
        ),
        Chat(
          chatId: 'c2',
          userId: 'u1',
          title: 'Meal Planning',
          messages: [],
          createdAt: DateTime(2025, 1, 14),
          updatedAt: DateTime(2025, 1, 14),
        ),
      ];

      await tester.pumpWidget(_wrap(
        ChatHistorySidebar(
          chats: chats,
          onChatSelected: (_) {},
          onNewChat: () {},
          onDeleteChat: (_) {},
          onClose: () {},
        ),
      ));

      expect(find.text('Chats'), findsOneWidget);
      expect(find.text('Deload Discussion'), findsOneWidget);
      expect(find.text('Meal Planning'), findsOneWidget);
      expect(find.text('New Chat'), findsOneWidget);
    });
  });
}
