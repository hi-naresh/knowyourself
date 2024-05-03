import 'dart:convert';

import 'package:knowyourself/utils/constants/enums.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int correctAnswerIndex;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });

  QuizQuestion copyWith({
    String? question,
    List<String>? options,
    int? correctAnswerIndex,
  }) {
    return QuizQuestion(
      question: question ?? this.question,
      options: options ?? this.options,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
    );
  }

  factory QuizQuestion.fromMap(Map<String, dynamic> map) {
    if (map['correctAnswerIndex'] == null) {
      throw Exception('Quiz question lacks a correct answer index.');
    }

    return QuizQuestion(
      question: map['question'] ?? '', // Provide default empty string if null
      options: List<String>.from(map['options'] ?? []), // Provide empty list if null
      correctAnswerIndex: map['correctAnswerIndex'] is int
          ? map['correctAnswerIndex']
          : int.tryParse(map['correctAnswerIndex'].toString()) ?? 0,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctAnswerIndex': correctAnswerIndex,
    };
  }
}


class LearningChapters {
  final String id;
  final String title;
  final String subTitle;
  final double progress;
  final List<String> contentChunks;
  final LifeAspects aspect;
  List<QuizQuestion>? quizQuestions;
  final bool completed;

  LearningChapters({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.progress,
    required this.contentChunks,
    required this.aspect,
    this.quizQuestions,
    this.completed = false,
  });

  LearningChapters copyWith({
    String? id,
    String? title,
    String? subTitle,
    double? progress,
    List<String>? contentChunks,
    LifeAspects? aspect,
    List<QuizQuestion>? quizQuestions,
    bool? completed,
  }) {
    return LearningChapters(
      id: id ?? this.id,
      title: title ?? this.title,
      subTitle: subTitle ?? this.subTitle,
      progress: progress ?? this.progress,
      contentChunks: contentChunks ?? this.contentChunks,
      aspect: aspect ?? this.aspect,
      quizQuestions: quizQuestions ?? this.quizQuestions,
      completed: completed ?? this.completed,
    );
  }

  //fromMap and toMap methods
  factory LearningChapters.fromMap(Map<String, dynamic> map) {
    return LearningChapters(
      id: map['id'],
      title: map['title'],
      subTitle: map['subTitle'],
      progress: map['progress']?.toDouble() ?? 0.0,
      contentChunks: List<String>.from(map['contentChunks']),
      aspect: LifeAspects.values.firstWhere(
            (e) => e.toString() == map['aspect'],
        orElse: () => LifeAspects.mental, // default to mental if not found
      ),
      quizQuestions: map['quizQuestions'] != null
          ? List<QuizQuestion>.from(map['quizQuestions'].map((x) => QuizQuestion.fromMap(x)))
          : null,
      completed: map['completed'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'progress': progress,
      'contentChunks': contentChunks,
      'aspect': aspect.toString().split('.').last,
      'quizQuestions': quizQuestions?.map((x) => x.toMap()).toList(),
      'completed': completed,
    };
  }

  //fromJson and toJson methods
  factory LearningChapters.fromJson(String source) => LearningChapters.fromMap(json.decode(source));

  String toJson() => json.encode(toMap());

}