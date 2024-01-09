import 'package:flutter/material.dart';

import '../../models/Questions.dart';

class QuestionsProvider with ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => _questions;

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
    // Here you can integrate your logic to schedule notifications
  }
}