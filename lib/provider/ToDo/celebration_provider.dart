import 'package:flutter/widgets.dart';
import 'package:knowyourself/models/To%20Do/celebration_model.dart';
import 'package:knowyourself/utils/pref.dart';

class CelebrationProvider extends ChangeNotifier {
  CelebrationModel _celebrationModel =
      CelebrationModel(title: "I did a random act of ");

  final TextEditingController _celebrationTextEditingController =
      TextEditingController();

  String _celebrationString =
      SharedPreferencesHelper.getCelebration(dateTime: DateTime.now());

  TextEditingController get celebrationTextEditingController =>
      _celebrationTextEditingController;

  CelebrationModel get celebrationModel => _celebrationModel;

  String get celebrationString => _celebrationString;

  void updateCelebration(CelebrationModel celebrationModel) {
    _celebrationModel = celebrationModel;
    notifyListeners();
  }

  void saveCelebrationString() {
    _celebrationString =
        _celebrationModel.title + _celebrationTextEditingController.text;
    SharedPreferencesHelper.saveCelebration(celebration: _celebrationString);
    notifyListeners();
  }
}
