import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../features/mySpace/journal/model/journal_model.dart';
import '../../../../features/personalisation/controller/user_controller.dart';

class JournalRepo extends GetxController{

  static JournalRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'journalEntries';

  Future<void> saveJournalEntry(JournalEntry entry) async {
    // Get the current list of journal entries
    var currentEntries = _getJournalEntriesFromStorage();
    // Add the new entry
    currentEntries.add(entry);
    // Save the updated list back to storage
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
  }

  List<JournalEntry> _getJournalEntriesFromStorage() {
    // Retrieve the stored journal entries JSON string
    var entriesJsonString = _storage.read(_storageKey);
    final userID = UserController.instance.user.value.id.toString();
    // print("$userID , Entries : $entriesJsonString");
    // Decode the JSON string into a list of maps
    if (entriesJsonString != null  ) {
      List<dynamic> entriesJson = jsonDecode(entriesJsonString);
      // Convert the list of maps to a list of JournalEntry objects
      //check if userId matches to journalEntries , then show journal entries
      List<JournalEntry> entries = entriesJson.map((entryMap) {
        return JournalEntry.fromJson(entryMap);
      }).toList();

      bool authenticated = entries.every((element) => element.userId == userID);
      if (authenticated) {
        return entries;
      } else {
        return [];
      }
      // return entries;
    } else {
      return [];
    }
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    return _getJournalEntriesFromStorage();
  }

  Future<void> updateJournalEntry(JournalEntry updatedEntry) async {
    var currentEntries = _getJournalEntriesFromStorage();

    // Find the index of the entry we're updating
    int indexToUpdate = currentEntries.indexWhere((entry) => entry.id == updatedEntry.id);

    if (indexToUpdate != -1) {
      currentEntries[indexToUpdate] = updatedEntry;
      await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
    }
  }

  Future<void> deleteJournalEntry(String entryId) async {
    var currentEntries = _getJournalEntriesFromStorage();

    // Remove the entry with the given id
    currentEntries.removeWhere((entry) => entry.id == entryId);

    // Save the updated list back to storage
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
  }

  Future<int> getNumberOfEntries(DateTime currentDate) {
    var currentEntries = _getJournalEntriesFromStorage();

    // Filter the entries to get only the ones for the current date
    var entriesForDate = currentEntries.where((entry) => entry.entryDate == currentDate);

    return Future.value(entriesForDate.length);
  }
}