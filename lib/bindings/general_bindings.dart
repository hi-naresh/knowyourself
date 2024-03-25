import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';

import '../data/services/notifications/notification_service.dart';
import '../features/learning/controller/article_controller.dart';
class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    // Get.put(NetworkManager());
    // Get.put(NotificationService());
    Get.lazyPut<NotificationService>(() => NotificationService());
    Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut(() => UserController());

  }
}