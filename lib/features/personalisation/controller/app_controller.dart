import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/helpers/shadow_disabler.dart';
import '../../../utils/theme/theme.dart';

class AppStateController extends GetxController {
  // Accessing GetStorage
  static final storage = GetStorage();
  static AppStateController get instance => Get.find();
  RxBool isDarkMode = false.obs;
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final RxInt _pageState = 0.obs;
  int get pageState => _pageState.value;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = Get.isDarkMode;
    CustomShadow.disableShadows = isDarkMode.value;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    CustomShadow.disableShadows = isDarkMode.value;
    // Get.changeTheme(isDarkMode.value ? KAppTheme.darkTheme : KAppTheme.lightTheme);
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void updatePage(int index) {
    _pageState.value = index;
  }

}
