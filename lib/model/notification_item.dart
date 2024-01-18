import 'package:hive/hive.dart';

part 'notification_item.g.dart';

@HiveType(typeId: 0)
class NotificationItem extends HiveObject {
  @HiveField(0)
  late DateTime startDate;

  @HiveField(1)
  late DateTime endDate;

  // Add this constructor
  NotificationItem({
    required this.startDate,
    required this.endDate,
  });
}
