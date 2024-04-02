import 'package:knowyourself/utils/constants/enums.dart';

class CourseModel{
  String id;
  String title;
  String description;
  String imageUrl;
  String url;
  CourseType type;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.type,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json){
    return CourseModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      url: json['url'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'url': url,
      'type': type,
    };
  }

  @override
  String toString() {
    return 'MaterialModel{id: $id, title: $title, description: $description, url: $url, type: $type}';
  }
}