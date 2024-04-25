
import 'dart:ui';

class ActivityModel {
  late String id;
  late String userId;
  late String title;
  final String? instructions;
  final String? link;
  final String? duration;
  final String? imageUrl;
  final Color? color ;

  ActivityModel({
    required this.id,
    required this.userId,
    required this.title,
    this.instructions,
    this.link,
    this.duration,
    this.imageUrl,
    this.color
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      id: json['id'] ?? '',
      userId: json['userId']??'',
      title: json['title']??'',
      instructions: json['instructions']??'',
      link: json['link']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title':title,
      'instructions':instructions,
      'link':link
    };
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, userId: $userId';
  }

  static List<ActivityModel> fromMap(List<Map<String, dynamic>> entryMapList) {
    return entryMapList.map((entryMap) {
      return ActivityModel.fromJson(entryMap);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }
}
