// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
//
// class TaskModel {
//   final String title;
//   final String startTime;
//   final int remind;
//
//   TaskModel({
//     required this.title,
//     required this.startTime,
//     required this.remind,
//   });
// }
//
// class NotificationServices {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   final BehaviorSubject<String?> onNotifications = BehaviorSubject<String?>();
//
//   Future<void> initializeNotification() async {
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings();
//
//     const InitializationSettings initializationSettings =
//     InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (String? payload) async {
//           if (payload != null) {
//             debugPrint('notification payload: $payload');
//           }
//           onNotifications.add(payload);
//         });
//   }
//
//   Future<void> scheduleNotification({
//     required TaskModel task,
//     required DateTime taskDate,
//     required TimeOfDay taskTime,
//   }) async {
//     if (task.remind == 0) {
//       return;
//     }
//
//     const AndroidNotificationDetails androidNotificationDetails =
//     AndroidNotificationDetails(
//       'your channel id',
//       'your channel name',
//       'your channel description', // Add channel description here
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//
//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       task.title,
//       'Your task will start at ${task.startTime}',
//       tz.TZDateTime.from(
//         DateTime(
//           taskDate.year,
//           taskDate.month,
//           taskDate.day,
//           taskTime.hour,
//           taskTime.minute - task.remind,
//         ),
//         tz.local,
//       ),
//       const NotificationDetails(
//         android: androidNotificationDetails,
//       ),
//       payload: task.title,
//       androidAllowWhileIdle: true,
//       uiLocalNotificationDateInterpretation:
//       UILocalNotificationDateInterpretation.absoluteTime,
//     );
//   }
// }
