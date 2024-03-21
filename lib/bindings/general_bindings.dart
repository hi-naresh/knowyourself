import 'package:get/get.dart';

import '../data/services/notifications/notification_service.dart';
class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    // Get.put(NetworkManager());
    // Get.put(NotificationService());
    Get.lazyPut<NotificationService>(() => NotificationService());
  }
}