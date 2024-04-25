import 'package:workmanager/workmanager.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Execute different tasks based on the task name
    switch (task) {
      case 'scheduleNotification':
      // Code to handle notification scheduling
      // This might involve calling another service or utility to manage notifications
        break;
    }
    return Future.value(true);
  });
}


//Usage in any controller
// void scheduleBackgroundTask() {
//   Workmanager().registerOneOffTask(
//     'uniqueName',
//     'scheduleNotification',
//     inputData: {'title': 'Hello', 'body': 'World'}, // Data passed to the background task
//   );
// }
