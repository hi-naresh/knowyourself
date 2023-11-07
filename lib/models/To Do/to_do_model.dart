// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ToDoModel {
  String title;
  bool isDone;
  ToDoModel({
    required this.title,
    required this.isDone,
  });

  ToDoModel copyWith({
    String? name,
    bool? isDone,
  }) {
    return ToDoModel(
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

  factory ToDoModel.fromMap(Map<String, dynamic> map) {
    return ToDoModel(
      title: map['name'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToDoModel.fromJson(String source) =>
      ToDoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ToDoModel(name: $title, isDone: $isDone)';

  @override
  bool operator ==(covariant ToDoModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.isDone == isDone;
  }

  @override
  int get hashCode => title.hashCode ^ isDone.hashCode;
}
