import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:workmanager/workmanager.dart';

import '../notifications/notification_service.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {

    switch (task) {
      case 'dailyCheckOutReminder':
      // Check if the user has made their journal entry today
        if (checkIfJournalNotLogged()) {
          Get.find<NotificationService>().createNotification(
              title: "Time to complete your daily journal!",
              body: "Tap here to make your entry.",
              channelKey: "checkout_channel"
          );
        }
        break;
      default:
        print("No task available for key $task");
        break;
    }
    return Future.value(true);  // Indicates successful execution of the task
  });
}

bool checkIfJournalNotLogged() {
  // Implement checking logic
  final GetStorage storage =GetStorage();
  final entry = storage.read('journalEntries');
  //check last entry date and compare with today date
  entry.forEach((element) {
    if (element['entryDate'] == DateTime.now().toString().substring(0, 10)) {
      return false;
    }
  });
  return true;
}

void scheduleBackgroundTask(){
  Workmanager().registerPeriodicTask(
    "1",
    "dailyCheckInReminder",
    frequency: const Duration(hours: 24),
    initialDelay: Duration(hours: KHelper.tillNextNoon()),  // Calculate time till next noon
  );

  Workmanager().registerPeriodicTask(
    "2",
    "dailyCheckOutReminder",
    frequency: const Duration(hours: 24),
    initialDelay: Duration(hours: KHelper.tillNextEvening()),  // Calculate time till next 9:30 PM
  );
}
