// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
//
// import '../../../../features/mySpace/story/model/story_model.dart';
// import '../../../../utils/constants/enums.dart';
//
// class StoryRepo extends GetxController{
//
//   static StoryRepo get instance => Get.find();
//   final GetStorage _storage = GetStorage();
//   final String _currentStoryKey = 'currentStory';
//   final String _desiredStoryKey = 'desiredStory';
//
//   // StoryRepo._internal();
//
//   Future<void> saveOrUpdateStory(StoryModel story) async {
//     final storyJson = story.toJson();
//     if (story.type == StoryType.current) {
//       await _storage.write(_currentStoryKey, storyJson);
//     } else if (story.type == StoryType.desired) {
//       await _storage.write(_desiredStoryKey, storyJson);
//     }
//   }
//
//   Future<StoryModel?> fetchCurrentStory() async {
//     final storyJson = _storage.read(_currentStoryKey);
//     if (storyJson != null) {
//       return StoryModel.fromJson(storyJson);
//     }
//     return null;
//   }
//
//   Future<StoryModel?> fetchDesiredStory() async {
//     final storyJson = _storage.read(_desiredStoryKey);
//     if (storyJson != null) {
//       return StoryModel.fromJson(storyJson);
//     }
//     return null;
//   }
//
//   Future<void> deleteStory(String storyId) async {
//     // Assuming you've implemented a way to uniquely identify stories by ID
//     final currentStoryJson = _storage.read(_currentStoryKey);
//     if (currentStoryJson != null && StoryModel.fromJson(currentStoryJson).storyId == storyId) {
//       await _storage.remove(_currentStoryKey);
//     }
//
//     final desiredStoryJson = _storage.read(_desiredStoryKey);
//     if (desiredStoryJson != null && StoryModel.fromJson(desiredStoryJson).storyId == storyId) {
//       await _storage.remove(_desiredStoryKey);
//     }
//   }
// }

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../features/mySpace/story/model/story_model.dart';
import '../../../../utils/constants/enums.dart';

class StoryRepo extends GetxService {
  static StoryRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();

  Future<void> initStorage() async => await GetStorage.init();

  Future<bool> saveStory(StoryModel story) async {
    try {
      final key = story.type == StoryType.current ? 'currentStory' : 'desiredStory';
      await _storage.write(key, story.toJson());
      return true;
    } catch (e) {
      print("Error saving story: $e");
      return false;
    }
  }

  Future<StoryModel?> fetchStory(StoryType type) async {
    try {
      final key = type == StoryType.current ? 'currentStory' : 'desiredStory';
      final data = _storage.read(key);
      if (data != null) {
        return StoryModel.fromJson(data);
      }
      return null;
    } catch (e) {
      print("Error fetching story: $e");
      return null;
    }
  }

  Future<bool> deleteStory(StoryType type) async {
    try {
      final key = type == StoryType.current ? 'currentStory' : 'desiredStory';
      await _storage.remove(key);
      return true;
    } catch (e) {
      print("Error deleting story: $e");
      return false;
    }
  }
}

