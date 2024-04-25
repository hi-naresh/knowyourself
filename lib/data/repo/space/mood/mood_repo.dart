import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../features/mySpace/mood/model/mood_model_input.dart';

class MoodRepo extends GetxService {
  static MoodRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'moodEntries';

  Future<void> saveMoodEntry(MoodModel entry) async {
    var currentEntries = await getMoodEntries();
    currentEntries.add(entry);
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toJson()).toList()));
  }

  Future<List<MoodModel>> getMoodEntries() async {
    var entriesJsonString = _storage.read<String>(_storageKey);
    if (entriesJsonString != null) {
      List<dynamic> entriesJson = jsonDecode(entriesJsonString);
      List<MoodModel> entries = entriesJson.map((entryMap) => MoodModel.fromJson(entryMap)).toList();
      return entries;
    } else {
      return [];
    }
  }

  Future<void> updateMoodEntry(String id, MoodModel updatedEntry) async {
    var currentEntries = await getMoodEntries();
    int indexToUpdate = currentEntries.indexWhere((entry) => entry.id == id);
    if (indexToUpdate != -1) {
      currentEntries[indexToUpdate] = updatedEntry;
      await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toJson()).toList()));
    }
  }

  Future<void> deleteMoodEntry(String id) async {
    var currentEntries = await getMoodEntries();
    currentEntries.removeWhere((entry) => entry.id == id);
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toJson()).toList()));
  }

}
