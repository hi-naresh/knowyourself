import '../../../../utils/constants/enums.dart';

class QuestionModel {
  final String id;
  final String userId;
  final String title;
  final ReminderPeriod reminderPeriod;
  final String answer;
  final bool isAnswered;

  QuestionModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.reminderPeriod,
    this.answer = '',
    this.isAnswered = false,
  });

  QuestionModel copyWith({
    String? id,
    String? userId,
    String? title,
    ReminderPeriod? reminderPeriod,
    String? answer,
    bool? isAnswered,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      reminderPeriod: reminderPeriod ?? this.reminderPeriod,
      answer: answer ?? this.answer,
      isAnswered: isAnswered ?? this.isAnswered,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'title': title,
    'reminderPeriod': reminderPeriod.toString(),
    'answer': answer,
    'isAnswered': isAnswered,
  };

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    id: json['id'],
    userId: json['userId'],
    title: json['title'],
    reminderPeriod: ReminderPeriod.values.firstWhere((e) => e.toString() == json['reminderPeriod']),
    answer: json['answer'] ?? '',
    isAnswered: json['isAnswered'] ?? false,
  );
}
