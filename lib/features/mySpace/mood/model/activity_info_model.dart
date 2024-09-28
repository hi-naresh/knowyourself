// import 'dart:ui';
//
// class ActivityModel {
//   String id;
//   String? userId;
//   String title;
//   List<String>? instructions;
//   String? link;
//   String? duration;
//   String? imageUrl;
//   Color? color;
//   String? tag;
//
//   ActivityModel({
//     required this.id,
//     this.userId,
//     required this.title,
//     this.instructions,
//     this.link,
//     this.duration,
//     this.imageUrl,
//     this.color,
//     this.tag,
//   });
//
//   factory ActivityModel.fromJson(Map<String, dynamic> json) {
//     // Parsing the 'color' field to a Color object
//     Color? parsedColor;
//     if (json['color'] != null) {
//       String colorStr = json['color'];
//       if (colorStr.startsWith('#')) {
//         parsedColor = Color(int.parse('0xFF' + colorStr.substring(1)));
//       }
//     }
//
//     return ActivityModel(
//       id: json['id'] as String,
//       userId: json['userId'] as String?,
//       title: json['title'] as String,
//       instructions: (json['instructions'] as List<dynamic>?)?.map((e) => e as String).toList(),
//       link: json['link'] as String?,
//       duration: json['duration'] as String?,
//       imageUrl: json['imageUrl'] as String?,
//       color: parsedColor,
//       tag: json['tag'] as String?,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'userId': userId ?? '',
//       'title': title,
//       'instructions': instructions ?? [],
//       'link': link ?? '',
//       'duration': duration ?? '',
//       'imageUrl': imageUrl ?? '',
//       'color': color != null ? '#${color!.value.toRadixString(16).substring(2)}' : '',
//       'tag': tag ?? '',
//     };
//   }
//
//   @override
//   String toString() {
//     return 'ActivityModel{id: $id, title: $title}';
//   }
//
//   static List<ActivityModel> fromMap(List<Map<String, dynamic>> entryMapList) {
//     return entryMapList.map((entryMap) {
//       return ActivityModel.fromJson(entryMap);
//     }).toList();
//   }
//
//   Map<String, dynamic> toMap() {
//     return toJson();
//   }
// }
//

import 'dart:ui';

class ActivityModel {
  String id;
  String? userId;
  String title;
  List<String>? instructions;
  String? link;
  String? duration;
  String? imageUrl;
  Color? color;
  String? tag;

  ActivityModel({
    required this.id,
    this.userId,
    required this.title,
    this.instructions,
    this.link,
    this.duration,
    this.imageUrl,
    this.color,
    this.tag,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    // Parsing the 'color' field to a Color object
    Color? parsedColor;
    if (json['color'] != null) {
      String colorStr = json['color'];
      if (colorStr.startsWith('#')) {
        parsedColor = Color(int.parse('0xFF' + colorStr.substring(1)));
      }
    }

    return ActivityModel(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      title: json['title'] as String,
      instructions: (json['instructions'] as List<dynamic>?)?.map((e) => e as String).toList(),
      link: json['link'] as String?,
      duration: json['duration'] as String?,
      imageUrl: json['imageUrl'] as String?,
      color: parsedColor,
      tag: json['tag'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'instructions': instructions,
      'link': link,
      'duration': duration,
      'imageUrl': imageUrl,
      'color': color != null ? '#${color!.value.toRadixString(16).substring(2)}' : null,
      'tag': tag,
    };
  }

  @override
  String toString() {
    return 'ActivityModel{id: $id, title: $title}';
  }

  static List<ActivityModel> fromMap(List<Map<String, dynamic>> entryMapList) {
    return entryMapList.map((entryMap) {
      return ActivityModel.fromJson(entryMap);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  static ActivityModel empty() {
    return ActivityModel(
      id: '',
      title: '',
    );
  }
}
