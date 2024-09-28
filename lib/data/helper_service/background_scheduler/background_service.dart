// import 'package:workmanager/workmanager.dart';
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) {
//     // Execute different tasks based on the task name
//     switch (task) {
//       case 'scheduleNotification':
//       // Code to handle notification scheduling
//       // This might involve calling another service or utility to manage notifications
//         break;
//     }
//     return Future.value(true);
//   });
// }
//
//
// Usage in any controller
// void scheduleBackgroundTask() {
//   Workmanager().registerOneOffTask(
//     'uniqueName',
//     'scheduleNotification',
//     inputData: {'title': 'Hello', 'body': 'World'}, // Data passed to the background task
//   );
// }


// lib/data/helper_service/background_scheduler/background_service.dart
// import 'package:get/get.dart';
// import '../notifications/notification_model.dart';
// import '../notifications/notification_service.dart';
//
// class NotificationScheduler {
//   final NotificationService _notificationService = Get.find<NotificationService>();
//
//   void initializeSchedules() {
//     // Schedule all necessary notifications
//     scheduleDailyQuote();
//     scheduleCheckInNotification();
//     // scheduleDayCheckoutNotification();
//     // scheduleInsightsNotification();
//     // scheduleMilestoneNotifications();
//     // scheduleGratitudeNotification();
//     // scheduleUnsolvedQuestionsNotification();
//     // scheduleStoryNotification();
//   }
//
//   void scheduleDailyQuote() {
//     final notification = AppNotification(
//       id: 'daily-quote',
//       type: NotificationType.Quote,
//       title: 'Daily Quote',
//       body: 'Here is your daily quote...',
//       scheduledTime: DateTime.now().add(Duration(hours: 24)), // Example timing logic
//     );
//     _notificationService.scheduleNotification(notification);
//   }
//
//   void scheduleCheckInNotification() {
//     final notification = AppNotification(
//       id: 'check-in',
//       type: NotificationType.CheckIn,
//       title: 'Check-In Reminder',
//       body: 'How are you feeling today?',
//       scheduledTime: DateTime.now().add(Duration(hours: 4)), // Example timing logic
//     );
//     _notificationService.scheduleNotification(notification);
//   }
//
// // Define similar methods for other notifications
// }

// // lib/data/helper_service/background_scheduler/background_service.dart
// import 'package:workmanager/workmanager.dart';
// import 'package:get/get.dart';
//
// import '../notifications/notification_service.dart';
//
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     try {
//       final NotificationService notificationService = Get.find();
//       switch (task) {
//         case 'sendNotification':
//           final title = inputData?['title'] ?? 'Notification Title';
//           final body = inputData?['body'] ?? 'Notification Body';
//           await notificationService.showNotification(title, body);
//           break;
//         case 'sendReminderNotification':
//           final title = inputData?['title'] ?? 'Reminder';
//           final body = inputData?['body'] ?? 'You have a reminder!';
//           await notificationService.showNotification(title, body, channelKey: 'reminder_channel');
//           break;
//         default:
//           print('Unknown task: $task');
//       }
//     } catch (e) {
//       print("Error executing task: $e");
//     }
//     return Future.value(true);
//   });
// }
//
// class BackgroundService {
//   static void initialize() {
//     Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
//   }
//
//   static void scheduleNotificationTask(
//       String id, String title, String body, Duration delay) async {
//     try {
//       await Workmanager().registerOneOffTask(
//         id,
//         'sendNotification',
//         inputData: {
//           'title': title,
//           'body': body,
//         },
//         initialDelay: delay,
//       );
//     } catch (e) {
//       print("Failed to schedule task: $e");
//     }
//   }
//
//   static void scheduleRecurringNotificationTask(
//       String id, String title, String body, Duration interval) async {
//     try {
//       await Workmanager().registerPeriodicTask(
//         id,
//         'sendNotification',
//         inputData: {
//           'title': title,
//           'body': body,
//         },
//         frequency: interval,
//       );
//     } catch (e) {
//       print("Failed to schedule task: $e");
//     }
//   }
//
//   static void cancelTask(String id) async {
//     await Workmanager().cancelByUniqueName(id);
//   }
//
//   static void cancelAllTasks() async {
//     await Workmanager().cancelAll();
//   }
//
// }

import 'package:workmanager/workmanager.dart';
import 'package:get/get.dart';
import '../notifications/notification_service.dart';

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     final NotificationService notificationService = Get.find();
//
//     switch (task) {
//       case 'checkInNotification':
//         await notificationService.showNotification(
//           'Check-In Reminder',
//           'Please remember to add your mood entry by 4 PM.',
//         );
//         break;
//       case 'dayCheckoutNotification':
//         await notificationService.showNotification(
//           'Day Checkout Reminder',
//           'Remember to complete your journal entry by 10 PM.',
//         );
//         break;
//       case 'insightNotification':
//         await notificationService.showNotification(
//           'Insights Reminder',
//           'Review your insights every 2 days at 8 PM.',
//         );
//         break;
//       case 'quoteNotification':
//         await notificationService.showNotification(
//           'Daily Quote',
//           'Here’s your quote for the day!',
//           channelKey: 'quote_channel',
//         );
//         break;
//       case 'milestoneNotification':
//         await notificationService.showNotification(
//           'Milestone Reminder',
//           'Check your progress for today, this week, and this month.',
//           channelKey: 'milestone_channel',
//         );
//         break;
//       case 'gratitudeNotification':
//         await notificationService.showNotification(
//           'Gratitude Reminder',
//           'Remember to note something you’re grateful for today!',
//         );
//         break;
//       case 'unsolvedQuestionsNotification':
//         await notificationService.showNotification(
//           'Unsolved Questions Reminder',
//           'Review your unsolved questions.',
//         );
//         break;
//       case 'storyProgressNotification':
//         await notificationService.showNotification(
//           'Story Progress Reminder',
//           'How far have you progressed in your story?',
//         );
//         break;
//       default:
//         print('Unknown task: $task');
//     }
//     return Future.value(true);
//   });
// }

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case 'checkInNotification':
        await NotificationService.instance.showNotification(
          title: "Check-in Reminder",
          body: "It's 4 PM, have you added your mood entry?",
        );
        break;
      case 'dayCheckoutNotification':
        await NotificationService.instance.showNotification(
          title: "Day Checkout Reminder",
          body: "It's 10 PM, don't forget to add your journal entry!",
        );
        break;
      case 'insightsNotification':
        await NotificationService.instance.showNotification(
          title: "Insights Reminder",
          body: "Check your insights now!",
        );
        break;
      case 'dailyQuoteNotification':
        await NotificationService.instance.showNotification(
          title: "Daily Quote",
          body: "Here's your quote for today!",
        );
        break;
      case 'milestoneNotification':
        await NotificationService.instance.showNotification(
          title: "Milestone Reminder",
          body: "Don't forget to check your milestones!",
        );
        break;
      case 'gratitudeNotification':
        await NotificationService.instance.showNotification(
          title: "Gratitude Reminder",
          body: "Take a moment to reflect on what you're grateful for.",
        );
        break;
      case 'unsolvedQuestionsNotification':
        await NotificationService.instance.showNotification(
          title: "Unsolved Questions",
          body: "You have some unanswered questions. Take a look!",
        );
        break;
      case 'storyProgressNotification':
        await NotificationService.instance.showNotification(
          title: "Story Progress",
          body: "How far have you progressed in your story?",
        );
        break;
    }

    return Future.value(true);
  });
}

class BackgroundService {
  static void initialize() {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  }

  static void scheduleNotificationTask({
    required String taskName,
    required String uniqueName,
    required Duration delay,
  }) async {
    try {
      await Workmanager().registerOneOffTask(
        uniqueName,
        taskName,
        initialDelay: delay,
        existingWorkPolicy: ExistingWorkPolicy.replace,
      );
    } catch (e) {
      print("Failed to schedule task: $e");
    }
  }

  static void cancelAllTasks() async {
    await Workmanager().cancelAll();
  }
}

