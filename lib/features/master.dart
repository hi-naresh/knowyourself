import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/insights/screens/dashboard/dashboard_screen.dart';
import 'package:knowyourself/features/insights/screens/insights/insight_screen.dart';
import 'package:knowyourself/common/widgets/k_floating_action.dart';
import 'package:knowyourself/features/learning/screens/learn_screen/learn_screen.dart';
import 'package:knowyourself/features/mySpace/space_screen.dart';

import '../../utils/constants/colors.dart';
import '../common/extras/auth_screen_prompt.dart';
import '../common/widgets/appbar/appbar.dart';
import '../common/widgets/navbar/bottom_nar_bar.dart';
import '../data/helper_service/local_auth/local_bio_auth.dart';
import '../utils/constants/sizes.dart';

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
            selectedIconColor: kApp1,
            title: 'Home',
          ),
          BottomNavBarWidget(
            icon: "assets/icons/analysis.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: kApp2,
            title: 'Insights',
          ),
          BottomNavBarWidget(
            icon: "assets/icons/learn.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: kApp3,
            title: 'Learn',
          ),
          BottomNavBarWidget(
            icon: "assets/icons/myspace.svg",
            iconSize: KSizes.iconLg,
            selectedIconColor: kApp4,
            title: 'Space',
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
    final spaceController = Get.put(MySpaceController());
    return Scaffold(
      appBar: const KAppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        if (controller.currentIndex.value == 3 &&
            spaceController.tabIndex.value == 0) {
          return KFloatingAction(context: context);
        } else {
          return const SizedBox();
        }
      }),
      extendBody: true,
      body: Obx(() => controller._screens[controller.currentIndex.value]),
      bottomNavigationBar: bottomNavBar(controller),
    );
  }
}

class MasterController extends GetxController {
  static MasterController get instance => Get.find();
  final RxInt currentIndex = 0.obs;

  final LocalBioAuth _localBioAuth = LocalBioAuth.instance;

  final List<Widget> _screens = [
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
        _screens[3] = const AuthScreenPrompt();
      }
    });
  }

  Future<void> authenticateBeforeAccess() async {
    bool isAuthenticated = await _localBioAuth.authenticateWithBiometrics();
    if (isAuthenticated) {
      // If authentication is successful, allow access to MySpaceScreen
      _screens[3] = const MySpaceScreen();
    } else {
      // Handle authentication failure, such as displaying an error message or redirecting
      // currentIndex.value = 0; // Redirect user to a safe screen e.g., Dashboard
      Get.snackbar('Authentication Required', 'Please authenticate to access this section.');
    }
  }
}
