// lib/data/models/notification_model.dart
enum NotificationType {
  Reminder,
  CheckIn,
  DayCheckOut,
  Insight,
  Quote,
  Milestone,
  Gratitude,
  UnsolvedQuestion,
  StoryProgress,
}

class AppNotification {
  final String id;
  final NotificationType type;
  final String title;
  final String body;
  final DateTime scheduledTime;
  late final bool isPending;

  AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.scheduledTime,
    this.isPending = true,
  });
}
