
class QuoteModel {
  String title;
  String date;
  String? author;
  String? tag;

  QuoteModel({required this.title, required this.date, this.author, this.tag});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      title: json['title'] ?? '',
      date: json['date'] ?? DateTime.now().toString(),
      author: json['author'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date,
      'author': author,
      'tag': tag,
    };
  }
}
