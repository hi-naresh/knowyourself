import 'package:get/get.dart';

import '../data/services/notifications/notification_service.dart';
import '../features/learning/controller/article_controller.dart';
class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    // Get.put(NetworkManager());
    // Get.put(NotificationService());
    Get.lazyPut<NotificationService>(() => NotificationService());
    Get.lazyPut<ArticleController>(() => ArticleController());

  }
}