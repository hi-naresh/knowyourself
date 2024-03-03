import 'package:flutter/material.dart';
import 'package:knowyourself/utils/pref.dart';

class AppStateProvider extends ChangeNotifier {
  bool _isDarkMode =
      SharedPreferencesHelper.getSavedTheme() == 1 ? true : false;
  bool get isDarkMode => _isDarkMode;

  final PageController _pageController = PageController();
  PageController get pageController => _pageController;

  int _pageState = 0;
  int get pageState => _pageState;

  void updateTheme(bool isDarkMode) {
    _isDarkMode = isDarkMode;
    SharedPreferencesHelper.saveTheme(isDarkMode);
    notifyListeners();
  }

  void updatePage(int index) {
    _pageState = index;
    notifyListeners();
  }


// void updatePage(int page) {
  //   _pageState = page;
  //   _pageController.animateToPage(page,
  //       duration: const Duration(milliseconds: 200), curve: Curves.bounceIn);
  //   notifyListeners();
  // }
}
