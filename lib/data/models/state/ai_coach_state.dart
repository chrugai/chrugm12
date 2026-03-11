import 'package:freezed_annotation/freezed_annotation.dart';

import '../chat.dart';
import '../message.dart';

part 'ai_coach_state.freezed.dart';
part 'ai_coach_state.g.dart';

@freezed
abstract class AiCoachState with _$AiCoachState {
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

  factory AiCoachState.fromJson(Map<String, dynamic> json) =>
      _$AiCoachStateFromJson(json);
}
