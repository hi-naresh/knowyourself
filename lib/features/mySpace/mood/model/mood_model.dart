// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';
//
// enum Mood { happy, sad, angry, neutral, crying }
//
// enum AtWhatPlace {
//   work,
//   home,
//   personal,
//   social,
// }
//
// enum Emotion {
//   // Happy emotions
//   excited,
//   content,
//   joyful,
//   grateful,
//   energetic,
//   optimistic,
//   satisfied,
//   playful,
//   amused,
//   blissful,
//
//   // Sad emotions
//   depressed,
//   lonely,
//   disappointed,
//   heartbroken,
//   melancholy,
//   gloomy,
//   regretful,
//   despairing,
//   pensive,
//   tearful,
//
//   // Neutral emotions
//   calm,
//   relaxed,
//   indifferent,
//   balanced,
//   unbothered,
//   serene,
//   composed,
//   nonchalant,
//   detached,
//   accepting,
//
//   // Angry emotions
//   frustrated,
//   irritated,
//   annoyed,
//   furious,
//   enraged,
//   resentful,
//   agitated,
//   incensed,
//   vengeful,
//   outraged,
//
//   // Crying emotions
//   overwhelmed,
//   vulnerable,
//   griefStricken,
//   helpless,
//   upset,
//   distressed,
//   anguished,
//   despondent,
// }
//
// class MoodCheckIn {
//   DateTime dateTime;
//   Mood mood;
//   AtWhatPlace whichPlace;
//   int point;
//   MoodCheckIn({
//     required this.dateTime,
//     required this.mood,
//     required this.whichPlace,
//     required this.point,
//   });
//
//   MoodCheckIn copyWith({
//     DateTime? dateTime,
//     Mood? mood,
//     AtWhatPlace? whichPlace,
//     int? point,
//   }) {
//     return MoodCheckIn(
//       dateTime: dateTime ?? this.dateTime,
//       mood: mood ?? this.mood,
//       whichPlace: whichPlace ?? this.whichPlace,
//       point: point ?? this.point,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'dateTime': dateTime.millisecondsSinceEpoch,
//       'mood': mood.index,
//       'whichPlace': whichPlace.index,
//       'point': point,
//     };
//   }
//
//   factory MoodCheckIn.fromMap(Map<String, dynamic> map) {
//     return MoodCheckIn(
//       dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
//       mood: Mood.values[map['mood']],
//       whichPlace: AtWhatPlace.values[map['whichPlace']],
//       point: map['point'] as int,
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   factory MoodCheckIn.fromJson(String source) =>
//       MoodCheckIn.fromMap(json.decode(source) as Map<String, dynamic>);
//
//   @override
//   String toString() {
//     return 'MoodCheckIn(dateTime: $dateTime, mood: $mood, whichPlace: $whichPlace, point: $point)';
//   }
//
// }
