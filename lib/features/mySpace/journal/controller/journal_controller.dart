import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../data/repo/space/journal/journal_repo.dart';
import '../model/journal_model.dart';

class JournalController extends GetxController {
  static JournalController get instance => Get.find();
  final RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;

  var currentDate = DateTime.now().obs;
  late ScrollController scrollController;
  late double initialScrollIndex;

  @override
  void onReady() {
    super.onReady();
    initialScrollIndex = currentDate.value.day - 1;
    scrollController = ScrollController(initialScrollOffset: initialScrollIndex * 70.0);
    loadJournalEntries();
    // ever(currentDate, (_) => loadJournalEntries());
    // addJournalManually();
  }


// Method to load all journal entries from the repository
  void loadJournalEntries() async {
    List<JournalEntry> entries = await JournalRepo.instance.getJournalEntries();
    // Filter entries for today's date
    var todayEntries = entries.where((entry) {
      DateTime normalizedEntryDate = DateTime(
          entry.entryDate.year, entry.entryDate.month, entry.entryDate.day);
      return normalizedEntryDate.isAtSameMomentAs(
        DateTime(currentDate.value.year, currentDate.value.month, currentDate.value.day),
      );
    }).toList();
    journalEntries.assignAll(todayEntries);
  }


// Method to add a new journal entry
  Future<void> addJournalEntry(JournalEntry entry) async {
    await JournalRepo.instance.saveJournalEntry(entry);
    journalEntries.add(entry);
  }

  DateTime day(int day) {
    return DateTime.now().subtract(Duration(days: day));
  }


// Method to update an existing journal entry
  Future<void> updateJournalEntry(JournalEntry entry) async {
    await JournalRepo.instance.updateJournalEntry(entry);
    int index = journalEntries.indexWhere((e) => e.id == entry.id);
    if (index != -1) {
      journalEntries[index] = entry;
    }
  }

// Method to delete a journal entry
  Future<void> deleteJournalEntry(String entryId) async {
    await JournalRepo.instance.deleteJournalEntry(entryId);
    journalEntries.removeWhere((entry) => entry.id == entryId);
  }

// Method to clear the list of journal entries (if needed)
  void clearJournalEntries() {
    journalEntries.clear();
  }

  void updateDate(DateTime selectedDay) {
    if (selectedDay.isAfter(DateTime.now())) {
      KHelper.showSnackBar(
          'Cannot select future date', 'Cannot select future dates');
      return;
    }
    currentDate.value = selectedDay;
    JournalRepo.instance.getJournalEntries().then((entries) {
      var filteredEntries = entries.where((entry) {
        // Normalize entry's date for comparison
        DateTime normalizedEntryDate = DateTime(
            entry.entryDate.year, entry.entryDate.month, entry.entryDate.day);
        // Compare normalized dates
        return normalizedEntryDate.isAtSameMomentAs(selectedDay);
      }).toList();
      journalEntries.assignAll(filteredEntries);
    });
  }

  String getNumberOfEntries() {
    return journalEntries.length.toString();
  }

}
