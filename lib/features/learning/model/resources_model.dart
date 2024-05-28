import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knowyourself/utils/constants/enums.dart';

class ResourcesModel{
  String id;
  String title;
  String description;
  String imageUrl;
  String url;
  String type;

  ResourcesModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.url,
    required this.type,
  });

  factory ResourcesModel.fromJson(Map<String, dynamic> json){
    return ResourcesModel(
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
    return 'ResourceModel{id: $id, title: $title, description: $description, url: $url, type: $type}';
  }

  static List<ResourcesModel> fromMap(List<Map<String, dynamic>> resourcesMapList) {
    return resourcesMapList.map((resourcesMap) {
      return ResourcesModel.fromJson(resourcesMap);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  //factory method to create user from json snapshot
  factory ResourcesModel.fromDocument(DocumentSnapshot<Map<String,dynamic>> document ) {
    if(document.data() != null){
      final data = document.data()!;
      return ResourcesModel(
        id: document.id,
        title: data['title']??'',
        description: data['description']??'',
        imageUrl: data['imageUrl']??'',
        url: data['url']??'',
        type: data['type']??'',
      );
    }else{
      return ResourcesModel.empty();
    }
  }

  static ResourcesModel empty() {
    return ResourcesModel(
      id: '',
      title: '',
      description: '',
      imageUrl: '',
      url: '',
      type: '',
    );
  }



}