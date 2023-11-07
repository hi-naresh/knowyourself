import 'package:timezone/timezone.dart' as tz;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManger {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<NotificationDetails> _reminderNotificationsDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id 1",
        "Reminders",
        importance: Importance.max,
      ),
    );
  }

  static Future<NotificationDetails> _quotesNotificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id 2",
        "Quotes",
        importance: Importance.max,
      ),
    );
  }

  static Future init({bool initSchedule = false}) async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/not_launcher");
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings);

    await _notification.initialize(initializationSettings);
  }

  // static Future<void> scheduleNotification() async {
  //   const int intervalHours = 2;
  //   final now = DateTime.now();
  //   final notificationTime = DateTime(
  //       now.year, now.month, now.day, 9); // set notification time to 9:00 am
  //   final endTime =
  //       DateTime(now.year, now.month, now.day, 21); // set end time to 9:00 pm

  //   if (now.isAfter(notificationTime) && now.isBefore(endTime)) {
  //     const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //         AndroidNotificationDetails("channel id 5", "periodic notification",
  //             importance: Importance.max, priority: Priority.high);

  //     const NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       android: androidPlatformChannelSpecifics,
  //     );

  //     await _notification.periodicallyShow(
  //       0,
  //       'My Notification Title',
  //       'My Notification Body',
  //       RepeatInterval.hourly,
  //       platformChannelSpecifics,
  //     );
  //   }
  // }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    return _notification.show(
      id,
      title,
      body,
      await _quotesNotificationDetails(),
      payload: payload,
    );
  }

  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async {
    return _notification.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.UTC),
      await _reminderNotificationsDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }

  static Future showNotificationDaily({
    int id = 0,
    required String title,
    required String body,
    String? payload,
    required Time time,
  }) async {
    return _notification.zonedSchedule(
      id,
      title,
      body,
      _scheduleTime(time),
      await _reminderNotificationsDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  static Future cancelNotificationDaily({
    int id = 0,
  }) async {
    return _notification.cancel(id);
  }

  static tz.TZDateTime _scheduleTime(Time time) {
    final DateTime scheduledDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
    );

    final scheduleDate = tz.TZDateTime.from(scheduledDate, tz.local);
    return scheduleDate.isBefore(DateTime.now())
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }
}
