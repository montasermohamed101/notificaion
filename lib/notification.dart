import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final onClickNotification = BehaviorSubject<String>();

  static void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  static Future init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) => null,
    );
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotificationTap,
        onDidReceiveBackgroundNotificationResponse: onNotificationTap);
  }


  static Future showScheduleNotification({
    required int notificationId, // Unique notification ID
    required String title,
    required String body,
    // required String payload,
    required DateTime scheduledDate,
  }) async {
    tz.initializeTimeZones();
    final tz.TZDateTime notificationTime =
    tz.TZDateTime.from(scheduledDate, tz.local);

    if (notificationTime.isBefore(tz.TZDateTime.now(tz.local))) {
      throw ArgumentError("Scheduled date must be in the future.");
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      notificationId, // Use the unique notification ID
      title,
      body,
      notificationTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 3',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      // payload: payload,
    );
  }






}
// static Future showSimpleNotification({
//   required String title,
//   required String body,
//   required String payload,
// }) async {
//   const AndroidNotificationDetails androidNotificationDetails =
//   AndroidNotificationDetails('your channel id', 'your channel name',
//       channelDescription: 'your channel description',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker');
//   const NotificationDetails notificationDetails =
//   NotificationDetails(android: androidNotificationDetails);
//   await _flutterLocalNotificationsPlugin
//       .show(0, title, body, notificationDetails, payload: payload);
// }