import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';

import '../model/activity_info_model.dart';


class ActivityController extends GetxController{
  static ActivityController get instance =>Get.find();

  RxList activitiesLoad = <ActivityModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadActivities();
  }

  //demo
  final List<ActivityModel> activities = [
    // Activity(title: 'Go for a walk in nature', duration: '10 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp1),
    // Activity(title: 'Do a dance party by yourself', duration: '15 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp2),
    // Activity(title: 'Paint something', duration: '15 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp3),
    // Activity(title: 'Eat a dessert', duration: '15 min', imageUrl: 'assets/illustrations/physical.svg', color: kApp4),
    ActivityModel(id: "1", userId: "1", title: "Deep Breadth",
        imageUrl: KImages.health3,

        instructions: ''' Find a quiet spot, sit or lie comfortably, close your eyes.
Place one hand on your belly, the other on your chest.
Take a normal breath.
Inhale slowly through your nose, feel your belly rise.
Hold your breath briefly.
Exhale slowly through your mouth, feel your belly fall.
Repeat for a calming rhythm.
Imagine inhaling relaxation, exhaling stress.
Picture calmness spreading with each inhale, tension leaving with each exhale.
Deep breathe for 10 mins, increase gradually to 15-20 for maximum relaxation.''',
        link: "https://www.webmd.com/parenting/how-to-deep-breathe"),
    ActivityModel(id: "2", userId: "2", title: "Spend time in nature ",
        imageUrl: KImages.health8,
        instructions: '''Take a stroll in a park or nature area, observe trees, flowers, and animals.
Engage in conservation efforts, like gardening or local green projects.
Find activities suitable for your mobility level and area.
If accessing nature is tough, explore tips on overcoming barriers. ''',
        link: "https://www.mind.org.uk/information-support/tips-for-everyday-living/relaxation/relaxation-tips/"),
  ];

  void loadActivities() {
    // activities.addAll(
    //
    // );
  }
}