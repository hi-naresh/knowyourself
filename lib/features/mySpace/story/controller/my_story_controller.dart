import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../../data/repo/space/story/story_repo.dart';
import '../model/story_model.dart';
import '../../../../../utils/constants/enums.dart';

class StoryController extends GetxController {
  final StoryRepo _storyRepository = Get.find<StoryRepo>();

  // Observables for current and desired stories
  var currentStory = Rxn<StoryModel>();
  var desiredStory = Rxn<StoryModel>();

  // TextEditingControllers for story details
  final TextEditingController characterCtrl = TextEditingController();
  final TextEditingController aspirationCtrl = TextEditingController();
  final TextEditingController qualitiesCtrl = TextEditingController();
  final TextEditingController scenarioCtrl = TextEditingController();
  final TextEditingController skillsCtrl = TextEditingController();

  // Method to save or update the story
  void saveOrUpdateStory(StoryType storyType) async {
    final userId = UserController.instance.user.value.id!;
    StoryModel story = StoryModel(
      storyId: storyType == StoryType.current ? currentStory.value?.storyId ?? '' : desiredStory.value?.storyId ?? '',
      userId: userId, // Manage userId accordingly
      type: storyType,
      savedTime: DateTime.now(),
      character: characterCtrl.text,
      aspiration: aspirationCtrl.text,
      qualities: qualitiesCtrl.text,
      scenario: scenarioCtrl.text,
      skills: skillsCtrl.text,
    );
    await _storyRepository.saveStory(story);
    if (storyType == StoryType.current) {
      currentStory.value = story;
    } else {
      desiredStory.value = story;
    }
    KHelper.showSnackBar('Story saved successfully',"");
    fetchStories(); // Refresh stories after saving
  }

  // Method to fetch stories
  void fetchStories() async {
    currentStory.value = await _storyRepository.fetchStory(StoryType.current);
    desiredStory.value = await _storyRepository.fetchStory(StoryType.desired);
    // Initialize TextEditingControllers if stories exist
    if (currentStory.value != null) {
      characterCtrl.text = currentStory.value!.character;
      // Initialize other controllers similarly
    }
    if (desiredStory.value != null) {
      // Initialize TextEditingControllers for desired story
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchStories(); // Load stories when the controller is initialized
  }

  // Remember to dispose controllers
  @override
  void onClose() {
    characterCtrl.dispose();
    aspirationCtrl.dispose();
    qualitiesCtrl.dispose();
    scenarioCtrl.dispose();
    skillsCtrl.dispose();
    super.onClose();
  }



  Future<void> updateStory( StoryType storyType) async {
    await _storyRepository.deleteStory(storyType);
    if (storyType == StoryType.current) {
      currentStory.value = null;
    } else {
      desiredStory.value = null;
    }
    KHelper.showSnackBar('Story Updated successfully',"");
    fetchStories(); // Refresh stories after deletion
  }

  //delete story
  Future<void> deleteStory( StoryType type) async {
    await _storyRepository.deleteStory(type);
    if (type == StoryType.current) {
      currentStory.value = null;
    } else if (type == StoryType.desired) {
      desiredStory.value = null;
    }
    KHelper.showSnackBar('Story Deleted successfully',"");
    clearFields();
  }

  void clearFields() {
    characterCtrl.clear();
    aspirationCtrl.clear();
    qualitiesCtrl.clear();
    scenarioCtrl.clear();
    skillsCtrl.clear();
  }
}

