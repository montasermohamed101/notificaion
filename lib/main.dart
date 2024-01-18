import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'another_page.dart';
import 'home.dart';
import 'model/notification_item.dart';
import 'notification.dart';

final navigatorKey = GlobalKey<NavigatorState>();



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await LocalNotifications.init();
  await SharedPreferences.getInstance(); // Initialize shared preferences

  Hive.registerAdapter(NotificationItemAdapter());


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue),
      ),
      routes: {
        '/': (context) => const Homepage(),
        '/another': (context) => const AnotherPage(),
      },
    );
  }
}

