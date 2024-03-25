import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/gratitude/screens/widgets/gratitude_widget.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal/journal_screen.dart';
import 'package:knowyourself/features/mySpace/milestones/screens/milestone_screen.dart';
import 'package:knowyourself/features/mySpace/questions/screens/question_screen.dart';
import 'package:knowyourself/features/mySpace/story/screens/story_screen.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../common/styles/styles.dart';
import '../../utils/constants/colors.dart';
import '../../utils/helpers/helper_functions.dart';

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const selectedColor = kApp4;
    final controller = MySpaceController.instance;
    return Column(
        children: [
          Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              color: KHelper.isDarkMode(context) ? kEmptyProgressDark : kEmptyProgress,
              borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
            ),
            margin: const EdgeInsets.all(KSizes.md),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: TabBar(
              controller: controller.tabController,
              dividerHeight: 0,
              indicator: KStyles.containerDecoration(selectedColor),
              labelColor: Colors.white,
              isScrollable: true,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              tabAlignment: TabAlignment.center,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              // labelStyle: h3,
              // tabAlignment: TabAlignment.center,
              indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: -20, vertical: 5),
              tabs: controller.tabs,
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          Expanded(
              child: TabBarView(
                clipBehavior: Clip.none,
                controller: controller.tabController,
                children: const [
                  JournalScreen(),
                  MilestoneAdd(),
                  QuestionSpace(),
                  StoryScreen(),
                  GratitudeWidget()
                ],
              ))
        ],
      );
  }
}

class MySpaceController extends GetxController with GetSingleTickerProviderStateMixin {

  static MySpaceController get instance => Get.find();
  final RxInt tabIndex = 0.obs;
  late TabController tabController;

  final tabs = const [
    Tab(text: 'Reflections'),
    Tab(text: 'Milestones'),
    Tab(text: 'Questions'),
    Tab(text: 'Story'),
    Tab(text: 'Gratitude'),
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabs.length, vsync: this,initialIndex: tabIndex.value);
    tabController.animation?.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        tabIndex.value = tabController.index;
      }
    });
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
  void updateTabIndex(int index) {
      tabController.animateTo(index);
  }

}
