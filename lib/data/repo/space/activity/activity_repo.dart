import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';

class ActivityRepo extends GetxService {
  static ActivityRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'last_activities';

  @override
  Future<void> onInit() async {
      super.onInit();
  }

  Future<void> saveLastActivities(List<ActivityModel> activities) async {
    var newActivities = <ActivityModel>[];
    var activitiesRaw = _storage.read(_storageKey);
     // print(activitiesRaw);
    // [{"id":"16","userId":"1","title":"Discover New Podcast Pleasures","instructions":["Step 1: Explore different genres and topics of podcasts that interest you, such as self-improvement, storytelling, or comedy.","Step 2: Listen to episodes from various podcasts to discover new favorites and expand your knowledge.","Step 3: Subscribe to podcasts that resonate with you and make listening a regular part of your routine, whether during commutes, workouts, or downtime.","Step 4: Engage with podcast communities online to discuss episodes, share recommendations, and connect with like-minded listeners."],"link":"https://www.podcastinsights.com/best-podcasts/","duration":"","imageUrl":"assets/illustrations/health9.svg","color":"#aebfff","tag":"Physical health"}]
    if (activitiesRaw is List) {
      List<dynamic> activitiesJson = activitiesRaw;
      newActivities = activitiesJson.map((activityMap) => ActivityModel.fromJson(activityMap)).toList();
    }
    newActivities.addAll(activities);
    await _storage.write(_storageKey, jsonEncode(newActivities.map((e) => e.toMap()).toList()));
  }

  Future<List<ActivityModel>> getLastActivities() async {
    var activitiesRaw = _storage.read(_storageKey);
    if (activitiesRaw is String) {
      List<dynamic> activitiesJson = jsonDecode(activitiesRaw);
      // List<ActivityModel> activities = activitiesJson.map((activityMap) => ActivityModel.fromMap(activityMap)).toList();
      // solve above line
      List<ActivityModel> activities = activitiesJson.map((activityMap) => ActivityModel.fromJson(activityMap)).toList();
      return activities;
    }
    return [];
  }

  Future<void> clearLastActivities() async {
    await _storage.remove(_storageKey);
  }

  @override
  void onClose() {
    super.onClose();
  }

}