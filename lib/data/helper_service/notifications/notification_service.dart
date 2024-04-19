import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../utils/constants/colors.dart';

class NotificationService extends GetxService {
  static NotificationService get instance => Get.find();
  final _storage = GetStorage();
  final _notificationLogKey = 'notification_logs';

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
          channelKey: 'basic_notifications',
          channelName: 'Basic Notifications',
          channelDescription: 'General notifications for KYB App',
          importance: NotificationImportance.High,
          defaultColor: const Color(0xFF9D50DD),
          ledColor: KColors.white,
        ),
        // NotificationChannel(
        //   channelKey: 'milestone_notifications',
        //   channelName: 'Milestone Notifications',
        //   channelDescription: 'Notifications for milestones',
        //   importance: NotificationImportance.High,
        //   defaultColor: Colors.blue,
        // ),
        NotificationChannel(
          channelKey: 'daily_notifications',
          channelName: 'Daily Milestone Notifications',
          channelDescription: 'Daily reminders for milestones',
          importance: NotificationImportance.High,
          defaultColor: Colors.blue,
        ),
        NotificationChannel(
          channelKey: 'weekly_notifications',
          channelName: 'Weekly Milestone Notifications',
          channelDescription: 'Weekly reminders for milestones',
          importance: NotificationImportance.High,
          defaultColor: Colors.green,
        ),
        NotificationChannel(
          channelKey: 'monthly_notifications',
          channelName: 'Monthly Milestone Notifications',
          channelDescription: 'Monthly reminders for milestones',
          importance: NotificationImportance.High,
          defaultColor: Colors.red,
        ),
        NotificationChannel(
          channelKey: 'mood_shift_notifications',
          channelName: 'Mood Shift Notifications',
          channelDescription: 'Notifications to confirm mood shifts',
          importance: NotificationImportance.High,
          defaultColor: Colors.green,
        ),
        NotificationChannel(
          channelKey: 'check_out_notifications',
          channelName: 'Check-Out Notifications',
          channelDescription: 'Notifications to remind user to make journal entries',
          importance: NotificationImportance.High,
          defaultColor: Colors.red,
        ),
      ],
    );
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isNotificationAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  // Future<void> createScheduledNotification({
  //   required String title,
  //   required String body,
  //   required String channelKey,
  //   required DateTime scheduledTime,
  // }) async {
  //   await AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: createUniqueId(),
  //       channelKey: channelKey,
  //       title: title,
  //       body: body,
  //     ),
  //     schedule: NotificationCalendar.fromDate(date: scheduledTime),
  //   );
  //   logNotification( createUniqueId(), title, body, scheduledTime, 'scheduled');
  // }

  Future<void> createScheduledNotification({
    required String title,
    required String body,
    required String channelKey,
    required DateTime scheduledTime,
    String? payloadKey, // Optional payload to determine navigation
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: channelKey,
        title: title,
        body: body,
        payload: {'destination': payloadKey}, // Use this payload to navigate
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledTime),
    );
    logNotification( createUniqueId(), title, body, scheduledTime, 'scheduled');
  }


  int createUniqueId()=> DateTime.now().millisecondsSinceEpoch.remainder(100000);

  // Method to handle periodic notifications for weekly analysis, etc.
  Future<void> createPeriodicNotification({
    required String title,
    required String body,
    required String channelKey,
    required int interval, // in days
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: channelKey,
        title: title,
        body: body,
      ),
      schedule: NotificationInterval(interval: interval, repeats: true),
    );
  }

  void createNotification({required String title, required String body, required String channelKey}) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(),
        channelKey: channelKey,
        title: title,
        body: body,
      ),
    );
  }

  // void listenToNotificationTap() {
  //   AwesomeNotifications().actionStream.listen((receivedNotification) {
  //     String? destination = receivedNotification.payload?['destination'];
  //
  //     if (destination != null) {
  //       // Navigate based on the destination payload
  //       switch (destination) {
  //         case 'add_mood_page':
  //           Get.to(() => AddMoodPage());  // Using GetX for navigation
  //           break;
  //         case 'journal_page':
  //           Get.to(() => JournalPage());
  //           break;
  //         default:
  //           Get.to(() => HomePage());
  //       }
  //     }
  //   });
  // }

  // void logNotification(notificationId, String title, String body, DateTime scheduledTime, String s) {
  //   final log = {
  //     'id': notificationId,
  //     'title': title,
  //     'body': body,
  //     'scheduledTime': scheduledTime,
  //     'type': s,
  //   };
  //   final logs = _storage.read(_notificationLogKey) ?? [];
  //   logs.add(log);
  //   _storage.write(_notificationLogKey, logs);
  // }

  void logNotification(int id, String title, String body, DateTime time, String status) {
    List<dynamic> logs = _storage.read(_notificationLogKey) ?? [];
    logs.add({
      'id': id,
      'title': title,
      'body': body,
      'time': time.toIso8601String(),
      'status': status,
    });
    _storage.write(_notificationLogKey, logs);
  }

  List<Map<String, dynamic>> getNotificationLogs() {
    return (_storage.read(_notificationLogKey) ?? []).cast<Map<String, dynamic>>();
  }

  clearNotificationLogs() {
    _storage.remove(_notificationLogKey);
  }

  Future<void> scheduleDailyNotifications() async {
    // Schedule Check-in Notification at 12 PM
    var now = DateTime.now();
    var checkInTime = DateTime(now.year, now.month, now.day, 12);
    if (now.isAfter(checkInTime)) {
      checkInTime = checkInTime.add(const Duration(days: 1)); // Schedule for the next day if today's time has passed
    }

    await createScheduledNotification(
      title: "Daily Check-In Reminder",
      body: "Don't forget to log your mood today!",
      channelKey: "check_out_notifications",
      scheduledTime: checkInTime,
    );

    // Schedule Check-out Notification at 9:30 PM
    var checkOutTime = DateTime(now.year, now.month, now.day, 07, 45);
    if (now.isAfter(checkOutTime)) {
      checkOutTime = checkOutTime.add(const Duration(days: 1)); // Schedule for the next day if today's time has passed
    }

    await createScheduledNotification(
      title: "Daily Check-Out Reminder",
      body: "Did you forget to make your journal entry today?",
      channelKey: "check_out_notifications",
      scheduledTime: checkOutTime,
    );
    print('Scheduled Daily Notifications');
  }
}
