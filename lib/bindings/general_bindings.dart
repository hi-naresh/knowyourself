import 'package:get/get.dart';
import 'package:knowyourself/data/repo/space/story/story_repo.dart';
import 'package:knowyourself/data/services/mood_shifter/model_service.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';

import '../data/helper_service/backup_service/backup_service.dart';
import '../data/helper_service/local_auth/local_bio_auth.dart';
import '../data/helper_service/notifications/notification_service.dart';
import '../data/services/quotes/quote_service.dart';
import '../features/mySpace/milestones/controller/milestone_controller.dart';
import '../features/personalisation/controller/profile_setup_controller.dart';
class GeneralBindings extends Bindings{

  @override
  void dependencies() {
    // Get.put(NetworkManager());
    // Get.put(NotificationService());
    Get.lazyPut<NotificationService>(() => NotificationService(),fenix: true);
    // Get.lazyPut<ArticleController>(() => ArticleController());
    Get.lazyPut(() => UserController(), fenix: true);
    Get.lazyPut(() => BackupService(), fenix: true);
    Get.lazyPut(() => LocalBioAuth(),fenix: true);
    Get.lazyPut(() => QuoteService(), fenix: true);
    Get.lazyPut(() => StoryRepo(), fenix: true);
    Get.lazyPut(() => MilestoneController(),fenix: true);
    Get.lazyPut(() => ProfileSetupController(),fenix: true);
    Get.lazyPut(() => ModelService(),fenix: true);

  }
}