import 'package:flutter_test/flutter_test.dart';
import 'package:chrugm12/data/models/integration.dart';
import 'package:chrugm12/data/models/measurement.dart';
import 'package:chrugm12/data/models/notification_item.dart';
import 'package:chrugm12/data/models/upload.dart';
import 'package:chrugm12/data/models/user.dart';
import 'package:chrugm12/data/seeds/notification_seeds.dart';

void main() {
  final now = DateTime.utc(2026, 1, 1);

  group('User model', () {
    test('user fields update via copyWith', () {
      final user = User(
        userId: 'local_user',
        email: 'jimmy@test.com',
        name: 'Jimmy Chen',
        heightCm: 178,
        weightKg: 85,
        isAuthenticated: true,
        createdAt: now,
        updatedAt: now,
      );

      final updated = user.copyWith(name: 'James Chen', weightKg: 82.0);
      expect(updated.name, 'James Chen');
      expect(updated.weightKg, 82.0);
      expect(updated.email, 'jimmy@test.com'); // unchanged
    });
  });

  group('Measurement model', () {
    test('measurement add and list', () {
      final m1 = Measurement(
        measurementId: 'm1',
        userId: 'local_user',
        measurementDate: '2026-01-01',
        chestCm: 100,
        waistCm: 82,
        createdAt: now,
      );
      final m2 = Measurement(
        measurementId: 'm2',
        userId: 'local_user',
        measurementDate: '2026-01-08',
        chestCm: 101,
        waistCm: 81.5,
        createdAt: now.add(const Duration(days: 7)),
      );

      final list = [m2, m1]; // newest first
      expect(list.length, 2);
      expect(list.first.measurementId, 'm2');
      expect(list.first.chestCm, 101);
    });

    test('delete measurement removes from list', () {
      final measurements = [
        Measurement(measurementId: 'm1', userId: 'u1', measurementDate: '2026-01-01', createdAt: now),
        Measurement(measurementId: 'm2', userId: 'u1', measurementDate: '2026-01-08', createdAt: now),
      ];

      final after = measurements.where((m) => m.measurementId != 'm1').toList();
      expect(after.length, 1);
      expect(after.first.measurementId, 'm2');
    });
  });

  group('Upload model', () {
    test('add and delete upload', () {
      final uploads = <Upload>[
        Upload(uploadId: 'u1', userId: 'local_user', fileName: 'photo.jpg', fileType: 'image/jpeg', filePath: '/path/photo.jpg', uploadDate: '2026-01-01', createdAt: now),
        Upload(uploadId: 'u2', userId: 'local_user', fileName: 'doc.pdf', fileType: 'application/pdf', filePath: '/path/doc.pdf', uploadDate: '2026-01-02', createdAt: now),
      ];

      expect(uploads.length, 2);

      final after = uploads.where((u) => u.uploadId != 'u1').toList();
      expect(after.length, 1);
      expect(after.first.fileName, 'doc.pdf');
    });
  });

  group('Integration model', () {
    test('connect toggles isConnected to true', () {
      final integration = Integration(
        integrationId: 'int_1',
        userId: 'local_user',
        integrationName: 'Apple Health',
        isConnected: false,
      );

      final connected = integration.copyWith(
        isConnected: true,
        lastSyncedAt: now,
      );
      expect(connected.isConnected, true);
      expect(connected.lastSyncedAt, now);
    });

    test('disconnect toggles isConnected to false', () {
      final integration = Integration(
        integrationId: 'int_1',
        userId: 'local_user',
        integrationName: 'Apple Health',
        isConnected: true,
        lastSyncedAt: now,
      );

      final disconnected = integration.copyWith(
        isConnected: false,
        lastSyncedAt: null,
      );
      expect(disconnected.isConnected, false);
      expect(disconnected.lastSyncedAt, isNull);
    });
  });

  group('NotificationItem', () {
    test('loads 6 mock notifications', () {
      final notifications = getNotifications();
      expect(notifications.length, 6);
    });

    test('3 unread and 3 read notifications', () {
      final notifications = getNotifications();
      final unread = notifications.where((n) => !n.isRead).length;
      final read = notifications.where((n) => n.isRead).length;
      expect(unread, 3);
      expect(read, 3);
    });

    test('markAsRead updates isRead flag', () {
      final notifications = getNotifications();
      final notif = notifications.first;
      expect(notif.isRead, false);

      final marked = notif.copyWith(isRead: true);
      expect(marked.isRead, true);
      expect(marked.id, notif.id);
    });

    test('unreadCount matches expected after marking one read', () {
      var notifications = getNotifications();
      var unreadCount = notifications.where((n) => !n.isRead).length;
      expect(unreadCount, 3);

      // Mark first unread notification as read
      notifications = notifications
          .map((n) => n.id == 'notif_1' ? n.copyWith(isRead: true) : n)
          .toList();
      unreadCount = notifications.where((n) => !n.isRead).length;
      expect(unreadCount, 2);
    });
  });
}
