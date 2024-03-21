import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppStateController extends GetxController {
  // Accessing GetStorage
  final GetStorage _storage = GetStorage();
  final String _themeKey = 'isDarkMode';

  // Observable for theme status. Defaults to false if not set in storage.
  // final RxBool isDark = (GetStorage().read('isDarkMode') ?? false).obs;
  final RxBool isDark = false.obs;
  bool get isDarkMode => isDark.value;
  set isDarkMode(bool value) => isDark.value = value;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  final RxInt _pageState = 0.obs;
  int get pageState => _pageState.value;

  @override
  void onInit() {
    super.onInit();
    // Load initial theme state from GetStorage, if available.
    isDark.value = _storage.read(_themeKey) ?? false;
  }

  void updateTheme(bool value) {
    isDarkMode = value;
    // Save the new theme state to GetStorage
    _storage.write(_themeKey, value);
  }

  void updatePage(int index) {
    _pageState.value = index;
  }

  toggleDarkMode() {
    isDarkMode = !isDarkMode;
    updateTheme(isDarkMode);
  }

}
