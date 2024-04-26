import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/features/personalisation/controller/profile_setup_controller.dart';

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
    await _storage.write(_storageKey, jsonEncode(currentEntries.map((e) => e.toMap()).toList()));
  }

  List<JournalEntry> _getJournalEntriesFromStorage() {
    var entriesJsonString = _storage.read(_storageKey);
    final userID = UserController.instance.user.value.id.toString();
    // final userID = ProfileSetupController.instance.userID.toString();
    // Decode the JSON string into a list of maps
    if (entriesJsonString != null  ) {
      List<dynamic> entriesJson = jsonDecode(entriesJsonString);
      // Convert the list of maps to a list of JournalEntry objects
      List<JournalEntry> entries = entriesJson.map((entryMap) {
        return JournalEntry.fromJson(entryMap);
      }).where((entry) => entry.userId == userID).toList();
      // print("at storage $entries");
      return entries;
    } else {
      return [];
    }
  }

  //getJournalEntriesBy date
  // List<JournalEntry> getJournalEntriesByDate(DateTime date) {
  //   var currentEntries = _getJournalEntriesFromStorage();
  //   print("at repo $currentEntries");
  //   final List<JournalEntry> entries = currentEntries.where((entry) => entry.entryDate == date).toList();
  //   print("at repo $entries");
  //   return entries;
  // }

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

  Future<List<dynamic>> exportJournalEntries() async {
    // Fetch journal entries, serialize, and return
    var entries = _getJournalEntriesFromStorage();
    return Future.value(entries.map((entry) => entry.toMap()).toList());
  }

  Future<void> importJournalEntries(List<dynamic> entries) async {
    // Deserialize entries and save them
    var journalEntries = entries.map((entry) => JournalEntry.fromJson(entry)).toList();
    await _storage.write(_storageKey, jsonEncode(journalEntries.map((e) => e.toMap()).toList()));
  }
  Future<int> getNumberOfEntries(DateTime currentDate) {
    var currentEntries = _getJournalEntriesFromStorage();

    // Filter the entries to get only the ones for the current date
    var entriesForDate = currentEntries.where((entry) => entry.entryDate == currentDate);

    return Future.value(entriesForDate.length);
  }
}