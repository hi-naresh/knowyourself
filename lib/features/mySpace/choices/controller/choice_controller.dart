import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/choices/model/user_choice_model.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

class ChoiceController extends GetxController {

  static ChoiceController get instance => Get.find();

  final pageController = PageController();
  RxInt pageIndex = 0.obs;
  RxList<UserChoice> questionnaire = RxList<UserChoice>();

  @override
  void onInit() {
    super.onInit();
    questionnaire.addAll([
      UserChoice(questionText: 'Best Memories of You',answers: List.filled(3, '')),
      UserChoice(questionText: 'Your Favorite Music',answers: List.filled(3, '')),
      UserChoice(questionText: 'Best People in Your Life',answers: List.filled(3, '')),
    ]);
  }

  void setAnswer(int questionIndex, int answerIndex, String value) {
    var question = questionnaire[questionIndex];
    question.answers[answerIndex] = value;
    questionnaire.refresh();
  }

  void nextQuestion() {
    if (pageIndex.value < questionnaire.length - 1) {
      pageIndex.value++;
    }
  }

  void previousQuestion() {
    if (pageIndex.value > 0) {
      pageIndex.value--;
    }
  }

  void submitAnswers() {
    // Save user answers to the database
    Get.back();
    KHelper.showSnackBar('Saved your choices!', 'Answers submitted successfully');
  }

  bool get isFirstQuestion => pageIndex.value == 0;
  bool get isLastQuestion => pageIndex.value == questionnaire.length - 1;

}
