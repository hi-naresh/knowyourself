import 'package:flutter/material.dart';
import 'package:knowyourself/models/To%20Do/status_model.dart';
import 'package:knowyourself/utils/pref.dart';

class StatusProvider extends ChangeNotifier {
  final List<StatusModel> _statusList = SharedPreferencesHelper.getStatus(
    dateTime: DateTime.now(),
  );
  List<StatusModel> get statusList => _statusList;

  void addStatus({required StatusModel statusModel}) {
    _statusList.add(statusModel);
    SharedPreferencesHelper.saveStatus(statusModel);
    notifyListeners();
  }

  void removeStatus({required int index}) {
    _statusList.removeAt(index);
    notifyListeners();
  }

  void updateStatus({required int index, required StatusModel statusModel}) {
    _statusList.removeAt(index);
    _statusList.insert(index, statusModel);
    notifyListeners();
  }

  int getSeenStatues() {
    int seen = 0;
    for (StatusModel statusModel in _statusList) {
      if (statusModel.hasSeen) {
        seen += 1;
      }
    }
    return seen;
  }
}
