import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../utils/helpers/shadow_disabler.dart';

class AppStateController extends GetxController {
  static AppStateController get instance => Get.find();
  static final storage = GetStorage();
  RxBool isDarkMode = false.obs;
  final _key = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    // Load theme mode from storage
    isDarkMode.value = storage.read(_key) ?? false;
    CustomShadow.disableShadows = isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    CustomShadow.disableShadows = isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    // Save theme mode to storage
    storage.write(_key, isDarkMode.value);
  }
}

