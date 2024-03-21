// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MilestoneModel {
  String title;
  bool isDone;
  MilestoneModel({
    required this.title,
    required this.isDone,
  });

  MilestoneModel copyWith({
    String? name,
    bool? isDone,
  }) {
    return MilestoneModel(
      title: name ?? title,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': title,
      'isDone': isDone,
    };
  }

  factory MilestoneModel.fromMap(Map<String, dynamic> map) {
    return MilestoneModel(
      title: map['name'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MilestoneModel.fromJson(String source) =>
      MilestoneModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ToDoModel(name: $title, isDone: $isDone)';

  @override
  bool operator ==(covariant MilestoneModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode;
}
