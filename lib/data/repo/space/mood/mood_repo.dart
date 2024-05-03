import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';
import '../../../../features/mySpace/mood/model/mood_model_input.dart';
import '../../../../features/personalisation/controller/user_controller.dart';
import '../../../services/mood_shifter/mood_shift_service.dart';

// class MoodRepo extends GetxService {
//   static MoodRepo get instance => Get.find();
//   final GetStorage _storage = GetStorage();
//   final String _storageKey = 'moodEntries';
//
//   Future<void> saveMoodEntry(MoodModel entry) async {
//     var currentEntries = await getMoodEntries();
//     currentEntries.add(entry);
//     await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toJson()).toList()));
//   }
//
//   Future<List<MoodModel>> getMoodEntries() async {
//     var entriesJsonString = _storage.read<String>(_storageKey);
//     if (entriesJsonString != null) {
//       List<dynamic> entriesJson = jsonDecode(entriesJsonString);
//       List<MoodModel> entries = entriesJson.map((entryMap) => MoodModel.fromJson(entryMap)).toList();
//       return entries;
//     } else {
//       return [];
//     }
//   }
//
//   Future<void> updateMoodEntry(String id, MoodModel updatedEntry) async {
//     var currentEntries = await getMoodEntries();
//     int indexToUpdate = currentEntries.indexWhere((entry) => entry.id == id);
//     if (indexToUpdate != -1) {
//       currentEntries[indexToUpdate] = updatedEntry;
//       await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toJson()).toList()));
//     }
//   }
//
//   Future<void> deleteMoodEntry(String id) async {
//     var currentEntries = await getMoodEntries();
//     currentEntries.removeWhere((entry) => entry.id == id);
//     await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toJson()).toList()));
//   }
//
// }


class MoodRepo extends GetxService {
  static MoodRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'moodEntries';

  // final _modelService = Get.put(ModelService());
  final _modelService = ModelService(); // Don't use Get.put here, it's unnecessary.


  // @override
  // void onInit() {
  //   super.onInit();
  //   // Ensure you call this method at the appropriate time to initialize ModelService
  //   initModelService();
  // } // Ensure you call this method at the appropriate time to initialize ModelService
  // Future<void> initModelService() async {
  //   await _modelService;
  // }

  @override
  Future<void> onInit() async {
    await initModelService(); // await the initialization
    super.onInit();
  }

  Future<void> initModelService() async {
    await _modelService.onInit();
  }

  Future<void> saveMoodEntry(MoodModel entry) async {
    // Get the current list of mood entries
    var currentEntries = _getMoodEntriesFromStorage();
    // Add the new entry
    currentEntries.add(entry);
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
    _storage.read(_storageKey);
  }

  // List<ActivityModel> parseActivities(List<dynamic> jsonList) {
  //   return jsonList.map((json) {
  //     if (json is Map<String, dynamic>) {
  //       return ActivityModel.fromJson(json);
  //     } else {
  //       throw Exception('Expected a map but got: ${json.runtimeType}');
  //     }
  //   }).toList();
  // }

  // Future<List<ActivityModel>> recommendActivity(MoodModel mood, int moodIndex, int aspectIndex, int placeIndex, int reasonIndex) async {
  //   // Get the mood shift prediction from the model
  //   List<ActivityModel> recommendedActivities = _modelService.getActivitiesForMood(moodIndex, aspectIndex, placeIndex, reasonIndex);
  //
  //   return recommendedActivities;
  // }


  Future<List<String>> recommendActivity(MoodModel mood, int moodIndex, int aspectIndex, int placeIndex, int reasonIndex ) async {
    //store list dynamic into list string , then return
    List<String> recommendedActivities = [];
    List<dynamic> temp=[];
    // Get the current list of mood entries
    // var currentEntries = _getMoodEntriesFromStorage();
    // // Add the new entry
    // currentEntries.add(mood);
    // await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
    // _storage.read(_storageKey);
    // Get the mood shift prediction from the model
    // int moodShift = await _modelService.predictMoodShiftFromModel(mood);

    temp = await _modelService.getActivitiesForMood( moodIndex, aspectIndex, placeIndex, reasonIndex);
    //convert list dynamic to list string
    recommendedActivities = temp.map((e) => e.toString()).toList();
    // recommendedActivities = parseActivities(temp)
    //dynamic into ActivityModel
    // temp2 = parseActivities(temp);
    return recommendedActivities;
  }

  // List<MoodModel> _getMoodEntriesFromStorage() {
  //   var entriesJsonString = _storage.read(_storageKey);
  //   final userID = UserController.instance.user.value.id.toString();
  //   // Decode the JSON string into a list of maps
  //   if (entriesJsonString != null) {
  //     List<dynamic> entriesJson = jsonDecode(entriesJsonString);
  //     // Convert the list of maps to a list of MoodModel objects
  //     List<MoodModel> entries = entriesJson.map((entryMap) {
  //       return MoodModel.fromJson(entryMap);
  //     }).where((entry) => entry.id == userID).toList();
  //     return entries;
  //   } else {
  //     return [];
  //   }
  // }

  List<MoodModel> _getMoodEntriesFromStorage() {
    var entriesRaw = _storage.read(_storageKey);
    if (entriesRaw is String) {
      List<dynamic> entriesJson = jsonDecode(entriesRaw);
      List<MoodModel> entries = entriesJson.map((entryMap) => MoodModel.fromMap(entryMap)).toList();
      return entries;
    } else {
      return [];
    }

  }

  Future<List<MoodModel>> getMoodEntries() async {
    return _getMoodEntriesFromStorage();
  }

  Future<void> updateMoodEntry(MoodModel updatedEntry) async {
    var currentEntries = _getMoodEntriesFromStorage();

    // Find the index of the entry we're updating
    int indexToUpdate = currentEntries.indexWhere((entry) => entry.id == updatedEntry.id);

    if (indexToUpdate != -1) {
      currentEntries[indexToUpdate] = updatedEntry;
      await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
    }
  }

  Future<void> deleteMoodEntry(String entryId) async {
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
    var entriesForDate = currentEntries.where((entry) => entry.entryDate == currentDate);

    return Future.value(entriesForDate.length);
  }
}
