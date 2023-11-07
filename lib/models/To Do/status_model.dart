// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

enum Statustype { todo, celebrate }

class StatusModel {
  String title;
  String image;
  DateTime dateTime;
  bool hasSeen;
  Statustype statustype;
  StatusModel({
    required this.title,
    required this.image,
    required this.dateTime,
    required this.hasSeen,
    required this.statustype,
  });

  StatusModel copyWith({
    String? title,
    String? image,
    DateTime? dateTime,
    bool? hasSeen,
    Statustype? statustype,
  }) {
    return StatusModel(
      title: title ?? this.title,
      image: image ?? this.image,
      dateTime: dateTime ?? this.dateTime,
      hasSeen: hasSeen ?? this.hasSeen,
      statustype: statustype ?? this.statustype,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'hasSeen': hasSeen,
      'statustype': statustype.index,
    };
  }

  factory StatusModel.fromMap(Map<String, dynamic> map) {
    return StatusModel(
      title: map['title'] as String,
      image: map['image'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      hasSeen: map['hasSeen'] as bool,
      statustype: Statustype.values[map["statustype"]],
    );
  }

  String toJson() => json.encode(toMap());

  factory StatusModel.fromJson(String source) =>
      StatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StatusModel(title: $title, image: $image, dateTime: $dateTime, hasSeen: $hasSeen, statustype: $statustype)';
  }

  @override
  bool operator ==(covariant StatusModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.image == image &&
        other.dateTime == dateTime &&
        other.hasSeen == hasSeen &&
        other.statustype == statustype;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        image.hashCode ^
        dateTime.hashCode ^
        hasSeen.hashCode ^
        statustype.hashCode;
  }
}
