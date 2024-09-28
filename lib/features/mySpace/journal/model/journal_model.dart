
class JournalEntry {
  String id;
  String userId;
  String content;
  DateTime entryDate;
  String? imagePath;
  String? locationPath;
  String? audioPath;
  Map<String, double> coreValues;
  bool analyzed = false;


  JournalEntry({
    required this.id,
    required this.userId,
    required this.content,
    required this.entryDate,
    this.imagePath,
    this.locationPath,
    this.audioPath,
    this.coreValues = const {},
    this.analyzed = false,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] ?? '',
      userId: json['userId']??'',
      content: json['content'] ?? '',
      entryDate: DateTime.parse(json['entryDate'] as String),
      imagePath: json['imagePath'],
      locationPath: json['locationPath'],
      audioPath: json['audioPath'],
      // coreValues: Map<String, double>.from(json['coreValues']),
      coreValues: json['coreValues'] == null ? {} : Map<String, double>.from(json['coreValues']),
      analyzed: json['analyzed'] ?? false,
      // coreValues: (json['coreValues'] as Map<String, dynamic>)
      //     .map((key, value) => MapEntry(key, value.toDouble())),

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'entryDate': entryDate.toIso8601String(),
      'imagePath': imagePath,
      'locationPath': locationPath,
      'audioPath': audioPath,
      'coreValues': coreValues.map((key, value) => MapEntry(key, value)),
      'analyzed': analyzed,
      // 'coreValues': coreValues.map((key, value) => MapEntry(key.toString(), value)),
    };
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, userId: $userId, content: $content, entryDate: $entryDate, imagePath: $imagePath, locationPath: $locationPath, audioPath: $audioPath}';
  }

  static List<JournalEntry> fromMap(List<Map<String, dynamic>> entryMapList) {
    return entryMapList.map((entryMap) {
      return JournalEntry.fromJson(entryMap);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }
}
