// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GratitudeModel {
  String title;
  GratitudeModel({
    required this.title,
  });

  GratitudeModel copyWith({
    String? title,
  }) {
    return GratitudeModel(
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory GratitudeModel.fromMap(Map<String, dynamic> map) {
    return GratitudeModel(
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GratitudeModel.fromJson(String source) =>
      GratitudeModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CelebrationModel(title: $title)';

  @override
  bool operator ==(covariant GratitudeModel other) {
    if (identical(this, other)) return true;

    return other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
