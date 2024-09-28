import 'package:flutter/material.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import 'package:get/get.dart';
import '../../data/helper_service/notifications/notification_model.dart';
import '../../data/helper_service/notifications/notification_service.dart';
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


class NotificationController extends GetxController {
  final NotificationService _notificationService = Get.find<NotificationService>();

  RxList<AppNotification> pendingNotifications = <AppNotification>[].obs;
  RxList<AppNotification> allNotifications = <AppNotification>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  void fetchNotifications() {
    // pendingNotifications.value = _notificationService.getPendingNotifications();
    // allNotifications.value = _notificationService.getAllNotifications();
  }
}

// import 'package:flutter/material.dart';
// import 'package:workmanager/workmanager.dart';
// import '../../data/helper_service/notifications/notification_scheduler.dart';
//
// class NotificationScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Notification Test"),
//       ),
//       body: ListView(
//         children: [
//           ListTile(
//             title: Text("Schedule Check-In Notification"),
//             onTap: () {
//               Workmanager().cancelAll();
//               NotificationScheduler.scheduleCheckInNotification();
//             },
//           ),
//           ListTile(
//             title: Text("Schedule Day Checkout Notification"),
//             onTap: () => NotificationScheduler.scheduleDayCheckoutNotification(),
//           ),
//           ListTile(
//             title: Text("Schedule Insights Notification"),
//             onTap: () => NotificationScheduler.scheduleInsightsNotification(),
//           ),
//           ListTile(
//             title: Text("Schedule Daily Quote Notification"),
//             onTap: () => NotificationScheduler.scheduleDailyQuoteNotification(),
//           ),
//           ListTile(
//             title: Text("Schedule Milestone Notification"),
//             onTap: () => NotificationScheduler.scheduleMilestoneNotification(),
//           ),
//           ListTile(
//             title: Text("Schedule Gratitude Notification"),
//             onTap: () => NotificationScheduler.scheduleGratitudeNotification(),
//           ),
//           ListTile(
//             title: Text("Schedule Unsolved Questions Notification"),
//             onTap: () => NotificationScheduler.scheduleUnsolvedQuestionsNotification(),
//           ),
//           ListTile(
//             title: Text("Schedule Story Progress Notification"),
//             onTap: () => NotificationScheduler.scheduleStoryProgressNotification(),
//           ),
//         ],
//       ),
//     );
//   }
// }
