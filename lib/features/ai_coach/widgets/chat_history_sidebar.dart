import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../data/models/chat.dart';

class ChatHistorySidebar extends StatelessWidget {
  const ChatHistorySidebar({
    super.key,
    required this.chats,
    required this.onChatSelected,
    required this.onNewChat,
    required this.onDeleteChat,
    required this.onClose,
    this.currentChatId,
  });

  final List<Chat> chats;
  final ValueChanged<String> onChatSelected;
  final VoidCallback onNewChat;
  final ValueChanged<String> onDeleteChat;
  final VoidCallback onClose;
  final String? currentChatId;

  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    return '${dt.month}/${dt.day}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClose,
      child: Container(
        color: AppColors.overlayDim,
        child: GestureDetector(
          onTap: () {}, // Absorb tap
          child: Align(
            alignment: Alignment.centerLeft,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: MediaQuery.of(context).size.width * 0.7,
              color: AppColors.surface,
              child: SafeArea(
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Row(
                        children: [
                          Text('Chats', style: AppTypography.headingSmall),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: onClose,
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    // Chat list
                    Expanded(
                      child: chats.isEmpty
                          ? Center(
                              child: Text(
                                'No chats yet',
                                style: AppTypography.bodyMedium.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: chats.length,
                              itemBuilder: (context, index) {
                                final chat = chats[index];
                                final isActive =
                                    chat.chatId == currentChatId;
                                return Dismissible(
                                  key: ValueKey(chat.chatId),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(
                                        right: AppSpacing.lg),
                                    color: AppColors.danger,
                                    child: const Icon(Icons.delete,
                                        color: Colors.white),
                                  ),
                                  onDismissed: (_) =>
                                      onDeleteChat(chat.chatId),
                                  child: ListTile(
                                    selected: isActive,
                                    selectedTileColor: AppColors.background,
                                    title: Text(
                                      chat.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTypography.bodyMedium
                                          .copyWith(
                                        fontWeight: isActive
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _formatDate(chat.updatedAt),
                                      style: AppTypography.caption,
                                    ),
                                    onTap: () =>
                                        onChatSelected(chat.chatId),
                                  ),
                                );
                              },
                            ),
                    ),
                    // New Chat
                    const Divider(height: 1),
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: GestureDetector(
                        onTap: onNewChat,
                        child: Row(
                          children: [
                            const Icon(Icons.add, color: AppColors.primary),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'New Chat',
                              style: AppTypography.bodyLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
