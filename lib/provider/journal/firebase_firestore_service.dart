import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knowyourself/models/journals/journal_model.dart';

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
      await _journalCollection.add(journalModel.toMap());
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
