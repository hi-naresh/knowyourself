import 'package:flutter/material.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../../utils/constants/colors.dart';

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
      appBar: KPageBar(
        title: KTexts.notificationsTitle,
        showBackButton: true,
        onTap: () => Navigator.of(context).pop(),
        action: TextButton(
          onPressed: clearNotifications,
          child: Text(KTexts.clearButtonText,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).primaryColor,
            )
          )
        )
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Dismissible(
            key: Key(notification.id),
            onDismissed: (_) => removeNotification(notification.id),
            background: Container(color: KColors.red),
            child: ListTile(
              title: Text(notification.title),
              subtitle: Text(notification.body),
              trailing: IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => removeNotification(notification.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
