import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/repo/auth/auth_repo.dart';
import '../../../routes.dart';
import '../../../utils/helpers/shadow_disabler.dart';

class AppStateController extends GetxController {
  static AppStateController get instance => Get.find();
  static final storage = GetStorage();
  RxBool isDarkMode = false.obs;
  final _dark = 'isDarkMode';
  final _countToday = 0.obs;
  final String _keyPrefix = "app_open_count_";


  @override
  void onInit() {
    super.onInit();
    // Load theme mode from storage
    isDarkMode.value = storage.read(_dark) ?? false;
    // print(storage.remove('app_open_count_2024-4-15'));
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

  //count whenever user visits the app in day , reset next day and so on, store count in Get_storage
  String _getTodayKey() {
    final date = DateTime.now();
    return '$_keyPrefix${date.year}-${date.month}-${date.day}';
  }

  void incrementAppOpenCount() {
    final key = _getTodayKey();
    int currentCount = storage.read(key) ?? 0;
    storage.write(key, currentCount + 1);
  }

  int getAppOpenCountForToday() {
    final key = _getTodayKey();
    return storage.read(key) ?? 0;
  }


  void logoutUser() async {
    try{
      await AuthRepo.instance.logoutUser();
      await storage.erase();
      Get.offAllNamed(KRoutes.getLoginRoute());
    } catch (e){
      throw 'Something went Wrong. Try Again';
    }
  }
}
