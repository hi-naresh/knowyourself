import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/helper_service/notifications/notification_service.dart';

class NotificationItem {
  final String id;
  final String title;
  final String body;

  NotificationItem({required this.id, required this.title, required this.body});
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // List<NotificationItem> notifications = [];
  //
  // void clearNotifications() {
  //   setState(() {
  //     notifications.clear();
  //   });
  // }
  //
  // Future<void> addNotification(String id, String title, String body) async {
  //   setState(() {
  //     notifications.add(NotificationItem(id: id, title: title, body: body));
  //   });
  // }
  //
  // void removeNotification(String id) {
  //   setState(() {
  //     notifications.removeWhere((item) => item.id == id);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final logs = Get.find<NotificationService>().getNotificationLogs();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
              // onPressed: clearNotifications,
            onPressed: () => Get.find<NotificationService>().clearNotificationLogs(),
              child: Text('Clear All',
                style: Theme.of(context).textTheme.bodyLarge,
              )
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          var log = logs[index];
          return ListTile(
            title: Text(log['title']),
            subtitle: Text("${log['body']} - ${log['time']} - ${log['status']}"),
          );
        },
      ),
      // body: ListView.builder(
      //   itemCount: notifications.length,
      //   itemBuilder: (context, index) {
      //     final notification = notifications[index];
      //     return Dismissible(
      //       key: Key(notification.id),
      //       onDismissed: (_) => removeNotification(notification.id),
      //       background: Container(color: Colors.red),
      //       child: ListTile(
      //         title: Text(notification.title),
      //         subtitle: Text(notification.body),
      //         trailing: IconButton(
      //           icon: const Icon(Icons.close_rounded),
      //           onPressed: () => removeNotification(notification.id),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
