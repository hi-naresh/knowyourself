import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';

import '../screens/add_mood/widgets/aspect_select.dart';
import '../screens/add_mood/widgets/express_feelings.dart';
import '../screens/add_mood/widgets/mood_select.dart';
import '../screens/add_mood/widgets/mood_shift.dart';
import '../screens/add_mood/widgets/mood_summary.dart';

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


  RxInt selectAspect = 0.obs;
  List<String> aspectsList = ['Mental', 'Physical', 'Vital', 'Spiritual'];

  RxInt selectHappenedAt = 0.obs; //0 for social, 1 for work, 2 for home, 3 for personal
  final happenedAt = ['Social', 'Work', 'Home', 'Personal'];
  final TextEditingController reasons = TextEditingController();

  final List<Widget> journalPages = [
    const MoodSelectPage(),
    const AspectSelectPage(),
    const ExpressFeelingsPage(),
    const MoodSummaryPage(readOnly: false),
  ];

  //intialize read-only mode if needed in future
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.moodModel == null) {
  //     moodModel =
  //         Provider.of<JournalEditorProvider>(context, listen: false).journal!;
  //   } else {
  //     moodModel = widget.moodModel!;
  //   }
  // }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
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

  void updateJournal( moodModel) {
    //update all data
    moodModel.value = moodModel;
  }

  void clearJournalData() {
    // clear mood, aspect, reasons, happenedAt
    reasons.clear();
  }

  void saveMoodData() {
    // Provider.of<JournalEditorProvider>(context, listen: false).updateIndex(0);
    // Provider.of<JournalProvider>(context, listen: false)
    //     .updateJournalList(moodModel);
    // Provider.of<PointsProvider>(context, listen: false)
    //     .setScore(point: kAddJournalPoint);
    // Provider.of<JournalEditorProvider>(context, listen: false)
    //     .clearJournalData();
    // Navigator.pop(context);
  }

  void shiftMood() {
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => MoodShift()));
    Get.to(() => MoodShiftPage());
  }

// void getIndexOfPage() {
//    index.value = pageController.page?.round() ?? 0;
// }

// void updateIndex( index) {
//   index.value = index;
//   pageController.animateToPage(index,
//       duration: const Duration(milliseconds: 200), curve: Curves.linear);
// }
}
