import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../../features/mySpace/journal/model/journal_model.dart';


class JournalGetStorage {
  static final GetStorage _storage = GetStorage();
  static const String _journalKeyPrefix = 'journal_';

  static String _formatDate(DateTime dateTime) {
    return DateFormat('d, MMMM, yyyy').format(dateTime);
  }

  static String _getStorageKey(DateTime dateTime) {
    return '$_journalKeyPrefix${_formatDate(dateTime)}';
  }

  static Future<void> init() async {
    await GetStorage.init();
  }

  static List<JournalModel> getListOfJournals(DateTime dateTime) {
    String key = _getStorageKey(dateTime);
    var storedData = _storage.read(key);
    if (storedData != null) {
      List<dynamic> decodedData = jsonDecode(storedData);
      return decodedData
          .map((e) => JournalModel.fromMap(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  static void saveJournal({
    required DateTime dateTime,
    required JournalModel journalModel,
  }) {
    List<JournalModel> journals = getListOfJournals(dateTime);
    if (!journals.any((jm) => jm.journalId == journalModel.journalId)) {
      journals.add(journalModel);
    }
    _storage.write(_getStorageKey(dateTime), jsonEncode(journals.map((jm) => jm.toMap()).toList()));
  }

  static void updateJournal({
    required DateTime dateTime,
    required JournalModel journalModel,
  }) {
    List<JournalModel> journals = getListOfJournals(dateTime);
    int index = journals.indexWhere((jm) => jm.journalId == journalModel.journalId);
    if (index != -1) {
      journals[index] = journalModel;
      _storage.write(_getStorageKey(dateTime), jsonEncode(journals.map((jm) => jm.toMap()).toList()));
    }
  }

  static void deleteJournal({
    required DateTime dateTime,
    required JournalModel journalModel,
  }) {
    List<JournalModel> journals = getListOfJournals(dateTime);
    journals.removeWhere((jm) => jm.journalId == journalModel.journalId);
    _storage.write(_getStorageKey(dateTime), jsonEncode(journals.map((jm) => jm.toMap()).toList()));
  }

  static Future<int> getMonthNumOfEntries(DateTime dateTime) async {
    int entries = 0;
    int daysInMonth = DateTime(dateTime.year, dateTime.month + 1, 0).day;
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(dateTime.year, dateTime.month, i);
      var dailyEntries = getListOfJournals(date);
      entries += dailyEntries.length;
    }
    return entries;
  }
}
