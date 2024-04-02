import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationService extends GetxService {
  static NotificationService get instance => Get.find();

  @override
  void onInit() {
    super.onInit();
    _initializeNotifications();
  }

  Future<NotificationService> init() async {
    // Initial setup or fetching necessary data for notifications
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
          ledColor: Colors.white,
          playSound: true,
          enableVibration: true,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic Channel Group',),
      ],
    );
    bool isNotificationAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isNotificationAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  }

  Future<void> createNotification({
    required String title,
    required String body,
    String? channelKey,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: channelKey ?? 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }

  createUniqueId() {
    // Generate a unique ID for the notification
    final int uniqueId = DateTime.now().millisecondsSinceEpoch.remainder(100000);
    return uniqueId;
  }

  // Example notification service method to show a notification
  Future<void> showNotification(String title, String body) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: createUniqueId(), // A unique ID for this notification
        channelKey: 'basic_channel', // Ensure this channel is initialized
        title: title,
        body: body,
      ),
    );
  }

}
