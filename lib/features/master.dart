import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/insights/screens/dashboard/dashboard_screen.dart';
import 'package:knowyourself/features/insights/screens/insights/insight_screen.dart';
import 'package:knowyourself/features/learning/screens/learn_screen.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal_entry/journal_entry.dart';
import 'package:knowyourself/features/mySpace/space_screen.dart';
import 'package:knowyourself/features/personalisation/controller/app_controller.dart';

import '../../common/styles/styles.dart';
import '../../utils/constants/colors.dart';
import '../common/widgets/appbar/appbar.dart';
import '../common/widgets/navbar/bottom_nar_bar.dart';
import '../utils/constants/sizes.dart';
import '../utils/helpers/helper_functions.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});
  Widget _buildFAB(BuildContext context) {
    return Container(
      height: KSizes.iconXl * 2,
      width: KSizes.iconXl * 2,
      decoration: KStyles.containerDecoration(kApp4),
      child: IconButton(
        icon: SvgPicture.asset(
          "assets/icons/add.svg",
          color: KColors.white,
          height: KSizes.iconMd,
        ),
        onPressed: () {
          KHelper.showBottomSheet( const JournalEntryScreen());
        },
      ),
    );
  }

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
    return Scaffold(
      appBar: const KAppBar(),
      // extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() => controller.currentIndex.value == 3
          ? _buildFAB(context)
          : const SizedBox()),
      extendBody: true,
      body: Obx(() => controller._screens[controller.currentIndex.value]),
      bottomNavigationBar: bottomNavBar(controller),
    );
  }
}

class MasterController extends GetxController {
  static MasterController get instance => Get.find();
  final RxInt currentIndex = 0.obs;

  final List<Widget> _screens = [
    const Dashboard(),
    const InsightScreen(),
    const LearnScreen(),
    const MySpaceScreen(),
  ];

}
