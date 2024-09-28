import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../data/repo/space/journal/journal_repo.dart';
import '../../../../utils/constants/text_strings.dart';
import '../model/journal_model.dart';
import '../screens/journal_view_entry/journal_view_entry.dart';

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
    journalEntries.refresh();
    // ever(currentDate, (_) => loadJournalEntries());
    // addJournalManually();
  }

  String maxCoreValue() {
    //it is Map<String , double> , accordingly find max core value
    double max = 0;
    String maxCoreValue = '';
    for (var element in journalEntries) {
      element.coreValues.forEach((key, value) {
        if (value > max) {
          max = value;
          maxCoreValue = key;
        }
      });
    }
    return maxCoreValue;
  }

  Color getColorForCoreValue() {
    switch (maxCoreValue()) {
      case 'progress':
        return KColors.valueProgress;
      case 'receptivity':
        return KColors.valueReceptivity;
      case 'aspiration':
        return KColors.valueAspiration;
      case 'perseverance':
        return KColors.valuePerseverance;
      case 'gratitude':
        return KColors.valueGratitude;
      case 'humility':
        return KColors.valueHumility;
      case 'sincerity':
        return KColors.valueSincerity;
      case 'peace':
        return KColors.valuePeace;
      case 'equanimity':
        return KColors.valueEquanimity;
      case 'generosity':
        return KColors.valueGenerosity;
      case 'goodness':
        return KColors.valueGoodness;
      case 'courage':
        return KColors.valueCourage;
      default:
        return KColors.kEmptyProgress;
    }
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
      KHelper.showSnackBar(KTexts.futureDateError1, KTexts.futureDateError2);
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

  viewJournalEntry(JournalEntry journalEntry) {
    Get.to(() => JournalEntryView(journalEntry: journalEntry));
  }

}
