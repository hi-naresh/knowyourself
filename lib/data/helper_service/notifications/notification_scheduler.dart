import 'package:get/get.dart';
import 'package:workmanager/workmanager.dart';
import '../background_scheduler/background_service.dart';

// class NotificationScheduler extends GetxService {
//   void scheduleAllNotifications() {
//     // Daily Check-In Notification at 4 PM
//     BackgroundService.scheduleNotificationTask(
//       'checkInReminder',
//       'Check-In Reminder',
//       'How are you feeling today?',
//       Duration(hours: 16), // 4 PM
//     );
//
//     // Daily Day Checkout Notification at 10 PM
//     BackgroundService.scheduleNotificationTask(
//       'dayCheckoutReminder',
//       'Day Checkout Reminder',
//       'Don’t forget to reflect on your day!',
//       Duration(hours: 22), // 10 PM
//     );
//
//     // Insights Notification every 2 days at 8 PM
//     BackgroundService.scheduleRecurringNotificationTask(
//       'insightsReminder',
//       'Insights Reminder',
//       'Check your insights and see your progress!',
//       Duration(days: 2, hours: 20), // Every 2 days at 8 PM
//     );
//
//     // Daily Quote Notification at 10 AM
//     BackgroundService.scheduleNotificationTask(
//       'dailyQuoteReminder',
//       'Daily Quote',
//       'Here’s your daily dose of inspiration!',
//       Duration(hours: 10), // 10 AM
//     );
//
//     // Daily Milestone Notification at 9 PM
//     BackgroundService.scheduleNotificationTask(
//       'milestoneReminder',
//       'Milestone Reminder',
//       'Reflect on your achievements today!',
//       Duration(hours: 21), // 9 PM
//     );
//
//     // Gratitude Notification at 9:30 PM
//     BackgroundService.scheduleNotificationTask(
//       'gratitudeReminder',
//       'Gratitude Reminder',
//       'Take a moment to be grateful today!',
//       Duration(hours: 21, minutes: 30), // 9:30 PM
//     );
//
//     // Unsolved Questions Notification at specified times (daily, weekly, monthly)
//     BackgroundService.scheduleNotificationTask(
//       'dailyQuestionReminder',
//       'Daily Question',
//       'Reflect on today’s question!',
//       Duration(hours: 18), // Example time: 6 PM daily
//     );
//
//     // Story Progress Notification every Sunday at 12 PM
//     BackgroundService.scheduleNotificationTask(
//       'storyProgressReminder',
//       'Story Progress',
//       'How far have you progressed in your story?',
//       Duration(days: 7, hours: 12), // Every Sunday at 12 PM
//     );
//   }
//
//   void clearAllScheduledTasks() async {
//     await Workmanager().cancelAll();
//   }
// }
//
// import 'package:get/get.dart';
// import 'package:workmanager/workmanager.dart';
// import '../../data/helper_service/background_scheduler/background_service.dart';

// class NotificationScheduler {
//   static final NotificationScheduler _instance = NotificationScheduler._internal();
//
//   factory NotificationScheduler() {
//     return _instance;
//   }
//
//   NotificationScheduler._internal();
//
//   void scheduleCheckInNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'check_in',
//       'Check-In Reminder',
//       'Please remember to add your mood entry by 4 PM.',
//       _calculateInitialDelay(16, 0), // 4:00 PM
//     );
//   }
//
//   void scheduleDayCheckoutNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'day_checkout',
//       'Day Checkout Reminder',
//       'Remember to complete your journal entry by 10 PM.',
//       _calculateInitialDelay(22, 0), // 10:00 PM
//     );
//   }
//
//   void scheduleInsightNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'insight_notification',
//       'Insights Reminder',
//       'Review your insights every 2 days.',
//       _calculateInitialDelay(20, 0), // 8:00 PM every 2 days
//     );
//   }
//
//   void scheduleQuoteNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'daily_quote',
//       'Daily Quote',
//       'Here is your daily quote!',
//       _calculateInitialDelay(10, 0), // 10:00 AM
//     );
//   }
//
//   void scheduleMilestoneNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'milestone_notification',
//       'Milestone Reminder',
//       'Review your milestones at 9 PM.',
//       _calculateInitialDelay(21, 0), // 9:00 PM
//     );
//   }
//
//   void scheduleGratitudeNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'gratitude_notification',
//       'Gratitude Reminder',
//       'Take a moment to note what you\'re grateful for today.',
//       _calculateInitialDelay(21, 30), // 9:30 PM
//     );
//   }
//
//   void scheduleUnsolvedQuestionsNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'unsolved_questions',
//       'Unsolved Questions Reminder',
//       'Review your unsolved questions daily, weekly, or monthly.',
//       _calculateInitialDelay(18, 0), // 6:00 PM
//     );
//   }
//
//   void scheduleStoryProgressNotification() {
//     BackgroundService.scheduleNotificationTask(
//       'story_progress',
//       'Story Progress',
//       'Reflect on your story progress every Sunday at 12 PM.',
//       _calculateInitialDelay(12, 0), // 12:00 PM Sunday
//     );
//   }
//
//   Duration _calculateInitialDelay(int targetHour, int targetMinute) {
//     final now = DateTime.now();
//     final targetTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       targetHour,
//       targetMinute,
//     );
//
//     if (targetTime.isBefore(now)) {
//       return targetTime.add(Duration(days: 1)).difference(now);
//     } else {
//       return targetTime.difference(now);
//     }
//   }
// }
//
// import 'package:get/get.dart';
//
// class NotificationScheduler {
//   static final NotificationScheduler _instance = NotificationScheduler._internal();
//
//   factory NotificationScheduler() {
//     return _instance;
//   }
//
//   NotificationScheduler._internal();
//
//   void scheduleCheckInNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'checkInNotification',
//       uniqueName: 'check_in',
//       delay: _calculateInitialDelay(0, 1), // 4:00 PM
//     );
//   }
//
//   void scheduleDayCheckoutNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'dayCheckoutNotification',
//       uniqueName: 'day_checkout',
//       delay: _calculateInitialDelay(9, 26), // 10:00 PM
//     );
//   }
//
//   void scheduleInsightNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'insightNotification',
//       uniqueName: 'insight_notification',
//       delay: _calculateInitialDelay(20, 0), // 8:00 PM every 2 days
//     );
//   }
//
//   void scheduleQuoteNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'quoteNotification',
//       uniqueName: 'quote_notification',
//       delay: _calculateInitialDelay(10, 0), // 10:00 AM every day
//     );
//   }
//
//   void scheduleMilestoneNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'milestoneNotification',
//       uniqueName: 'milestone_notification',
//       delay: _calculateInitialDelay(21, 0), // 9:00 PM daily, weekly, monthly
//     );
//   }
//
//   void scheduleGratitudeNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'gratitudeNotification',
//       uniqueName: 'gratitude_notification',
//       delay: _calculateInitialDelay(21, 30), // 9:30 PM daily
//     );
//   }
//
//   void scheduleUnsolvedQuestionsNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'unsolvedQuestionsNotification',
//       uniqueName: 'unsolved_questions_notification',
//       delay: _calculateInitialDelay(9, 0), // Custom timing based on user settings
//     );
//   }
//
//   void scheduleStoryProgressNotification() {
//     BackgroundService.scheduleNotificationTask(
//       taskName: 'storyProgressNotification',
//       uniqueName: 'story_progress_notification',
//       delay: _calculateInitialDelay(12, 0), // 12:00 PM every Sunday
//     );
//   }
//
//   Duration _calculateInitialDelay(int targetHour, int targetMinute) {
//     final now = DateTime.now();
//     final targetTime = DateTime(
//       now.year,
//       now.month,
//       now.day,
//       targetHour,
//       targetMinute,
//     );
//
//     if (targetTime.isBefore(now)) {
//       return targetTime.add(Duration(days: 1)).difference(now);
//     } else {
//       return targetTime.difference(now);
//     }
//   }
// }

import 'package:workmanager/workmanager.dart';

class NotificationScheduler {
  static void scheduleCheckInNotification() {
    Workmanager().registerOneOffTask(
      'checkInNotificationTask',
      'checkInNotification',
      initialDelay: Duration(hours: 4), // Schedules at 4 PM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleDayCheckoutNotification() {
    Workmanager().registerOneOffTask(
      'dayCheckoutNotificationTask',
      'dayCheckoutNotification',
      initialDelay: Duration(hours: 10), // Schedules at 10 PM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleInsightsNotification() {
    Workmanager().registerOneOffTask(
      'insightsNotificationTask',
      'insightsNotification',
      initialDelay: Duration(hours: 20), // Schedules at 8 PM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleDailyQuoteNotification() {
    Workmanager().registerOneOffTask(
      'dailyQuoteNotificationTask',
      'dailyQuoteNotification',
      initialDelay: Duration(hours: 10), // Schedules at 10 AM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleMilestoneNotification() {
    Workmanager().registerOneOffTask(
      'milestoneNotificationTask',
      'milestoneNotification',
      initialDelay: Duration(hours: 21), // Schedules at 9 PM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleGratitudeNotification() {
    Workmanager().registerOneOffTask(
      'gratitudeNotificationTask',
      'gratitudeNotification',
      initialDelay: Duration(hours: 21, minutes: 30), // Schedules at 9:30 PM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleUnsolvedQuestionsNotification() {
    Workmanager().registerOneOffTask(
      'unsolvedQuestionsNotificationTask',
      'unsolvedQuestionsNotification',
      initialDelay: Duration(days: 1), // Schedules daily
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }

  static void scheduleStoryProgressNotification() {
    Workmanager().registerOneOffTask(
      'storyProgressNotificationTask',
      'storyProgressNotification',
      initialDelay: Duration(days: 7, hours: 12), // Schedules weekly at 12 PM
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }
}
