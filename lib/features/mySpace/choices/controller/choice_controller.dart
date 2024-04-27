import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:knowyourself/features/mySpace/choices/model/user_choice_model.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class ChoiceController extends GetxController {
  static ChoiceController get instance => Get.find();

  final pageController = PageController();
  RxInt pageIndex = 0.obs;
  RxList<UserChoice> questionnaire = RxList<UserChoice>();
  RxList<XFile?> pickedImages = RxList.filled(3, null);

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadSavedAnswers();
  }

  void loadSavedAnswers() {
    var storedAnswers = storage.read('userChoices');
    if (storedAnswers != null) {
      List<dynamic> storedAnswersList = jsonDecode(storedAnswers);
      questionnaire.assignAll(
        storedAnswersList.map((e) => UserChoice.fromJson(e)).toList(),
      );
    } else {
      questionnaire.addAll([
        UserChoice(questionText: 'Add your most cherished memories', answers: List.filled(3, ''), imagePath: ''),
        UserChoice(questionText: 'Share your favorite music', answers: List.filled(3, ''), imagePath: ''),
        UserChoice(questionText: 'Mention the best people in your life', answers: List.filled(3, ''), imagePath: ''),
      ]);
      // pickedImages.assignAll(List.filled(3, null));
    }

    for (int i = 0; i < questionnaire.length; i++) {
      var question = questionnaire[i];
      if (question.imagePath.isNotEmpty) {
        pickedImages[i] = XFile(question.imagePath); // Convert the image path to an XFile
      }
    }
  }

  void setAnswer(int questionIndex, int answerIndex, String value) {
    var question = questionnaire[questionIndex];
    question.answers[answerIndex] = value;
    questionnaire.refresh();
    updateSavedAnswers();
  }

  void updateSavedAnswers() {
    var encodedAnswers = jsonEncode(questionnaire.map((e) => e.toJson()).toList());
    storage.write('userChoices', encodedAnswers);
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
    // This will automatically save the current state of answers to storage
    Get.offAllNamed(KRoutes.getMasterRoute());
    KHelper.showSnackBar('Saved your choices!', 'Answers submitted successfully');
  }

  bool get isFirstQuestion => pageIndex.value == 0;
  bool get isLastQuestion => pageIndex.value == questionnaire.length - 1;

  // Method to handle image picking
  Future<void> pickImage(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    // If an image was picked, update the corresponding entry in the pickedImages list
    if (image != null) {
      pickedImages[index] = image;
      saveImagePath(index, image.path); // Save the image path to UserChoice and GetStorage
      update(); // Call update to trigger a rebuild of the UI
    }
  }

  void saveImagePath(int questionIndex, String imagePath) {
    var question = questionnaire[questionIndex];
    question.imagePath = imagePath; // Assuming UserChoice has an `imagePath` field
    questionnaire.refresh();
    updateSavedAnswers(); // Call your method to save the answers and image paths
  }


  void removeImage(int index) {
    pickedImages[index] = null;
    setPicture(index, '');
    saveImagePath(index, '');
    update();
  }

  void setPicture(int questionIndex, String imagePath) {
    var question = questionnaire[questionIndex];
    question.imagePath = imagePath;

    questionnaire.refresh();
    updateSavedAnswers();
  }
}
