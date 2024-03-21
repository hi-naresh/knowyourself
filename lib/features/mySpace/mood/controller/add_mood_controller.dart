import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_old.dart';

class AddMoodController extends GetxController {

  static AddMoodController get instance => Get.find();
  final RxString mood = "happy".obs;
  final RxString aspect = "physical".obs;

  final RxInt index = 0.obs;
  final Rx<MoodModel?> moodModel = Rx<MoodModel?>(null);
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController notesEditingController = TextEditingController();
  final PageController pageController = PageController();


  void changeMood( mood) {
    mood.value = mood;
  }

  void getIndexOfPage() {
    index.value = pageController.page?.round() ?? 0;
  }

  void updateJournal( moodModel) {
    moodModel.value = moodModel;
  }

  void clearJournalData() {
    titleEditingController.clear();
    notesEditingController.clear();
  }

  // PageController get getPageController => pageController;
  //
  // MoodModel? get getMoodModel => moodModel.value;
  // String get getMood => mood.value;
  // int get getIndex => index.value;
}
