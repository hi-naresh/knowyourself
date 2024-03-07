import 'package:flutter/material.dart';
import 'package:knowyourself/models/journals/journal_model.dart';

class JournalEditorProvider with ChangeNotifier {
  String _mood = "happy";
  int _index = 0;
  JournalModel? _journalModel;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();
  final PageController _pageController = PageController();

  void changeMood(String mood) {
    _mood = mood;
    notifyListeners();
  }

  void updateIndex(int index) {
    _index = index;
    _pageController.animateToPage(_index,
        duration: const Duration(milliseconds: 200), curve: Curves.linear);
    notifyListeners();
  }

  void getIndexOfPage() {
    _index = index;
    notifyListeners();
  }

  void updateJournal(JournalModel journalModel) {
    _journalModel = journalModel;
  }

  void clearJournalData() {
    _titleEditingController.clear();
    _notesEditingController.clear();
  }

  TextEditingController get titleEditingController => _titleEditingController;
  TextEditingController get notesEditingController => _notesEditingController;
  PageController get pageController => _pageController;

  JournalModel? get journal => _journalModel;

  String get mood => _mood;

  int get index => _index;
}
