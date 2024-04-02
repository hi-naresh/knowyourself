import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../features/mySpace/questions/model/questions_model.dart';

class QuestionRepo extends GetxController {
  final GetStorage _storage = GetStorage();
  final String _questionsKey = 'questions';

  Future<void> saveQuestion(QuestionModel question) async {
    // Retrieve existing questions and convert them into QuestionModel list
    final existingQuestionsJson = _storage.read<List<dynamic>>(_questionsKey) ?? [];
    List<QuestionModel> existingQuestions = existingQuestionsJson
        .map((json) => QuestionModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    // Add the new question
    existingQuestions.add(question);

    // Convert all questions back to List<Map<String, dynamic>> for storage
    final questionsJson = existingQuestions.map((question) => question.toJson()).toList();
    await _storage.write(_questionsKey, questionsJson);
  }

  Future<List<QuestionModel>> fetchAllQuestions() async {
    // Retrieve questions JSON from storage
    final questionsJson = _storage.read<List<dynamic>>(_questionsKey) ?? [];
    // Convert JSON to List<QuestionModel>
    return questionsJson
        .map((json) => QuestionModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<void> updateQuestion(QuestionModel updatedQuestion) async {
    // Retrieve existing questions and convert them into QuestionModel list
    final existingQuestionsJson = _storage.read<List<dynamic>>(_questionsKey) ?? [];
    List<QuestionModel> existingQuestions = existingQuestionsJson
        .map((json) => QuestionModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    // Find the index of the question to update
    final index = existingQuestions.indexWhere((q) => q.id == updatedQuestion.id);
    if (index != -1) {
      // Update the question
      existingQuestions[index] = updatedQuestion;

      // Convert all questions back to List<Map<String, dynamic>> for storage
      final questionsJson = existingQuestions.map((question) => question.toJson()).toList();
      await _storage.write(_questionsKey, questionsJson);
    }
  }

  Future<void> deleteQuestion(String questionId) async {
    // Retrieve existing questions and convert them into QuestionModel list
    final existingQuestionsJson = _storage.read<List<dynamic>>(_questionsKey) ?? [];
    List<QuestionModel> existingQuestions = existingQuestionsJson
        .map((json) => QuestionModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    // Remove the question with the given ID
    existingQuestions.removeWhere((q) => q.id == questionId);

    // Convert all questions back to List<Map<String, dynamic>> for storage
    final questionsJson = existingQuestions.map((question) => question.toJson()).toList();
    await _storage.write(_questionsKey, questionsJson);
  }

}
