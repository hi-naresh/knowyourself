// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuoteModel {
  String title;
  String image;
  QuoteModel({
    required this.title,
    required this.image,
  });

  QuoteModel copyWith({
    String? title,
    String? image,
  }) {
    return QuoteModel(
      title: title ?? this.title,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'image': image,
    };
  }

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      title: map['title'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuoteModel.fromJson(String source) =>
      QuoteModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'QuoteModel(title: $title, image: $image)';

  @override
  bool operator ==(covariant QuoteModel other) {
    if (identical(this, other)) return true;

    return other.title == title && other.image == image;
  }

  @override
  int get hashCode => title.hashCode ^ image.hashCode;
}
