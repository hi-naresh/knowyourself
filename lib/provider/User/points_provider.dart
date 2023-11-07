import 'package:flutter/foundation.dart';
import 'package:knowyourself/utils/pref.dart';

class PointsProvider extends ChangeNotifier {
  int _score = SharedPreferencesHelper.getPoints();
  int get getScore => _score;
  void setScore({required int point}) {
    SharedPreferencesHelper.saveScores(point);
    _score = _score + point;
    notifyListeners();
  }
}
