import '../models/notification_item.dart';

List<NotificationItem> getNotifications() {
  final now = DateTime.now();
  return [
    NotificationItem(id: 'notif_1', title: 'Time to train!', body: 'Your Push day is waiting. Let\'s get after it.', isRead: false, timestamp: now.subtract(const Duration(minutes: 2))),
    NotificationItem(id: 'notif_2', title: 'New program template available', body: 'Check out the new Upper/Lower split in Pick a Program.', isRead: false, timestamp: now.subtract(const Duration(hours: 1))),
    NotificationItem(id: 'notif_3', title: 'You hit a new PR on Bench Press!', body: 'Congrats! You pressed 90kg for 8 reps. Keep pushing.', isRead: false, timestamp: now.subtract(const Duration(hours: 3))),
    NotificationItem(id: 'notif_4', title: 'Welcome to Chrug!', body: 'Your AI-powered fitness companion is ready. Start by picking a program.', isRead: true, timestamp: now.subtract(const Duration(days: 1))),
    NotificationItem(id: 'notif_5', title: "Don't forget to log your meals", body: 'Tracking nutrition helps you stay on top of your goals.', isRead: true, timestamp: now.subtract(const Duration(days: 2))),
    NotificationItem(id: 'notif_6', title: 'Weekly progress update ready', body: 'Check your measurements to see how far you\'ve come.', isRead: true, timestamp: now.subtract(const Duration(days: 3))),
  ];
}
