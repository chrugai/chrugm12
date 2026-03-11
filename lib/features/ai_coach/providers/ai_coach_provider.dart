import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/database/app_database.dart';
import '../../../data/models/message.dart' as models;
import '../../../data/models/state/ai_coach_state.dart';
import '../services/ai_coach_service.dart';

final aiCoachServiceProvider = Provider<AiCoachService>((ref) {
  final db = ref.watch(databaseProvider);
  return AiCoachService(db);
});

final aiCoachProvider =
    StateNotifierProvider<AiCoachNotifier, AiCoachState>((ref) {
  final service = ref.watch(aiCoachServiceProvider);
  return AiCoachNotifier(service);
});

class AiCoachNotifier extends StateNotifier<AiCoachState> {
  AiCoachNotifier(this._service) : super(AiCoachState.initial());

  final AiCoachService _service;

  Future<void> loadChats() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final chats = await _service.getAllChats('local_user');
      state = state.copyWith(chats: chats, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> createNewChat() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final chat = await _service.createNewChat('local_user');
      state = state.copyWith(
        chats: [chat, ...state.chats],
        currentChatId: chat.chatId,
        messages: const [],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadChat(String chatId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final messages = await _service.getMessagesForChat(chatId);
      state = state.copyWith(
        currentChatId: chatId,
        messages: messages,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> sendMessage(String content, {String? fileUrl}) async {
    try {
      // Create a new chat if none selected
      if (state.currentChatId == null) {
        await createNewChat();
      }

      final chatId = state.currentChatId!;
      final now = DateTime.now();

      // Optimistic: add user message to state immediately
      final userMsg = models.Message(
        messageId: 'temp_${now.millisecondsSinceEpoch}',
        chatId: chatId,
        role: 'user',
        content: content,
        fileUrl: fileUrl,
        timestamp: now,
      );
      state = state.copyWith(
        messages: [...state.messages, userMsg],
        isLoading: true,
      );

      // Update chat title if this is the first message
      final isFirstMessage = state.messages.length == 1;

      // Send message (includes 500ms delay + AI response)
      await _service.sendMessage(chatId, content, fileUrl);

      if (isFirstMessage) {
        await _service.updateChatTitle(chatId, content);
      }

      // Reload messages from DB to get correct IDs
      final messages = await _service.getMessagesForChat(chatId);

      // Reload chats to update sidebar
      final chats = await _service.getAllChats('local_user');

      state = state.copyWith(
        messages: messages,
        chats: chats,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> deleteChat(String chatId) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _service.deleteChat(chatId);
      final chats = state.chats.where((c) => c.chatId != chatId).toList();
      final isCurrent = state.currentChatId == chatId;
      state = state.copyWith(
        chats: chats,
        currentChatId: isCurrent ? null : state.currentChatId,
        messages: isCurrent ? const [] : state.messages,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}
