import 'package:get/get.dart';
import 'package:knowyourself/data/repo/space/activity/activity_repo.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';

import '../model/activity_info_model.dart';


class ActivityController extends GetxController{
  static ActivityController get instance =>Get.find();

  final activityRepo = Get.put(ActivityRepo());

  RxList<ActivityModel> activitiesLoaded = <ActivityModel>[].obs;



  @override
  Future<void> onInit() async {
    super.onInit();
    await loadActivities();
    Future.delayed(const Duration(seconds: 2), () => activitiesLoaded.refresh());
  }

  // final List<ActivityModel> activities = activitiesLoaded;

  //demo
  // final List<ActivityModel> activities = [
  //   ActivityModel(id: "1", userId: "1", title: "Deep Breadth",
  //     imageUrl: KImages.health3,
  //     color: kApp1,
  //     link: "https://www.webmd.com/parenting/how-to-deep-breathe",
  //     // instructions: ''' Find a quiet spot, sit or lie comfortably, close your eyes.
  //     //                     Place one hand on your belly, the other on your chest.
  //     //                     Take a normal breath.
  //     //                     Inhale slowly through your nose, feel your belly rise.
  //     //                     Hold your breath briefly.
  //     //                     Exhale slowly through your mouth, feel your belly fall.
  //     //                     Repeat for a calming rhythm.
  //     //                     Imagine inhaling relaxation, exhaling stress.
  //     //                     Picture calmness spreading with each inhale, tension leaving with each exhale.
  //     //                     Deep breathe for 10 mins, increase gradually to 15-20 for maximum relaxation.''',
  //   ),
  //   ActivityModel(id: "2", userId: "2", title: "Spend time in nature ",
  //     imageUrl: KImages.health8,
  //     color: kApp2,
  //     link: "https://www.mind.org.uk/information-support/tips-for-everyday-living/relaxation/relaxation-tips/",
  //     // instructions: '''Take a stroll in a park or nature area, observe trees, flowers, and animals.
  //     //                  Engage in conservation efforts, like gardening or local green projects.
  //     //                  Find activities suitable for your mobility level and area.
  //     //                  If accessing nature is tough, explore tips on overcoming barriers. ''',
  //   ),
  //   ActivityModel(id: "2", userId: "2", title: "Spend time in nature ",
  //     imageUrl: KImages.health8,
  //     color: kApp3,
  //     link: "https://www.mind.org.uk/information-support/tips-for-everyday-living/relaxation/relaxation-tips/",
  //     // instructions: '''Take a stroll in a park or nature area, observe trees, flowers, and animals.
  //     //                  Engage in conservation efforts, like gardening or local green projects.
  //     //                  Find activities suitable for your mobility level and area.
  //     //                  If accessing nature is tough, explore tips on overcoming barriers. ''',
  //   ),
  //   ActivityModel(id: "3", userId: "3", title: "Listen to music",
  //     imageUrl: KImages.health9,
  //     color: kApp4,
  //     link: "https://www.mind.org.uk/information-support/tips-for-everyday-living/relaxation/relaxation-tips/",
  //     // instructions: '''Create a playlist of calming music, nature sounds, or your favorite tunes.
  //     //                  Listen to music while relaxing, working, or doing chores.
  //     //                  Use headphones for a more immersive experience.
  //     //                  Experiment with different genres, tempos, and instruments.
  //     //                  Sing along, dance, or play an instrument for a more interactive experience.
  //     //                  Share music with friends, family, or online communities.
  //     //                  Explore music therapy or sound healing for deeper relaxation.''',
  //   )
  // ];



  Future<void> loadActivities() async {
    List<ActivityModel> activities = await activityRepo.getLastActivities();
    activitiesLoaded.assignAll(activities);
    activitiesLoaded.refresh();
  }
}