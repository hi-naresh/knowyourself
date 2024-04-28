import 'dart:convert';

class UserChoice {
  String questionText;
  List<String?> answers;
  // String? imagePath;
  String imagePath; // Make sure this field exists


  UserChoice({required this.questionText, this.answers = const [], required this.imagePath });



  UserChoice copyWith({
    String? questionText,
    List<String?>? answers,
    String? imagePath,
  }) {
    return UserChoice(
      questionText: questionText ?? this.questionText,
      answers: answers ?? this.answers,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'answers': answers,
      'imagePath': imagePath,
    };
  }

  factory UserChoice.fromMap(Map<String, dynamic> map) {
    return UserChoice(
      questionText: map['questionText'],
      answers: List<String?>.from(map['answers']),
      imagePath: map['imagePath'] ?? '', // Use empty string if imagePath is not present

      // imagePath: map['imagePath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChoice.fromJson(String source) => UserChoice.fromMap(json.decode(source));

}
