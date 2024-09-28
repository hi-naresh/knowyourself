import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:knowyourself/utils/constants/enums.dart';

// class QuizModel {
//   final String question;
//   final List<String> options;
//   final int correctAnswerIndex;
//
//   QuizModel({
//     required this.question,
//     required this.options,
//     required this.correctAnswerIndex,
//   });
//
//   QuizModel copyWith({
//     String? question,
//     List<String>? options,
//     int? correctAnswerIndex,
//   }) {
//     return QuizModel(
//       question: question ?? this.question,
//       options: options ?? this.options,
//       correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
//     );
//   }
//
//   factory QuizModel.fromMap(Map<String, dynamic> map) {
//     if (map['correctAnswerIndex'] == null) {
//       throw Exception('Quiz question lacks a correct answer index.');
//     }
//
//     return QuizModel(
//       question: map['question'] ?? '', // Provide default empty string if null
//       options: List<String>.from(map['options'] ?? []), // Provide empty list if null
//       correctAnswerIndex: map['correctAnswerIndex'] is int
//           ? map['correctAnswerIndex']
//           : int.tryParse(map['correctAnswerIndex'].toString()) ?? 0,
//     );
//   }
//
//
//   Map<String, dynamic> toMap() {
//     return {
//       'question': question,
//       'options': options,
//       'correctAnswerIndex': correctAnswerIndex,
//     };
//   }
// }
//

// class ChapterModel {
//   final String id;
//   final String title;
//   final String subTitle;
//   final double progress;
//   final List<String> contentChunks;
//   final String aspect;
//   List<QuizModel>? quizQuestions;
//   final bool completed;
//
//   ChapterModel({
//     required this.id,
//     required this.title,
//     required this.subTitle,
//     required this.progress,
//     required this.contentChunks,
//     required this.aspect,
//     this.quizQuestions,
//     this.completed = false,
//   });
//
//   ChapterModel copyWith({
//     String? id,
//     String? title,
//     String? subTitle,
//     double? progress,
//     List<String>? contentChunks,
//     String? aspect,
//     List<QuizModel>? quizQuestions,
//     bool? completed,
//   }) {
//     return ChapterModel(
//       id: id ?? this.id,
//       title: title ?? this.title,
//       subTitle: subTitle ?? this.subTitle,
//       progress: progress ?? this.progress,
//       contentChunks: contentChunks ?? this.contentChunks,
//       aspect: aspect ?? this.aspect,
//       quizQuestions: quizQuestions ?? this.quizQuestions,
//       completed: completed ?? this.completed,
//     );
//   }
//
//   //fromMap and toMap methods
//   factory ChapterModel.fromMap(Map<String, dynamic> map) {
//     return ChapterModel(
//       id: map['id'],
//       title: map['title'],
//       subTitle: map['subTitle'],
//       progress: map['progress']?.toDouble() ?? 0.0,
//       contentChunks: List<String>.from(map['contentChunks']),
//       // aspect: LifeAspects.values.firstWhere(
//       //       (e) => e.toString() == map['aspect'],
//       //   orElse: () => LifeAspects.mental, // default to mental if not found
//       // ),
//       aspect: map['aspect'] ,
//       quizQuestions: map['quizQuestions'] != null
//           ? List<QuizModel>.from(map['quizQuestions'].map((x) => QuizModel.fromMap(x)))
//           : null,
//       completed: map['completed'] ?? false,
//     );
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'subTitle': subTitle,
//       'progress': progress,
//       'contentChunks': contentChunks,
//       'aspect': aspect,
//       'quizQuestions': quizQuestions?.map((x) => x.toMap()).toList(),
//       'completed': completed,
//     };
//   }
//
//   //fromJson and toJson methods
//   factory ChapterModel.fromJson(String source) => ChapterModel.fromMap(json.decode(source));
//
//   String toJson() => json.encode(toMap());
//
// }



//make chapter model from resource model format
class ChapterModel{
  final String id;
  final String title;
  final String subTitle;
  final double progress;
  final List<String> contentChunks;
  final String aspect;
  final bool completed;

  ChapterModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.progress,
    required this.contentChunks,
    required this.aspect,
    // this.quizQuestions,
    this.completed = false,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json){
    return ChapterModel(
      id: json['id'],
      title: json['title'],
      subTitle: json['subTitle'],
      progress: json['progress']?.toDouble() ?? 0.0,
      contentChunks: List<String>.from(json['contentChunks']),
      aspect: json['aspect'],
      completed: json['completed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'progress': progress,
      'contentChunks': contentChunks,
      'aspect': aspect,
      'completed': completed,
    };
  }

  @override
  String toString() {
    return 'ChapterModel{id: $id, title: $title, subTitle: $subTitle, progress: $progress, contentChunks: $contentChunks, aspect: $aspect, completed: $completed}';
  }

  static List<ChapterModel> fromMap(List<Map<String, dynamic>> chaptersMapList) {
    return chaptersMapList.map((chaptersMap) {
      return ChapterModel.fromJson(chaptersMap);
    }).toList();
  }

  Map<String, dynamic> toMap() {
    return toJson();
  }

  //factory method to create user from json snapshot
  factory ChapterModel.fromDocument(DocumentSnapshot<Map<String,dynamic>> document ) {
    if(document.data() != null){
      final data = document.data()!;
      return ChapterModel(
        id: document.id,
        title: data['title']??'',
        subTitle: data['subTitle']??'',
        progress: data['progress']?.toDouble() ?? 0.0,
        contentChunks: List<String>.from(data['contentChunks']),
        aspect: data['aspect'],
        completed: data['completed'] ?? false,
      );
    }else{
      return ChapterModel.empty();
    }
  }

  static ChapterModel empty() {
    return ChapterModel(
      id: '',
      title: '',
      subTitle: '',
      progress: 0.0,
      contentChunks: [],
      aspect: '',
      completed: false,
    );
  }


}