import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../model/questions_model.dart';

class QuestionController extends GetxController {
  static QuestionController get instance => Get.find();
  final questionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String selectedCategory = 'short';

  final List<Question> _questions = [];
  List<Question> get questions => _questions;

  void addQuestions(Question question) {
    _questions.add(question);
    update();
    // Here you can integrate your logic to schedule notifications
  }
  void addQuestion() {
    if (questionController.text.isEmpty) return;

    addQuestions(
      Question(
        text: questionController.text,
        deadline: selectedDate,
        category: selectedCategory,
      ),
    );
    questionController.clear(); // Clear the text field after question is added
  }
  void presentDatePicker() {
    //show date picker

  }


  void onPressed() {
    //modalSheet menu with daily, weekly, monthly, yearly
  }

  deleteQuestion(int index) {
    _questions.removeAt(index);
    update();
  }

  pickDate() {
    
  }

  pickReminder() {}
  
  
}