// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Mood { happy, sad, angry, neutral, crying }

enum SphereofLife {
  work,
  career,
  relationships,
  health,
  environment,
  liesure,
  finance,
  personal,
  friends,
  family,
  society,
}

enum Emotion {
  // Happy emotions
  excited,
  content,
  joyful,
  grateful,
  energetic,
  optimistic,
  satisfied,
  playful,
  amused,
  blissful,

  // Sad emotions
  depressed,
  lonely,
  disappointed,
  heartbroken,
  melancholy,
  gloomy,
  regretful,
  despairing,
  pensive,
  tearful,

  // Neutral emotions
  calm,
  relaxed,
  indifferent,
  balanced,
  unbothered,
  serene,
  composed,
  nonchalant,
  detached,
  accepting,

  // Angry emotions
  frustrated,
  irritated,
  annoyed,
  furious,
  enraged,
  resentful,
  agitated,
  incensed,
  vengeful,
  outraged,

  // Crying emotions
  overwhelmed,
  vulnerable,
  griefStricken,
  helpless,
  upset,
  distressed,
  anguished,
  despondent,
}

class MoodCheckIn {
  DateTime dateTime;
  Mood mood;
  SphereofLife sphereofLife;
  int point;
  Emotion emotion;
  MoodCheckIn({
    required this.dateTime,
    required this.mood,
    required this.sphereofLife,
    required this.point,
    required this.emotion,
  });

  MoodCheckIn copyWith({
    DateTime? dateTime,
    Mood? mood,
    SphereofLife? sphereofLife,
    int? point,
    Emotion? emotion,
  }) {
    return MoodCheckIn(
      dateTime: dateTime ?? this.dateTime,
      mood: mood ?? this.mood,
      sphereofLife: sphereofLife ?? this.sphereofLife,
      point: point ?? this.point,
      emotion: emotion ?? this.emotion,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dateTime': dateTime.millisecondsSinceEpoch,
      'mood': mood.index,
      'sphereofLife': sphereofLife.index,
      'point': point,
      'emotion': emotion.index,
    };
  }

  factory MoodCheckIn.fromMap(Map<String, dynamic> map) {
    return MoodCheckIn(
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      mood: Mood.values[map['mood']],
      sphereofLife: SphereofLife.values[map['sphereofLife']],
      point: map['point'] as int,
      emotion: Emotion.values[map['emotion']],
    );
  }

  String toJson() => json.encode(toMap());

  factory MoodCheckIn.fromJson(String source) =>
      MoodCheckIn.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MoodCheckIn(dateTime: $dateTime, mood: $mood, sphereofLife: $sphereofLife, point: $point, emotion: $emotion)';
  }

  @override
  bool operator ==(covariant MoodCheckIn other) {
    if (identical(this, other)) return true;

    return other.dateTime == dateTime &&
        other.mood == mood &&
        other.sphereofLife == sphereofLife &&
        other.point == point &&
        other.emotion == emotion;
  }

  @override
  int get hashCode {
    return dateTime.hashCode ^
        mood.hashCode ^
        sphereofLife.hashCode ^
        point.hashCode ^
        emotion.hashCode;
  }
}
