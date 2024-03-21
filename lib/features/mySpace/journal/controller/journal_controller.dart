import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/journal_model.dart';

class JournalController extends GetxController {
  static JournalController get instance => Get.find();
  final FirebaseFirestoreService _firestoreService = FirebaseFirestoreService();
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _notesEditingController = TextEditingController();
  final PageController _pageController = PageController();
  var _dateTime = DateTime.now().obs;
  var _listOfJournals = <JournalModel>[].obs;

  DateTime get getDate => _dateTime.value;
  List<JournalModel> get journals => _listOfJournals;
  TextEditingController get titleEditingController => _titleEditingController;
  TextEditingController get notesEditingController => _notesEditingController;
  PageController get pageController => _pageController;

  @override
  void onInit() {
    super.onInit();
    // Initialize data or listeners if needed
  }

  void updateDate(DateTime dateTime) async {
    try {
      _dateTime.value = dateTime;
      _listOfJournals.value = await _firestoreService.getJournalEntries().first;
    } catch (e) {
      print('Error updating date and journal entries: $e');
      // Handle error
    }
  }

  void updateJournalList(JournalModel journalModel) async {
    try {
      await _firestoreService.addJournalEntry(journalModel);
      _listOfJournals.add(journalModel);
    } catch (e) {
      print('Error updating journal list: $e');
      // Handle error
    }
  }

  void deleteJournal({required JournalModel journalModel}) async {
    try {
      await _firestoreService.deleteJournal(journalModel: journalModel);
      _listOfJournals.remove(journalModel);
    } catch (e) {
      print('Error deleting journal entry: $e');
      // Handle error
    }
  }
}


class FirebaseFirestoreService {
  static final FirebaseFirestoreService _instance =
  FirebaseFirestoreService._internal();

  factory FirebaseFirestoreService() {
    return _instance;
  }

  FirebaseFirestoreService._internal();

  final CollectionReference _journalCollection =
  FirebaseFirestore.instance.collection('journals');

  Future<void> addJournalEntry(JournalModel journalModel) async {
    try {
      DocumentReference docRef = await _journalCollection.add({
        'createdOn': DateTime.now(),
        'mood': journalModel.mood,
        'title': journalModel.title,
        'description': journalModel.description,
        'journalId': journalModel.journalId, // Include journalId in Firestore document
      });
      // Update the journalModel with the Firestore document ID
      journalModel = journalModel.copyWith(id: docRef.id);
    } catch (e) {
      print('Error adding journal entry: $e');
      throw 'Failed to add journal entry';
    }
  }

  Future<void> deleteJournal({required JournalModel journalModel}) async {
    try {
      await _journalCollection.doc(journalModel.id.toString()).delete();
    } catch (e) {
      print('Error deleting journal entry: $e');
      throw 'Failed to delete journal entry';
    }
  }

  Stream<List<JournalModel>> getJournalEntries() {
    try {
      return _journalCollection.snapshots().map((snapshot) => snapshot.docs
          .map((doc) => JournalModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList());
    } catch (e) {
      print('Error getting journal entries: $e');
      throw 'Failed to get journal entries';
    }
  }
}

