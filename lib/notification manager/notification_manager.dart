import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  static final _notification = FlutterLocalNotificationsPlugin();

  static Future<NotificationDetails> _taskCompletionNotificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "channel id 3", // Unique channel ID for task completion notifications
        "Task Completions", // Channel name
        importance: Importance.max,
      ),
    );
  }

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

  static Future showTaskCompletionNotification() async {
    const int notificationId = 1; // Unique ID for task completion notification
    const String title = 'Task Completed!';
    const String body = 'Great job! You completed a task from your to-do list.';

    return _notification.zonedSchedule(
      notificationId,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)), // Show after 5 seconds
      await _taskCompletionNotificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
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
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
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
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
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
