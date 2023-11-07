import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/models/journals/journal_model.dart';
import 'package:knowyourself/utils/utils_functions.dart';

class JournalHiveBox {
  static Future<void> init({required DateTime dateTime}) async {
    await Hive.openBox(DateFormat('d, MMMM, yyyy').format(dateTime));
  }

  static Box getBox({required DateTime dateTime}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }

    return Hive.box(
      DateFormat('d, MMMM, yyyy').format(dateTime),
    );
  }

  static void closeBox({required DateTime dateTime}) {
    if (Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      getBox(dateTime: dateTime).close();
    }
  }

  static Future<bool> _isBoxExist({required DateTime dateTime}) async {
    bool isExist =
        await Hive.boxExists(DateFormat('d, MMMM, yyyy').format(dateTime));

    return isExist;
  }

  static List<JournalModel> getListofJournals({required DateTime dateTime}) {
    List<JournalModel> journals = [];

    Box box = getBox(dateTime: dateTime);
    if (box.isOpen) {
      var keys = box.keys;
      for (var key in keys) {
        journals.add(JournalModel.fromMap(jsonDecode(
          jsonEncode(
            box.get(key),
          ),
        ) as Map<String, dynamic>));
      }
      return journals;
    }

    return journals;
  }

  static void saveJournal(
      {required DateTime dateTime, required JournalModel journalModel}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }
    getBox(dateTime: dateTime)
        .put(journalModel.journalId, journalModel.toMap());
  }

  static void updateJournal(
      {required DateTime dateTime, required JournalModel journalModel}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }
    getBox(dateTime: dateTime)
        .putAt(journalModel.journalId, journalModel.toMap());
  }

  static void deleteJournal(
      {required DateTime dateTime, required JournalModel journalModel}) {
    if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(dateTime))) {
      init(dateTime: dateTime);
    }

    getBox(dateTime: dateTime).delete(journalModel.journalId);
  }

  static Future<int> getMonthNumofEntries({required DateTime dateTime}) async {
    int entries = 0;
    int daysInMonth = dateTime.daysInMonth;
    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(dateTime.year, dateTime.month, i);
      if (await _isBoxExist(dateTime: date)) {
        if (!Hive.isBoxOpen(DateFormat('d, MMMM, yyyy').format(date))) {
          await Hive.openBox(DateFormat('d, MMMM, yyyy').format(date));
        }
        entries += JournalHiveBox.getListofJournals(dateTime: date).length;
      }
    }
    return entries;
  }
}
