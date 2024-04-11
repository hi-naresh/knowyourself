
class ChoiceModel{
  final String id;
  final String userId;
  List<String> bestMemories;
  Map<String, List<String>> moodSongs;

  ChoiceModel({
    required this.id,
    required this.userId,
    required this.bestMemories,
    required this.moodSongs,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'bestMemories': bestMemories,
    'moodSongs': moodSongs,
  };

  factory ChoiceModel.fromJson(Map<String, dynamic> json) => ChoiceModel(
    id: json['id'],
    userId: json['userId'],
    bestMemories: List<String>.from(json['bestMemories']),
    moodSongs: Map<String, List<String>>.from(json['moodSongs']),
  );

  ChoiceModel copyWith({
    String? id,
    String? userId,
    List<String>? bestMemories,
    Map<String, List<String>>? moodSongs,
  }) {
    return ChoiceModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bestMemories: bestMemories ?? this.bestMemories,
      moodSongs: moodSongs ?? this.moodSongs,
    );
  }

}