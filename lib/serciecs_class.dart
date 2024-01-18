import 'package:hive/hive.dart';

import 'model/notification_item.dart';

class HiveService {
  Future<void> addNotificationItem(NotificationItem item) async {
    final box = await Hive.openBox<NotificationItem>('notification_items');
    await box.add(item);
  }

  Future<List<NotificationItem>> getNotificationItems() async {
    final box = await Hive.openBox<NotificationItem>('notification_items');
    return box.values.toList();
  }

  Future<void> deleteNotificationItem(NotificationItem item) async {
    final box = await Hive.openBox<NotificationItem>('notification_items');
    await box.delete(item.key); // Assuming NotificationItem has a 'key' field
  }
}
