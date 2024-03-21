import 'dart:convert';
import 'dart:ui';

class Activity {
  final String title;
  final String duration;
  final String imageUrl;
  final Color color ;

  Activity({
    required this.title,
    required this.duration,
    required this.imageUrl,
    required this.color,
  });

  Activity copyWith({
    String? title,
    String? duration,
    String? imageUrl,
    Color? color,
  }) {
    return Activity(
      title: title ?? this.title,
      duration: duration ?? this.duration,
      imageUrl: imageUrl ?? this.imageUrl,
      color: color ?? this.color,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'duration': duration,
      'imageUrl': imageUrl,
      'color': color.value,
    };
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      title: map['title'] as String,
      duration: map['duration'] as String,
      imageUrl: map['imageUrl'] as String,
      color: Color(map['color'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Activity.fromJson(String source) =>
      Activity.fromMap(json.decode(source) as Map<String, dynamic>);

}