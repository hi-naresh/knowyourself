import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../utils/constants/text_strings.dart';
import '../model/gratitude_model.dart';

class GratitudeController extends GetxController {
  static GratitudeController get instance => Get.find();
  final Rx<GratitudeModel> gratitudeModel = GratitudeModel(title:  KTexts.randomAct).obs;
  final TextEditingController celebrationTextEditingController = TextEditingController();
  final RxString _celebrationString = ''.obs;
  final GetStorage _storage = GetStorage();

  static const String _storageKey = 'celebrationString';

  GratitudeModel get getterGratitudeModel => gratitudeModel.value;
  set getterGratitudeModel(GratitudeModel value) => gratitudeModel.value = value;

  String get celebrationString => _celebrationString.value;
  set celebrationString(String value) => _celebrationString.value = value;

  @override
  void onInit() {
    super.onInit();
    // Load the celebration string from GetStorage
    _celebrationString.value = _storage.read(_storageKey) ?? '';
  }

  void updateCelebration(GratitudeModel celebrationModel) {
    getterGratitudeModel = celebrationModel;
  }

  void saveCelebrationString() {
    celebrationString = getterGratitudeModel.title + celebrationTextEditingController.text;
    // Save the celebration string to GetStorage
    _storage.write(_storageKey, celebrationString);
  }
}
