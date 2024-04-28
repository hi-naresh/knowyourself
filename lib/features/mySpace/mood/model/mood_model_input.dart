import 'dart:convert';

class MoodModel {
  String id; // Unique identifier for each mood entry
  DateTime entryDate; // Date and time the mood was created
  String mood; // Mood state (e.g., happy, sad, anxious)
  String aspect; // Aspect of life affected (personal aspect)
  String description; // Description or reasons for the mood
  String happenedAt; // Categorization (work, social, home, personal)
  bool shift; //stay or shift

  MoodModel({
    required this.id,
    required this.entryDate,
    required this.mood,
    required this.aspect,
    required this.description,
    required this.happenedAt,
    this.shift = false,
  });

  MoodModel copyWith({
    String? id,
    DateTime? entryDate,
    String? mood,
    String? aspect,
    String? description,
    String? happenedAt,
    bool? shift,
  }) {
    return MoodModel(
      id: id ?? this.id,
      entryDate: entryDate ?? this.entryDate,
      mood: mood ?? this.mood,
      aspect: aspect ?? this.aspect,
      description: description ?? this.description,
      happenedAt: happenedAt ?? this.happenedAt,
      shift: shift ?? this.shift,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'entryDate': entryDate.millisecondsSinceEpoch,
      'mood': mood,
      'aspect': aspect,
      'description': description,
      'happenedAt': happenedAt,
      'shift': shift,
    };
  }

  factory MoodModel.fromMap(Map<String, dynamic> map) {
    return MoodModel(
      id: map['id'] ?? '',
      entryDate: DateTime.fromMillisecondsSinceEpoch(map['entryDate'] ?? 0),
      mood: map['mood'] ?? '',
      aspect: map['aspect'] ?? '',
      description: map['description'] ?? '',
      happenedAt: map['happenedAt'] ?? '',
      shift: map['shift'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory MoodModel.fromJson(String source) =>
      MoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MoodModel(id: $id, entryDate: $entryDate, mood: $mood, aspect: $aspect, description: $description, happenedAt: $happenedAt, shift: $shift)';
  }

  // @override
  // bool operator ==(Object other) {
  //   if (identical(this, other)) return true;
  //
  //   return other is MoodModel &&
  //       other.id == id &&
  //       other.entryDate == entryDate &&
  //       other.mood == mood &&
  //       other.aspect == aspect &&
  //       other.description == description &&
  //       other.happenedAt == happenedAt &&
  //       other.shift == shift;
  // }
  //
  // @override
  // int get hashCode {
  //   return id.hashCode ^
  //       entryDate.hashCode ^
  //       mood.hashCode ^
  //       aspect.hashCode ^
  //       description.hashCode ^
  //       happenedAt.hashCode^
  //       shift.hashCode;
  // }
}
