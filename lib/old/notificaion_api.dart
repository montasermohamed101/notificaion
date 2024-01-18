// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// class NotificationApi {
//   static final _notification = FlutterLocalNotificationsPlugin();
//
//   static Future _notificationDetails() async {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'dragon',
//         'channel name',
//         channelDescription: 'Update users on new deal',
//         importance: Importance.max,
//         enableLights: true,
//       ),
//       iOS: IOSNotificationDetails(),
//     );
//   }
//
//   static Future init() async {
//     const android = AndroidInitializationSettings('@drawable/ic_notcion');
//     const iOS = IOSInitializationSettings();
//     const settings = InitializationSettings(android: android, iOS: iOS);
//
//     await _notification.initialize(
//       settings,
//       onSelectNotification: (payload) async {
//         // Handle notification tap
//         // You can add your logic here
//       },
//     );
//
//     tz.initializeTimeZones();
//     final locationName = tz.getLocation(await tz.tzdb.local);
//     tz.setLocalLocation(locationName);
//   }
//
//   static tz.TZDateTime _scheduleWeekly(Time time, {required List<int> days}) {
//     tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     while (!days.contains(scheduledDate.weekday)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//
//     return scheduledDate;
//   }
//
//   static tz.TZDateTime _scheduledDaily(Time time) {
//     tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate = tz.TZDateTime(
//       tz.local,
//       now.year,
//       now.month,
//       now.day,
//       time.hour,
//       time.minute,
//     );
//
//     return scheduledDate.isBefore(now)
//         ? scheduledDate.add(const Duration(days: 1))
//         : scheduledDate;
//   }
//
//   static Future showWeeklyScheduledNotification({
//     required int id,
//     String? title,
//     String? body,
//     String? payload,
//     required DateTime scheduledDate,
//   }) async {
//     await _notification.zonedSchedule(
//       id,
//       title,
//       body,
//       _scheduleWeekly(
//         Time(scheduledDate.hour, scheduledDate.minute),
//         days: [
//           DateTime.tuesday,
//           DateTime.friday,
//           DateTime.saturday,
//           DateTime.sunday,
//         ],
//       ),
//       await _notificationDetails(),
//       payload: payload,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//       matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
//     );
//   }
//
//   static void cancelAll() => _notification.cancelAll();
// }
