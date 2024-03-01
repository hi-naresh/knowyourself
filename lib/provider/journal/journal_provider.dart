import 'package:flutter/material.dart';
import 'package:knowyourself/models/journals/journal_model.dart';

import 'firebase_firestore_service.dart';

class JournalProvider with ChangeNotifier {
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();
  final PageController _pageController = PageController();
  DateTime _dateTime = DateTime.now();
  List<JournalModel> _listOfJournals = [];

  DateTime get getDate => _dateTime;
  List<JournalModel> get journals => _listOfJournals;
  TextEditingController get titleEditingController => _titleEditingController;
  TextEditingController get notesEditingController => _notesEditingController;
  PageController get pageController => _pageController;

  void updateDate(DateTime dateTime) async {
    try {
      _dateTime = dateTime;
      notifyListeners();
      _listOfJournals = await _firestoreService.getJournalEntries().first;
      notifyListeners();
    } catch (e) {
      print('Error updating date and journal entries: $e');
      // Handle error
    }
  }

  void updateJournalList(JournalModel journalModel) async {
    try {
      await _firestoreService.addJournalEntry(journalModel);
      _listOfJournals.add(journalModel);
      notifyListeners();
    } catch (e) {
      print('Error updating journal list: $e');
      // Handle error
    }
  }

  void deleteJournal({required JournalModel journalModel}) async {
    try {
      await _firestoreService.deleteJournal(journalModel: journalModel);
      _listOfJournals.remove(journalModel);
      notifyListeners();
    } catch (e) {
      print('Error deleting journal entry: $e');
      // Handle error
    }
  }
}
