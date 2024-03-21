import 'package:flutter/material.dart';

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
  List<NotificationItem> notifications = [];

  void clearNotifications() {
    setState(() {
      notifications.clear();
    });
  }

  Future<void> addNotification(String id, String title, String body) async {
    setState(() {
      notifications.add(NotificationItem(id: id, title: title, body: body));
    });
  }

  void removeNotification(String id) {
    setState(() {
      notifications.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          TextButton(
              onPressed: clearNotifications,
              child: Text('Clear All',
                style: Theme.of(context).textTheme.bodyLarge,
              )
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.id),
            onDismissed: (_) => removeNotification(notification.id),
            background: Container(color: Colors.red),
            child: ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: IconButton(
                icon: Icon(Icons.close_rounded),
                onPressed: () => removeNotification(notification.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
