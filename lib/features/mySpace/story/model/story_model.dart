import '../../../../utils/constants/enums.dart';

class StoryModel {
  final String storyId;
  final String userId;
  final StoryType type;
  final DateTime savedTime;
  final String character;
  final String aspiration;
  final String qualities;
  final String scenario;
  final String skills;

  StoryModel({
    required this.storyId,
    required this.userId,
    required this.type,
    required this.savedTime,
    required this.character,
    required this.aspiration,
    required this.qualities,
    required this.scenario,
    required this.skills,
  });

  StoryModel copyWith({
    String? storyId,
    String? userId,
    StoryType? type,
    DateTime? savedTime,
    String? character,
    String? aspiration,
    String? qualities,
    String? scenario,
    String? skills,
  }) {
    return StoryModel(
      storyId: storyId ?? this.storyId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      savedTime: savedTime ?? this.savedTime,
      character: character ?? this.character,
      aspiration: aspiration ?? this.aspiration,
      qualities: qualities ?? this.qualities,
      scenario: scenario ?? this.scenario,
      skills: skills ?? this.skills,
    );
  }

  Map<String, dynamic> toJson() => {
    'storyId': storyId,
    'userId': userId,
    'type': type.toJson(),
    'savedTime': savedTime.toIso8601String(),
    'character': character,
    'aspiration': aspiration,
    'qualities': qualities,
    'scenario': scenario,
    'skills': skills,
  };

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
    storyId: json['storyId'],
    userId: json['userId'],
    type: StoryTypeExtension.fromJson(json['type']),
    savedTime: DateTime.parse(json['savedTime']),
    character: json['character'],
    aspiration: json['aspiration'],
    qualities: json['qualities'],
    scenario: json['scenario'],
    skills: json['skills'],
  );
}
