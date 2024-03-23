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

class MySpaceScreen extends StatelessWidget {
  const MySpaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const selectedColor = kApp4;
    final controller = Get.put(MySpaceController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace,vertical: KSizes.defaultSpace/2),
      child: Column(
        children: [
          Container(
            clipBehavior: Clip.none,
            decoration: BoxDecoration(
              color: kEmptyProgress,
              borderRadius: BorderRadius.circular(25.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
            child: TabBar(
              controller: controller.tabController,
              dividerHeight: 0,
              indicator: KStyles.containerDecoration(selectedColor),
              labelColor: Colors.white,
              isScrollable: true,
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              tabAlignment: TabAlignment.center,
              labelPadding: const EdgeInsets.symmetric(horizontal: 20),
              // labelStyle: h3,
              // tabAlignment: TabAlignment.center,
              indicatorPadding: const EdgeInsets.symmetric(
                  horizontal: -20, vertical: 5),
              unselectedLabelColor: Colors.black,
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
      ),
    );
  }
}

class MySpaceController extends GetxController with GetSingleTickerProviderStateMixin {

  static MySpaceController get instance => Get.find();
  final RxInt tabIndex = 0.obs;
  late TabController tabController;
  final tabs = const [
    Tab(text: 'Journal'),
    Tab(text: 'Milestones'),
    Tab(text: 'Questions'),
    Tab(text: 'Story'),
    Tab(text: 'Gratitude'),
  ];
  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
  }
  void updateTabIndex(int index) {
    if (tabController.indexIsChanging || tabController.index != index) {
      tabController.animateTo(index);
    }
  }
}
