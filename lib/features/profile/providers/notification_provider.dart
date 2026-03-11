import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/models/notification_item.dart';
import '../../../data/seeds/notification_seeds.dart';

final notificationProvider =
    StateNotifierProvider<NotificationNotifier, List<NotificationItem>>((ref) {
  return NotificationNotifier();
});

class NotificationNotifier extends StateNotifier<List<NotificationItem>> {
  NotificationNotifier() : super(getNotifications());

  void markAsRead(String id) {
    state = state
        .map((n) => n.id == id ? n.copyWith(isRead: true) : n)
        .toList();
  }

  int get unreadCount => state.where((n) => !n.isRead).length;
}
