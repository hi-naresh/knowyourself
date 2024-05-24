import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/repo/materials/learning/learn_repo.dart';
import '../../../utils/constants/text_strings.dart';
import '../model/chapter_model.dart';
import '../screens/chapters/chapter_screens.dart';

// class LearningController extends GetxController {
//   RxList<LearningChapters> learningMaterials = <LearningChapters>[].obs;
//   // use enum values for LifeAspects enum skipping first item
//   final PageController pageController = PageController();
//
//   final List<String> aspects = LifeAspects.values.skip(1).map((e) => e.toString().split('.').last).toList();
//   RxString aspect = ''.obs;
//
//   final selectedQuizOption = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // loadMaterialsForAspect(aspect);
//     loadMaterialsFromJson(aspect.value);
//   }
//
//   void setAspect(String aspectName) {
//     aspect.value = aspectName;
//     // loadMaterialsForAspect(aspectName);
//     loadMaterialsFromJson(aspectName);
//   }
//
//   //load materials from asset , json file
//   Future<void> loadMaterialsFromJson(String aspect) async {
//     final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
//     final Map<String, dynamic> chaptersJson = json.decode(chaptersJsonString);
//     final List<dynamic> chaptersJsonList = chaptersJson['LearningChapters'];
//
//     final List<LearningChapters> chaptersList = chaptersJsonList
//         .map((chapter) => LearningChapters.fromMap(chapter))
//         .where((chapter) => chapter.aspect.toString().split('.').last == aspect)
//         .toList();
//
//     learningMaterials.assignAll(chaptersList);
//   }
//
//   void updateProgress(int index, double progress, {bool completed = false}) {
//     var material = learningMaterials[index];
//     learningMaterials[index] = material.copyWith(progress: progress, completed: completed);
//   }
//
//   LearningChapters getMaterialAtIndex(int index) {
//     return learningMaterials[index];
//   }
//
//
//   void chapterCompleted(int index) {
//     updateProgress(index, 1, completed: true);
//     // Save progress to database quiz after completion
//
//   }
//
//   void answerQuizQuestion(int chapterIndex, int questionIndex, int answerIndex) {
//     var chapter = learningMaterials[chapterIndex];
//     var question = chapter.quizQuestions![questionIndex];
//     if (question.correctAnswerIndex == answerIndex) {
//       // Handle correct answer
//       print("Correct answer!");
//     } else {
//       // Handle incorrect answer
//       print("Wrong answer!");
//     }
//   }
//
//
//   void jumpToNextPage(int index) {
//     //for contentChunk navigation in page view
//     pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
//     //save progress dynamically depending on the list of pages
//     updateProgress(index, index / learningMaterials.length);
//   }
//
//   void jumpToNextQuestion(int index) {
//     //for quiz navigation in page view
//     pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
//   }
//
//   void navigateToChapterContent( int index) {
//     // Navigate to a new screen that shows content chunks
//     // For simplicity, this is just a placeholder function
//     Get.to(() => ChapterContentView(index: index));
//   }
//
//   closeChapterContent() {
//     //save progress
//     Get.back();
//   }
//
//   int? getSelectedOptionForQuestion(int chapterIndex, int index) {
//     return learningMaterials[chapterIndex].quizQuestions![index].correctAnswerIndex;
//   }
// }

class LearningController extends GetxController {
  RxList<LearningChapters> learningMaterials = <LearningChapters>[].obs;
  final PageController pageController = PageController();
  Map<int, Map<int, int>> userAnswers = {};
  final learnRepo = Get.put(LearnRepo());

  @override
  void onInit() {
    super.onInit();
    loadMaterialsFromJson("aspect");
    // loadMaterialsForAspect("aspect"); // Load initial material
  }

  // Future<void> loadMaterialsForAspect(String aspect) async {
  //   final materials =  await learnRepo.loadMaterialsForAspect(aspect);
  //   learningMaterials.assignAll(materials);
  // }

  // load materials from asset , json file
  Future<void> loadMaterialsFromJson(String aspect) async {
    final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
    final Map<String, dynamic> chaptersJson = json.decode(chaptersJsonString);
    final List<dynamic> chaptersJsonList = chaptersJson['LearningChapters'];

    final List<LearningChapters> chaptersList = chaptersJsonList
        .map((chapter) => LearningChapters.fromMap(chapter))
        .where((chapter) => chapter.aspect.toString().split('.').last == aspect)
        .toList();

    learningMaterials.assignAll(chaptersList);
  }

  void answerQuizQuestion(int chapterIndex, int questionIndex, int selectedAnswerIndex) {
    userAnswers[chapterIndex] ??= {};
    userAnswers[chapterIndex]![questionIndex] = selectedAnswerIndex;

    var isCorrect = learningMaterials[chapterIndex].quizQuestions![questionIndex].correctAnswerIndex == selectedAnswerIndex;
    Get.snackbar(
      '${KTexts.answer} ${isCorrect ? KTexts.correct : KTexts.incorrect}',
      isCorrect ? KTexts.correctMessage : KTexts.incorrectMessage,
      backgroundColor: isCorrect ? Colors.green : Colors.red,
    );

    if (isCorrect) {
      updateProgress(chapterIndex, ((questionIndex + 1) / learningMaterials[chapterIndex].quizQuestions!.length));
      if (questionIndex == learningMaterials[chapterIndex].quizQuestions!.length - 1) {
        chapterCompleted(chapterIndex);
      }
    }
  }

  void chapterCompleted(int index) {
    updateProgress(index, 1, completed: true);
    Get.to(() => const CongratulationsScreen());
  }

  void updateProgress(int index, double progress, {bool completed = false}) {
    var chapter = learningMaterials[index];
    learningMaterials[index] = chapter.copyWith(progress: progress, completed: completed);
    //save progress to my learning repo

  }

  void jumpToNextPage(int index) {
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void navigateToChapterContent(int index) {
    Get.to(() => ChapterContentView(index: index));
  }

  void closeChapterContent() {
    Get.back();
  }

  getSelectedOptionForQuestion(int chapterIndex, int questionIndex) {
    return userAnswers[chapterIndex]?[questionIndex];
  }

  LearningChapters getMaterialAtIndex(int index) {
    return learningMaterials[index];
  }
}
