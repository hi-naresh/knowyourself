// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CelebrationModel {
  String title;
  CelebrationModel({
    required this.title,
  });

  CelebrationModel copyWith({
    String? title,
  }) {
    return CelebrationModel(
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory CelebrationModel.fromMap(Map<String, dynamic> map) {
    return CelebrationModel(
      title: map['title'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CelebrationModel.fromJson(String source) =>
      CelebrationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CelebrationModel(title: $title)';

  @override
  bool operator ==(covariant CelebrationModel other) {
    if (identical(this, other)) return true;

    return other.title == title;
  }

  @override
  int get hashCode => title.hashCode;
}
