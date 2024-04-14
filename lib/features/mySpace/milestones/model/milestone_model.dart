import 'dart:convert';

import '../../../../utils/constants/enums.dart';
class MilestoneModel {
  final String id;
  final String userId;
  final String title;
  final bool status;
  final DateTime createdAt;
  final DateTime dueDate;
  final Period milestonePeriod;
  final String? description;

  MilestoneModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.status,
    required this.createdAt,
    required this.dueDate,
    required this.milestonePeriod,
    this.description,
  });

  MilestoneModel copyWith({
    String? id,
    String? userId,
    String? title,
    bool? status,
    DateTime? createdAt,
    DateTime? dueDate,
    Period? milestonePeriod,
    String? description,
  }) {
    return MilestoneModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      dueDate: dueDate ?? this.dueDate,
      milestonePeriod: milestonePeriod ?? this.milestonePeriod,
      description: description ?? this.description,
    );
  }

  factory MilestoneModel.fromJson(Map<String, dynamic> json) => MilestoneModel(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    status: json['status'],
    createdAt: DateTime.parse(json['createdAt']),
    dueDate: DateTime.parse(json['dueDate']),
    milestonePeriod: Period.values.firstWhere((e) => e.toString() == json['milestonePeriod']),
    description: json['description'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'status': status,
    'createdAt': createdAt.toIso8601String(),
    'dueDate': dueDate.toIso8601String(),
    'milestonePeriod': milestonePeriod.toString(),
    'description': description,
  };

  String toJsonString() => jsonEncode(toJson());

  factory MilestoneModel.fromJsonString(String jsonString) => MilestoneModel.fromJson(jsonDecode(jsonString));

  @override
  String toString() {
    return 'MilestoneModel(id: $id, userId: $userId, title: $title, status: $status, createdAt: $createdAt, dueDate: $dueDate, milestonePeriod: $milestonePeriod, description: $description)';
  }

}
