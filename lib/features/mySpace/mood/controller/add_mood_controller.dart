import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/repo/space/mood/mood_repo.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';
import 'package:knowyourself/routes.dart';
import '../../../../data/services/mood_shifter/model_service.dart';
import '../model/activity_model.dart';
import '../screens/add_mood/widgets/aspect_select.dart';
import '../screens/add_mood/widgets/express_feelings.dart';
import '../screens/add_mood/widgets/mood_select.dart';

class AddMoodController extends GetxController {

  static AddMoodController get instance => Get.find();

  final RxInt index = 0.obs;
  final PageController pageController = PageController();

  final Rx<MoodModel?> moodModel = Rx<MoodModel?>(null);

  final MoodRepo _moodRepo = Get.put(MoodRepo());
  //mood
  RxDouble sliderValue = 0.0.obs;
  // use this for int values - (controller.sliderValue.value * 10).round()

  final RxList activitiesTitle = [].obs;

  final List<AnimatedEmoji> emojis = List.generate(10, (index) =>
      AnimatedEmoji(
        AnimatedEmojis.values[index],
        size: 40,
        repeat: true,
      )
  );
  String get moodString => emojis[(sliderValue.value * 10).round() % 10].emoji.name;


  @override
  Future<void> onInit() async {
    await Get.find<ModelService>().onInit(); // Make sure ModelService is initialized
    await Get.find<MoodRepo>().onInit(); // Make sure MoodRepo is initialized
    super.onInit();
  }

  RxInt selectAspect = 0.obs;
  List<String> aspectsList = ['Mental', 'Physical', 'Vital', 'Spiritual'];

  //get aspect from index
  String get aspectString => aspectsList[selectAspect.value];
  RxInt selectHappenedAt = 0.obs; //0 for social, 1 for work, 2 for home, 3 for personal
  final happenedAt = ['Social', 'Work', 'Home', 'Personal'];
  //get happenedAt from index
  String get happenedAtString => happenedAt[selectHappenedAt.value];
  final TextEditingController reasons = TextEditingController();

  final List<Widget> journalPages = [
    const AspectSelectPage(),
    const MoodSelectPage(),
    const ExpressFeelingsPage(),
    // const MoodSummaryPage(readOnly: false),
  ];

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void jumpToPage( index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut
    );
  }

  void previousPage() {
    if (pageController.page!.round() > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn);
    } else {
      Get.back();
    }
  }

  void showSummary( mood) {
    //other data also
    mood.value = mood;
  }

  void sendDetails() {
    //send all data to server
  }

  void updateMoodJournal( moodModel) {
    //update all data
    moodModel.value = moodModel;
  }

  void clearMoodJournalData() {
    reasons.clear();
  }

  void saveMoodData() {
    _moodRepo.saveMoodModel(MoodModel(
      mood: moodString,
      aspect: aspectString,
      description: reasons.text,
      happenedAt: happenedAtString, id: '', createdOn: DateTime.now(),
    ));

    Get.back();
  }

  Future<void> shiftMood() async {
    try {
      // Ensure the model service is already initialized and accessible via Get.put or Get.find
      // final ModelService modelService = Get.find<ModelService>();
      //
      // Create a MoodModel instance from the current state
      MoodModel currentMood = MoodModel(
        mood: moodString,
        aspect: aspectString,
        description: reasons.text,
        happenedAt: happenedAtString,
        id: '',  // Ensure you have a valid ID if necessary
        createdOn: DateTime.now(),
      );

      // Use the repository to recommend activities based on the current mood
      List<String> userActivities = await _moodRepo.recommendActivity(currentMood);

      // Assign activities to the observable list to update the UI or further processing
      activitiesTitle.assignAll(userActivities);
      print('Recommended activities: $userActivities');
      print(activitiesTitle);

      // Optionally, you can handle the navigation or any follow-up actions here
      if (userActivities.isNotEmpty) {
        // Navigate or display activities
        Get.toNamed(KRoutes.getActivitiesRoute());
      } else {
        Get.snackbar('No Activities Found', 'No recommended activities based on your current mood.');
      }
    } catch (e) {
      // Handle any errors that might occur during the process
      print('Error in shifting mood: $e');
      Get.snackbar('Error', 'Failed to shift mood due to an error.');
    }
  }

  // Future<void> shiftMood() async {
  //   final modelService = Get.put(ModelService());
  //   // await modelService.onInit();
  //
  //   // Then call the method
  //   final userActivities = _moodRepo.recommendActivity(
  //       MoodModel(
  //         mood: moodString,
  //         aspect: aspectString,
  //         description: reasons.text,
  //         happenedAt: happenedAtString,
  //         id: '', createdOn: DateTime.now(),
  //       ));
  //
  //   // print all activities
  //   for (var activity in activities) {
  //     activities.add(userActivities);
  //
  //   }
  //
  //
  //
  //
  // }

  deFocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

}
