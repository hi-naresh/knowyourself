import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/aspect_select.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/express_feelings.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/mood_select_widget.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/mood_summary.dart';

import '../../controller/add_mood_controller.dart';

class AddMoodScreen extends StatelessWidget {
  const AddMoodScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    final  controllerHere = Get.put(AddMoodHereController());
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: controllerHere.journalPages,
      ),
    );
    // return Consumer<JournalEditorProvider>(
    //   builder: (BuildContext context, value, Widget? child) {
    //     _index = value.index;
    //     // return WillPopScope(
    //     //   onWillPop: () async {
    //     //     if (_index == 0) {
    //     //       value.clearJournalData();
    //     //       Navigator.pop(context);
    //     //
    //     //       return false;
    //     //     }
    //     //     _index -= 1;
    //     //     value.updateIndex(_index);
    //     //     return false;
    //     //   },
    //     //   child: PageView(
    //     //     physics: const NeverScrollableScrollPhysics(),
    //     //     controller: value.pageController,
    //     //     children: _journalPages,
    //     //   ),
    //     // );
    //     return Scaffold(
    //       body: PageView(
    //         physics: const NeverScrollableScrollPhysics(),
    //         controller: value.pageController,
    //         children: controller.journalPages,
    //       ),
    //     );
    //   },
    // );
  }
}

class AddMoodHereController extends GetxController{
  static AddMoodHereController get instance => Get.find();

  final RxInt index = 0.obs;

  int get currentPage => index.value;
  set currentPage(int value) => index(value);

  final List<Widget> journalPages = [
    const MoodSelectWidget(),
    const AspectSelectWidget(),
    const ExpressFeelingsWidget(),
    // MoodSummaryScreen(readOnly: true),
    const MoodSummary(readOnly: false),
  ];

  void nextPage() {
    if (index.value < journalPages.length - 1) {
      index.value++;
    }
  }

  void previousPage() {
    if (index.value > 0) {
      index.value--;
    }
  }
}