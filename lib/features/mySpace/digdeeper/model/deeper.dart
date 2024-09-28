class DigDeeperModel {
  final String incidentId;
  final String title;
  final Map<String, SoulForceAnswers> soulForceAnswers;

  DigDeeperModel({
    required this.incidentId,
    required this.title,
    required this.soulForceAnswers,
  });

  // Convert a DigDeeperModel into a Map for storage
  Map<String, dynamic> toJson() {
    return {
      'incidentId': incidentId,
      'title': title,
      'soulForceAnswers': soulForceAnswers.map((key, value) => MapEntry(key, value.toJson())),
    };
  }

  // Create a DigDeeperModel from a Map
  factory DigDeeperModel.fromJson(Map<String, dynamic> json) {
    return DigDeeperModel(
      incidentId: json['incidentId'] ?? '', // Fallback to empty string if null
      title: json['title'] ?? '', // Fallback to empty string if null
      soulForceAnswers: (json['soulForceAnswers'] != null)
          ? (json['soulForceAnswers'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(
          key,
          SoulForceAnswers.fromJson(Map<String, dynamic>.from(value ?? {})), // Safely handle null value
        ),
      )
          : {}, // Fallback to empty map if null
    );
  }
}

class SoulForceAnswers {
  final String what;
  final String why;
  final String how;

  SoulForceAnswers({
    required this.what,
    required this.why,
    required this.how,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'what': what,
      'why': why,
      'how': how,
    };
  }

  // Factory method to create from JSON
  factory SoulForceAnswers.fromJson(Map<String, dynamic> json) {
    return SoulForceAnswers(
      what: json['what'] ?? '', // Fallback to empty string if null
      why: json['why'] ?? '',   // Fallback to empty string if null
      how: json['how'] ?? '',   // Fallback to empty string if null
    );
  }
}
