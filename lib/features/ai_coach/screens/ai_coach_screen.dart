import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/ai_coach_provider.dart';
import '../widgets/chat_history_sidebar.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/chat_message_bubble.dart';
import '../widgets/file_upload_modal.dart';

class AiCoachScreen extends ConsumerStatefulWidget {
  const AiCoachScreen({super.key});

  @override
  ConsumerState<AiCoachScreen> createState() => _AiCoachScreenState();
}

class _AiCoachScreenState extends ConsumerState<AiCoachScreen> {
  bool _sidebarOpen = false;
  final _scrollController = ScrollController();
  final _inputKey = GlobalKey<ChatInputBarState>();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(aiCoachProvider.notifier).loadChats();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showFileUpload() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.modalRadius),
        ),
      ),
      builder: (_) => FileUploadModal(
        onSelected: (filePath) {
          ref.read(aiCoachProvider.notifier).sendMessage(
                'Attached file: $filePath',
                fileUrl: filePath,
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(aiCoachProvider);
    final messages = state.messages;

    // Auto-scroll when messages change
    if (messages.isNotEmpty) {
      _scrollToBottom();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: AppColors.textPrimary),
          onPressed: () => setState(() => _sidebarOpen = true),
        ),
        title: Text('AI Coach', style: AppTypography.headingSmall),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              ref.read(aiCoachProvider.notifier).createNewChat();
            },
            child: Text(
              'New Chat',
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.accentBlue,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.lg,
                        ),
                        itemCount: messages.length + (state.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == messages.length && state.isLoading) {
                            return _buildTypingIndicator();
                          }
                          return ChatMessageBubble(message: messages[index]);
                        },
                      ),
              ),
              ChatInputBar(
                key: _inputKey,
                onSend: (text) {
                  ref.read(aiCoachProvider.notifier).sendMessage(text);
                },
                onAttach: _showFileUpload,
              ),
            ],
          ),
          if (_sidebarOpen)
            ChatHistorySidebar(
              chats: state.chats,
              currentChatId: state.currentChatId,
              onChatSelected: (chatId) {
                setState(() => _sidebarOpen = false);
                ref.read(aiCoachProvider.notifier).loadChat(chatId);
              },
              onNewChat: () {
                setState(() => _sidebarOpen = false);
                ref.read(aiCoachProvider.notifier).createNewChat();
              },
              onDeleteChat: (chatId) {
                ref.read(aiCoachProvider.notifier).deleteChat(chatId);
              },
              onClose: () => setState(() => _sidebarOpen = false),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'What can I help with?',
              style: AppTypography.headingMedium,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              alignment: WrapAlignment.center,
              children: [
                _quickAction('Should I deload?'),
                _quickAction('How am I doing?'),
                _quickAction('Suggest a meal'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAction(String text) {
    return GestureDetector(
      onTap: () {
        _inputKey.currentState?.setText(text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.inputBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: AppTypography.bodySmall),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPaddingH,
        vertical: AppSpacing.xs,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(3, (i) {
              return Padding(
                padding: EdgeInsets.only(left: i > 0 ? 4 : 0),
                child: const _DotWidget(),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _DotWidget extends StatefulWidget {
  const _DotWidget();

  @override
  State<_DotWidget> createState() => _DotWidgetState();
}

class _DotWidgetState extends State<_DotWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Opacity(
        opacity: 0.3 + (_controller.value * 0.7),
        child: Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.textSecondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
