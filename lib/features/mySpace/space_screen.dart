import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/gratitude/screens/gratitude_screen.dart';
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
    return Builder(
      builder: (BuildContext context) {
        final TabController tabController = TabController(
            length: controller.tabs.length, vsync: Scaffold.of(context));
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {
            controller.changeTab(tabController.index);
          }
        });
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace,vertical: KSizes.defaultSpace/2),
          child: Column(
            children: [
              Container(
                clipBehavior: Clip.none,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                child: TabBar(
                  controller: tabController,
                  dividerHeight: 0,
                  indicator: KStyles.containerDecoration(selectedColor),
                  labelColor: Colors.white,
                  isScrollable: true,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  tabAlignment: TabAlignment.center,
                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
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
                controller: tabController,
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
      },
    );
  }
}

class MySpaceController extends GetxController {
  final RxInt tabIndex = 0.obs;
  final tabs = const [
    Tab(text: 'Journal'),
    Tab(text: 'Milestones'),
    Tab(text: 'Questions'),
    Tab(text: 'Story'),
    Tab(text: 'Gratitude'),
  ];

  void changeTab(int index) {
    tabIndex.value = index;
  }
}
