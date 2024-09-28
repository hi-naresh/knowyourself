import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/insights/screens/dashboard/dashboard_screen.dart';
import 'package:knowyourself/features/insights/screens/insights/insight_screen.dart';
import 'package:knowyourself/common/widgets/k_floating_action.dart';
import 'package:knowyourself/features/learning/screens/learn_screen/learn_screen.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal_entry/journal_entry.dart';
import 'package:knowyourself/features/mySpace/milestones/screens/widget/milestone_add.dart';
import 'package:knowyourself/features/mySpace/space_screen.dart';

import '../../utils/constants/colors.dart';
import '../common/extras/auth_screen_prompt.dart';
import '../common/widgets/appbar/appbar.dart';
import '../common/widgets/navbar/bottom_nar_bar.dart';
import '../data/helper_service/local_auth/local_bio_auth.dart';
import '../routes.dart';
import '../utils/constants/sizes.dart';
import '../utils/constants/text_strings.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  Widget bottomNavBar(MasterController controller) {
    return Obx(
      () => BottomRoundedNavBar(
        height: KSizes.bottomNavBarHeight,
        items: const [
          BottomNavBarWidget(
            icon: "assets/icons/home.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: KColors.kApp1,
            title: KTexts.home,
          ),
          BottomNavBarWidget(
            icon: "assets/icons/analysis.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: KColors.kApp2,
            title: KTexts.insights,
          ),
          BottomNavBarWidget(
            icon: "assets/icons/learn.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: KColors.kApp3,
            title: KTexts.learn,
          ),
          BottomNavBarWidget(
            icon: "assets/icons/myspace.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: KColors.kApp4,
            title: KTexts.mySpace,
          ),
        ],
        currentIndex: controller.currentIndex.value,
        onChanged: (index) => controller.currentIndex.value = index,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MasterController());
    // final spaceController = Get.put(MySpaceController());
    final spaceController = MySpaceController.instance;
    return Scaffold(
      appBar:  KAppBarCustom(
        extraActions: [
          //help button
          IconButton(
            onPressed: () => Get.toNamed(KRoutes.getAppTourRoute()),
            icon: const Icon(
              CupertinoIcons.question_circle_fill,
              size: KSizes.iconLg,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        if (controller.currentIndex.value == 3 &&
            spaceController.tabIndex.value == 0) {
          return const KFloatingAction(
            icon: CupertinoIcons.book,
            screenWidget:JournalEntryScreen(),
          );
        } else if(controller.currentIndex.value == 3 &&
            spaceController.tabIndex.value == 2){
          return const KFloatingAction(
            icon: CupertinoIcons.add,
            screenWidget:MilestoneAdd(),
          );
        }else {
          return const SizedBox();
        }
      }),
      extendBody: true,
      body: Obx(() => controller.screens[controller.currentIndex.value]),
      bottomNavigationBar: bottomNavBar(controller),
    );
  }
}

class MasterController extends GetxController {
  static MasterController get instance => Get.find();
  final RxInt currentIndex = 0.obs;

  final LocalBioAuth _localBioAuth = LocalBioAuth.instance;

  final List<Widget> screens = [
    const Dashboard(),
    const InsightScreen(),
     const LearnScreen(),
    const AuthScreenPrompt(),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    currentIndex.listen((index) {
      if (index == 3) { // Index 3 corresponds to MySpaceScreen
        authenticateBeforeAccess();
      }else{
        screens[3] = const AuthScreenPrompt();
      }
    });
  }

  Future<void> authenticateBeforeAccess() async {
    if (_localBioAuth.isAuthEnabled()) {
      bool isAuthenticated = await _localBioAuth.authenticateWithBiometrics();
      if (isAuthenticated) {
        screens[3] = const MySpaceScreen();
      } else {
        Get.snackbar(KTexts.authenticationRequired, KTexts.pleaseAuthenticate);

      }
    } else {
      // Directly allow access if bio auth is disabled
      screens[3] = const MySpaceScreen();
    }
  }
}
