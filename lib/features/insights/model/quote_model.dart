
class QuoteModel{
  final String title;
  final String? author;
  final String? tag;

  QuoteModel({required this.title, this.author, this.tag});

  factory QuoteModel.fromJson(Map<String, dynamic> json) {
    return QuoteModel(
      title: json['title'],
      author: json['author'],
      tag: json['tag'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'tag': tag,
    };
  }

  @override
  String toString() {
    return 'QuoteModel{title: $title, author: $author, tag: $tag}';
  }
}