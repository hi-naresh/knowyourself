import 'package:cloud_firestore/cloud_firestore.dart';

class JournalEntry {
  final String mood;
  final String summary;
  final Timestamp timestamp;

  JournalEntry({
    required this.mood,
    required this.summary,
    required this.timestamp,
  });
}
