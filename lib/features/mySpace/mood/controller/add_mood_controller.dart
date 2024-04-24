import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../screens/add_mood/widgets/aspect_select.dart';
import '../screens/add_mood/widgets/express_feelings.dart';
import '../screens/add_mood/widgets/mood_select.dart';

class AddMoodController extends GetxController {

  static AddMoodController get instance => Get.find();

  final RxInt index = 0.obs;
  final PageController pageController = PageController();

  final Rx<MoodModel?> moodModel = Rx<MoodModel?>(null);

  //mood
  RxDouble sliderValue = 0.0.obs;
  // use this for int values - (controller.sliderValue.value * 10).round()
  final List<AnimatedEmoji> emojis = List.generate(10, (index) =>
      AnimatedEmoji(
        AnimatedEmojis.values[index],
        size: 40,
        repeat: true,
      )
  );
  String get moodString => emojis[(sliderValue.value * 10).round() % 10].emoji.name;


  RxInt selectAspect = 0.obs;
  List<String> aspectsList = ['Mentally\n ${KTexts.mentalDescription}', 'Physically\n ${KTexts.physicalDescription}', 'Emotionally\n ${KTexts.vitalDescription}', 'Spiritually\n ${KTexts.spiritualDescription}'];
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
    // const variousAspects(),
    const ExpressFeelingsPage(),
  ];

  // if aspectString == 'Mentally' {
  //   //do something
  //
  // } else if aspectString == 'Physically' {
  //   //do something
  // } else if aspectString == 'Emotionally' {
  //   //do something
  // } else if aspectString == 'Spiritually' {
  //   //do something
  // }

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
    mood.value = mood;
  }

  void sendDetails() {
    //send all data to server
  }

  void updateMoodJournal( moodModel) {
    moodModel.value = moodModel;
  }

  void clearMoodJournalData() {
    reasons.clear();
  }

  void saveMoodData() {
    Get.back();
  }

  void shiftMood() {
    Get.toNamed(KRoutes.getActivitiesRoute());
  }

  deFocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

}
