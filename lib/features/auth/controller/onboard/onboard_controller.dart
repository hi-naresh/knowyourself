import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../routes.dart';
import '../../../../utils/constants/colors.dart';

class OnBoardController extends GetxController {
  static OnBoardController get instance => Get.find();

  final PageController pageController = PageController();
  RxInt activeIndex = 0.obs;
  void nextPage(){
    Get.toNamed(KRoutes.getLoginRoute());
  }

  void onTap() {
    if (activeIndex.value == 2) {
      Get.toNamed(KRoutes.getLoginRoute());
      return;
    }
    pageController.animateToPage(
        activeIndex.value + 1,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear);
  }

  final List<Color> colors = [
    KColors.kApp1Light,
    KColors.kApp2Light,
    KColors.kApp4Light,
  ];

}