import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../routes.dart';

class OnBoardController extends GetxController {
  static OnBoardController get instance => Get.find();

  final PageController pageController = PageController();
  RxInt activeIndex = 0.obs;
  void nextPage(){
    Get.toNamed(KRoutes.getLoginRoute());
  }

}