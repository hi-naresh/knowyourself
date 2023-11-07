// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class JournalModel {
  int journalId;
  DateTime createdOn;
  String mood;
  String title;
  Color color;
  String description;

  JournalModel({
    required this.journalId,
    required this.createdOn,
    required this.mood,
    required this.title,
    required this.color,
    required this.description,
  });

  JournalModel copyWith({
    int? journalId,
    DateTime? createdOn,
    String? mood,
    String? title,
    Color? color,
    String? description,
  }) {
    return JournalModel(
      journalId: journalId ?? this.journalId,
      createdOn: createdOn ?? this.createdOn,
      mood: mood ?? this.mood,
      title: title ?? this.title,
      color: color ?? this.color,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'journalId': journalId,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'mood': mood,
      'title': title,
      'color': color.value,
      'description': description,
    };
  }

  factory JournalModel.fromMap(Map<String, dynamic> map) {
    return JournalModel(
      journalId: map['journalId'] as int,
      createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int),
      mood: map['mood'] as String,
      title: map['title'] as String,
      color: Color(map['color'] as int),
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JournalModel.fromJson(String source) =>
      JournalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JournalModel(journalId: $journalId, createdOn: $createdOn, mood: $mood, title: $title, color: $color, description: $description)';
  }

  @override
  bool operator ==(covariant JournalModel other) {
    if (identical(this, other)) return true;

    return other.journalId == journalId &&
        other.createdOn == createdOn &&
        other.mood == mood &&
        other.title == title &&
        other.color == color &&
        other.description == description;
  }

  @override
  int get hashCode {
    return journalId.hashCode ^
        createdOn.hashCode ^
        mood.hashCode ^
        title.hashCode ^
        color.hashCode ^
        description.hashCode;
  }
}
