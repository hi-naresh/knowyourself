import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../features/mySpace/mood/model/mood_model_input.dart';
import '../../../services/mood_shifter/model_service.dart';
import '../../../../features/personalisation/controller/user_controller.dart';

class MoodRepo extends GetxController {
  static MoodRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'moodEntries';

  final ModelService _modelService = ModelService();

  // Ensure you call this method at the appropriate time to initialize ModelService
  Future<void> initModelService() async {
    await _modelService.init();
  }

  Future<void> saveMoodModel(MoodModel entry) async {
    // Get the current list of mood entries
    var currentEntries = _getMoodEntriesFromStorage();
    // Add the new entry
    currentEntries.add(entry);
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
  }

  List<MoodModel> _getMoodEntriesFromStorage() {
    var entriesJsonString = _storage.read(_storageKey);
    final userID = UserController.instance.user.value.id.toString();
    // Decode the JSON string into a list of maps
    if (entriesJsonString != null) {
      List<dynamic> entriesJson = jsonDecode(entriesJsonString);
      // Convert the list of maps to a list of MoodModel objects
      List<MoodModel> entries = entriesJson.map((entryMap) {
        return MoodModel.fromJson(entryMap);
      }).where((entry) => entry.id == userID).toList();
      return entries;
    } else {
      return [];
    }
  }

  Future<List<MoodModel>> getMoodEntries() async {
    return _getMoodEntriesFromStorage();
  }

  Future<void> updateMoodModel(MoodModel updatedEntry) async {
    var currentEntries = _getMoodEntriesFromStorage();

    // Find the index of the entry we're updating
    int indexToUpdate = currentEntries.indexWhere((entry) => entry.id == updatedEntry.id);

    if (indexToUpdate != -1) {
      currentEntries[indexToUpdate] = updatedEntry;
      await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
    }
  }

  Future<void> deleteMoodModel(String entryId) async {
    var currentEntries = _getMoodEntriesFromStorage();

    // Remove the entry with the given id
    currentEntries.removeWhere((entry) => entry.id == entryId);

    // Save the updated list back to storage
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
  }

  Future<List<dynamic>> exportMoodEntries() async {
    // Fetch mood entries, serialize, and return
    var entries = _getMoodEntriesFromStorage();
    return Future.value(entries.map((entry) => entry.toMap()).toList());
  }

  Future<void> importMoodEntries(List<dynamic> entries) async {
    // Deserialize entries and save them
    var moodEntries = entries.map((entry) => MoodModel.fromJson(entry)).toList();
    await _storage.write(_storageKey, jsonEncode(moodEntries.map((e) => e.toMap()).toList()));
  }

  Future<int> getNumberOfEntries(DateTime currentDate) {
    var currentEntries = _getMoodEntriesFromStorage();

    // Filter the entries to get only the ones for the current date
    var entriesForDate = currentEntries.where((entry) => entry.createdOn == currentDate);

    return Future.value(entriesForDate.length);
  }
}

