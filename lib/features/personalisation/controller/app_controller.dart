import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/repo/auth/auth_repo.dart';
import '../../../routes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/shadow_disabler.dart';

class AppStateController extends GetxController {
  static AppStateController get instance => Get.find();
  static final storage = GetStorage();
  RxBool isDarkMode = false.obs;
  final _dark = 'isDarkMode';

  @override
  void onInit() {
    super.onInit();
    // Load theme mode from storage
    isDarkMode.value = storage.read(_dark) ?? false;
    CustomShadow.disableShadows = isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    CustomShadow.disableShadows = isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
    // Save theme mode to storage
    storage.write(_dark, isDarkMode.value);
  }

  void logoutUser() async {
    try{
      await AuthRepo.instance.logoutUser();
      await storage.erase();
      Get.offAllNamed(KRoutes.getLoginRoute());
    } catch (e){
      throw KTexts.errorMessage;
    }
  }
}

