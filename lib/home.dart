import 'package:flutter/material.dart';
import 'package:newtask/serciecs_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/notification_item.dart';
import 'notification.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HiveService hiveService = HiveService();
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedEndDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;

  @override
  void initState() {
    super.initState();
    LocalNotifications.init();
  }

  Future<void> _scheduleNotification(
      int notificationId,
      DateTime scheduledDate,
      String title,
      String body,
      // String payload,
      ) async {
    LocalNotifications.showScheduleNotification(
      notificationId: notificationId,
      title: title,
      body: body,
      // payload: payload,
      scheduledDate: scheduledDate,
    );
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Local Notifications")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TextFormField(
            //   controller: titleController,
            //   decoration: InputDecoration(labelText: 'Event Title'),
            // ),
            SizedBox(height: 16),
            ElevatedButton.icon(
              icon: Icon(Icons.notifications_outlined),
              onPressed: () async {
                selectedStartDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                startTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                selectedEndDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );

                endTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (selectedStartDate != null &&
                    startTime != null &&
                    selectedEndDate != null &&
                    endTime != null) {
                  final item = NotificationItem(
                    startDate: DateTime(
                      selectedStartDate!.year,
                      selectedStartDate!.month,
                      selectedStartDate!.day,
                      startTime!.hour,
                      startTime!.minute,
                    ),
                    endDate: DateTime(
                      selectedEndDate!.year,
                      selectedEndDate!.month,
                      selectedEndDate!.day,
                      endTime!.hour,
                      endTime!.minute,
                    ),
                  );

                  await hiveService.addNotificationItem(item);

                  final Duration warningDuration = Duration(minutes: 3);
                  final DateTime notificationTime =
                  item.endDate.subtract(warningDuration);

                  await _scheduleNotification(
                    item.hashCode, // Unique ID based on item's hash code
                    notificationTime,
                    "Your Notification Title",
                    "Your Notification Body",
                    // "Your Notification Payload",
                  );

                  titleController.clear();
                  setState(() {});
                }
              },
              label: Text("Create Notification"),
            ),
            SizedBox(height: 16),
            // ElevatedButton.icon(
            //   icon: Icon(Icons.notifications_outlined),
            //   onPressed: () {
            //     final delayDuration = Duration(seconds: 3);
            //
            //     Future.delayed(delayDuration, () {
            //       LocalNotifications.showSimpleNotification(
            //         title: "Simple Notification",
            //         body: "This is a simple notification",
            //         payload: "This is simple data",
            //       );
            //     });
            //   },
            //   label: Text("Simple Notification"),
            // ),

            SizedBox(height: 16),
            FutureBuilder<List<NotificationItem>>(
              future: hiveService.getNotificationItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  final items = snapshot.data as List<NotificationItem>;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return buildItemWidget(items[index]);
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildItemWidget(NotificationItem item) {
    return ListTile(
      title: Text(item.startDate.toString()),
      subtitle: Text("End Date: ${item.endDate.toString()}"),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await hiveService.deleteNotificationItem(item);
          setState(() {});
        },
      ),
    );
  }
}
