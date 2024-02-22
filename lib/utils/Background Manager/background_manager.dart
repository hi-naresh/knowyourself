import 'dart:math';
import 'dart:ui';

import 'package:knowyourself/notification%20manager/notification_manager.dart';
import 'package:knowyourself/utils/affirmations.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:workmanager/workmanager.dart';

class BackGroundManager {
  static void init() {
    Workmanager().registerPeriodicTask(
      "quote-notification",
      "QuoteNotification",
      frequency: const Duration(minutes: 15),
    );
  }

  @pragma('vm:entry-point')
  static callbackDispatcher() {
    DartPluginRegistrant.ensureInitialized();
    Workmanager().executeTask((task, inputData) {
      final now = DateTime.now();
      final start = DateTime(now.year, now.month, now.day, 9);
      final end = DateTime(now.year, now.month, now.day, 21); // 9 pm

      if (now.isAfter(start) &&
          now.isBefore(end) &&
          SharedPreferencesHelper.getNotificationPermission()) {
        final random = Random();
        final index = random.nextInt(affirmations.length);
        String quote = affirmations[index];
        NotificationManager.showNotification(title: "Never Forget", body: quote);
      }

      return Future.value(true);
    });
  }
}
