import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/repo/space/questions/question_repo.dart';
import '../../../../utils/constants/enums.dart';
import '../model/questions_model.dart';


class QuestionController extends GetxController {
  final QuestionRepo _questionRepo = Get.put(QuestionRepo());
  var questions = <QuestionModel>[].obs;
  final TextEditingController questionController = TextEditingController();
  final Rx<ReminderPeriod> reminderPeriod = ReminderPeriod.daily.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuestions();
  }

  @override
  void onClose() {
    questionController.dispose();
    super.onClose();
  }

  void fetchQuestions() async {
    final fetchedQuestions = await _questionRepo.fetchAllQuestions();
    questions.assignAll(fetchedQuestions);
  }

  void addQuestion() {
    if (questionController.text.isEmpty) {
      // Handle empty question case, maybe show an error message
      return;
    }

    final newQuestion = QuestionModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(), // Simple unique ID generation
      userId: 'your-user-id', // Assume a method to get the current user ID
      title: questionController.text,
      reminderPeriod: reminderPeriod.value,
      answer: '', // No answer yet
      isAnswered: false,
    );

    _questionRepo.saveQuestion(newQuestion).then((_) {
      fetchQuestions(); // Refresh list
      questionController.clear(); // Clear form
    });
  }

  void addAnswer(String questionId, String answer) async {
    QuestionModel? question = questions.firstWhereOrNull((q) => q.id == questionId);
    if (question != null) {
      var updatedQuestion = question.copyWith(answer: answer, isAnswered: true);
      await _questionRepo.updateQuestion(updatedQuestion);
      fetchQuestions();
    }
  }

  void updateQuestion(QuestionModel question) {
    _questionRepo.updateQuestion(question).then((_) => fetchQuestions());
  }

  void deleteQuestion(String questionId) {
    _questionRepo.deleteQuestion(questionId).then((_) => fetchQuestions());
  }
}

