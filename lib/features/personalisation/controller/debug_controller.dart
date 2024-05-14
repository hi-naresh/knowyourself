import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/mood/controller/add_mood_controller.dart';

import '../../../data/repo/space/mood/mood_repo.dart';
import '../../mySpace/mood/model/mood_model_input.dart';

class DebugController extends GetxController {
  static DebugController get instance => Get.find();

  final _moodRepo = Get.put(MoodRepo());

  final addMoodController = Get.put(AddMoodController());

  // final _modelService = ModelService(); // Don't use Get.put here, it's unnecessary.

  @override
  Future<void> onInit() async {
    // await initModelService(); // await the initialization
    super.onInit();
  }

  // Future<void> initModelService() async {
  //   await _modelService.onInit();
  // }


  Future<void> onPressed() async {
    MoodModel currentMood = MoodModel(
      mood: "sad",
      aspect: "emotional",
      reason: "I am feeling sad",
      place: "work",
      shift: true,
      id: '',  // Ensure you have a valid ID if necessary
      entryDate: DateTime.now(),
    );
    // Test model
    // addMoodController.shiftMood();
  }
}