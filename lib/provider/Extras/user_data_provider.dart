import 'package:flutter/material.dart';
import 'package:knowyourself/utils/pref.dart';

class UserDataProvider extends ChangeNotifier {
  String _avatar = SharedPreferencesHelper.getAvatar();
  String _userName = SharedPreferencesHelper.getUserName();
  final TextEditingController _nameTextEditingController =
      TextEditingController(text: SharedPreferencesHelper.getUserName());

  String get avatar => _avatar;
  String get userName => _userName;
  TextEditingController get nameTextEditingController =>
      _nameTextEditingController;

  bool _hasEntered = true;
  bool get hasEntered => _hasEntered;

  void updateAvatar(String avatar) {
    _avatar = avatar;
    notifyListeners();
  }

  void validateText() {
    if (nameTextEditingController.text.trim() != "") {
      _hasEntered = true;
    } else {
      _hasEntered = false;
    }
    notifyListeners();
  }

  void saveData() {
    _userName = _nameTextEditingController.text;
    SharedPreferencesHelper.saveAvatar(avatar: _avatar);
    SharedPreferencesHelper.saveUserName(name: _userName);
    notifyListeners();
  }
}
