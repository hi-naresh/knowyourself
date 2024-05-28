import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/learning/model/chapter_model.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import '../../../data/repo/materials/resources/remote/resources_online.dart';

class DebugController extends GetxController {
  static DebugController get instance => Get.find();

  // final onlineResources = Get.put(OnlineResources()); // final


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  // RxList<ChapterModel> myResources = <ChapterModel>[].obs;

  //load resources from json
  // Future<void> loadResources() async {
  //   final String resourcesJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
  //   final Map<String, dynamic> resourcesJson = json.decode(resourcesJsonString);
  //   final List<dynamic> resourcesJsonList = resourcesJson['chapters'];
  //
  //   final List<ChapterModel> resourcesList = resourcesJsonList
  //       .map((resource) => ChapterModel.fromMap(resource))
  //       .toList();
  //
  //   myResources.assignAll(resourcesList);
  // }


  Future<void> onPressed() async {
    // loadResources();
    // await onlineResources.saveResourcesToFirestore(myResources);
  }
  
}