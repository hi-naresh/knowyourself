// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../utils/constants/colors.dart';
//
// class NotificationService extends GetxService {
//   static NotificationService get instance => Get.find();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeNotifications();
//   }
//
//   Future<NotificationService> init() async {
//     // Initial setup or fetching necessary data for notifications
//     return this;
//   }
//
//   Future<void> _initializeNotifications() async {
//     await AwesomeNotifications().initialize(
//       'resource://drawable/res_app_icon',
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic Notifications',
//           channelDescription: 'Notification channel for basic tests',
//           defaultColor: const Color(0xFF9D50DD),
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//         ),
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: 'basic_channel_group',
//           channelGroupName: 'Basic Channel Group',),
//       ],
//     );
//     bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isNotificationAllowed) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   }
//
//   Future<void> createNotification({
//     required String title,
//     required String body,
//     String? channelKey,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//         channelKey: channelKey ?? 'basic_channel',
//         title: title,
//         body: body,
//       ),
//     );
//   }
//
//   createUniqueId() {
//     // Generate a unique ID for the notification
//     final int uniqueId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
//     return uniqueId;
//   }
//
//   // Example notification service method to show a notification
//   Future<void> showNotification(String title, String body) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: createUniqueId(), // A unique ID for this notification
//         channelKey: 'basic_channel', // Ensure this channel is initialized
//         title: title,
//         body: body,
//       ),
//     );
//   }
//
// }

// // lib/data/services/notifications/notification_service.dart
// import 'package:get/get.dart';
//
//
// import 'notification_model.dart';
//
// class NotificationService extends GetxService {
//   final NotificationRepo _notificationRepo = NotificationRepo();
//
//   Future<void> scheduleNotification(AppNotification notification) async {
//     // Schedule notification logic, using a background scheduler or local notification plugin
//     // E.g., Flutter Local Notifications, WorkManager, etc.
//
//     // Mark as pending
//     _notificationRepo.addNotification(notification);
//   }
//
//   Future<void> cancelNotification(String id) async {
//     // Cancel the notification
//     _notificationRepo.removeNotification(id);
//   }
//
//   Future<void> sendNotification(AppNotification notification) async {
//     // Logic to send notification immediately
//     // Update status
//     _notificationRepo.updateNotificationStatus(notification.id, false);
//   }
//
//   List<AppNotification> getPendingNotifications() {
//     return _notificationRepo.getPendingNotifications();
//   }
//
//   List<AppNotification> getAllNotifications() {
//     return _notificationRepo.getAllNotifications();
//   }
// }
//
// // lib/data/repo/notification_repo.dart
//
// class NotificationRepo {
//   final List<AppNotification> _notifications = [];
//
//   void addNotification(AppNotification notification) {
//     _notifications.add(notification);
//     // Persist to local storage if needed
//   }
//
//   void removeNotification(String id) {
//     _notifications.removeWhere((notification) => notification.id == id);
//     // Update local storage if needed
//   }
//
//   void updateNotificationStatus(String id, bool isPending) {
//     final notification = _notifications.firstWhere((n) => n.id == id);
//     notification.isPending = isPending;
//     // Update local storage if needed
//   }
//
//   List<AppNotification> getPendingNotifications() {
//     return _notifications.where((notification) => notification.isPending).toList();
//   }
//
//   List<AppNotification> getAllNotifications() {
//     return _notifications;
//   }
// }
//

// class NotificationService extends GetxService {
//   static NotificationService get instance => Get.find();
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initializeNotifications();
//   }
//
//   Future<void> _initializeNotifications() async {
//     await AwesomeNotifications().initialize(
//       'resource://drawable/res_app_icon',
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic Notifications',
//           channelDescription: 'Notification channel for basic notifications',
//           defaultColor: KColors.primary,
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//         ),
//         // Add other channels for specific types of notifications here
//         NotificationChannel(
//           channelKey: 'reminder_channel',
//           channelName: 'Reminder Notifications',
//           channelDescription: 'Notification channel for reminders',
//           defaultColor: KColors.secondary,
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//         ),
//       ],
//       channelGroups: [
//         NotificationChannelGroup(
//           channelGroupKey: 'reminder_channel_group',
//           channelGroupName: 'Reminder Channel Group',
//         ),
//       ],
//     );
//
//     bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isNotificationAllowed) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   }
//
//   Future<void> createNotification({
//     required String title,
//     required String body,
//     String? channelKey,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//         channelKey: channelKey ?? 'basic_channel',
//         title: title,
//         body: body,
//       ),
//     );
//   }
//
//   Future<void> showNotification(String title, String body, {String? channelKey}) async {
//     await createNotification(
//       title: title,
//       body: body,
//       channelKey: channelKey,
//     );
//   }
//
//   int createUniqueId() {
//     return DateTime.now().millisecondsSinceEpoch.remainder(100000);
//   }
//
//   Future<void> showReminderNotification(String title, String body) async {
//     await createNotification(
//       title: title,
//       body: body,
//       channelKey: 'reminder_channel',
//     );
//   }
//
// //get all notifications from AwesomeNotifications
// // Future<List<ReceivedNotification>> getAllNotifications() async {
// //   var notifications = await AwesomeNotifications().getNotifications();
// //   return notifications;
// // }
//
// }


// import 'package:awesome_notifications/awesome_notifications.dart';
// import 'package:get/get.dart';
// import '../../../utils/constants/colors.dart';
//
// class NotificationService extends GetxService {
//   static NotificationService get instance => Get.find();
//
//   Future<NotificationService> init() async {
//     await _initializeNotifications();
//     return this;
//   }
//
//   Future<void> _initializeNotifications() async {
//     await AwesomeNotifications().initialize(
//       'resource://drawable/res_app_icon',
//       [
//         NotificationChannel(
//           channelKey: 'reminder_channel',
//           channelName: 'Reminder Notifications',
//           channelDescription: 'Notification channel for reminders',
//           defaultColor: KColors.primary,
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//           importance: NotificationImportance.High,
//         ),
//         NotificationChannel(
//           channelKey: 'quote_channel',
//           channelName: 'Daily Quote Notifications',
//           channelDescription: 'Notification channel for daily quotes',
//           defaultColor: KColors.primary,
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//           importance: NotificationImportance.High,
//         ),
//         NotificationChannel(
//           channelKey: 'milestone_channel',
//           channelName: 'Milestone Notifications',
//           channelDescription: 'Notification channel for milestones',
//           defaultColor: KColors.primary,
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//           importance: NotificationImportance.High,
//         ),
//         NotificationChannel(
//           channelKey: 'insight_channel',
//           channelName: 'Insight Notifications',
//           channelDescription: 'Notification channel for insights',
//           defaultColor: KColors.primary,
//           ledColor: KColors.white,
//           playSound: true,
//           enableVibration: true,
//           importance: NotificationImportance.High,
//         ),
//
//       ],
//     );
//
//     bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
//     if (!isNotificationAllowed) {
//       AwesomeNotifications().requestPermissionToSendNotifications();
//     }
//   }
//
//   Future<void> createNotification({
//     required String title,
//     required String body,
//     String? channelKey,
//   }) async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
//         channelKey: channelKey ?? 'reminder_channel',
//         title: title,
//         body: body,
//       ),
//     );
//   }
//
//   Future<void> showNotification(String title, String body, {String? channelKey}) async {
//     await createNotification(
//       title: title,
//       body: body,
//       channelKey: channelKey,
//     );
//   }
// }

import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import '../../../utils/constants/colors.dart';

class NotificationService extends GetxService {
  static NotificationService get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  Future<NotificationService> init() async {
    return this;
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic Notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: KColors.white,
          playSound: true,
          enableVibration: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic Channel Group',
        ),
      ],
    );
    bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isNotificationAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> showNotification({required String title, required String body}) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}
