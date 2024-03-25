class JournalEntry {
  String id;
  String content;
  DateTime entryDate;
  String? imagePath;
  String? locationPath;
  String? audioPath;

  JournalEntry({
    required this.id,
    required this.content,
    required this.entryDate,
    this.imagePath,
    this.locationPath,
    this.audioPath,
  });

  factory JournalEntry.fromJson(Map<String, dynamic> json) {
    return JournalEntry(
      id: json['id'] ?? '',
      content: json['content'] ?? '',
      entryDate: DateTime.parse(json['entryDate'] as String),
      imagePath: json['imagePath'],
      locationPath: json['locationPath'],
      audioPath: json['audioPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'entryDate': entryDate.toIso8601String(),
      'imagePath': imagePath,
      'locationPath': locationPath,
      'audioPath': audioPath,
    };
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, content: $content, entryDate: $entryDate, imagePath: $imagePath, locationPath: $locationPath, audioPath: $audioPath}';
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
