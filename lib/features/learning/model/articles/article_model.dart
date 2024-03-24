import '../../../../utils/constants/enums.dart';

class Article {
  final String title;
  final String description;
  final String publishedAt;
  final String imageUrl;
  final LifeAspects aspect;

  Article({
    required this.title,
    required this.description,
    required this.publishedAt,
    required this.imageUrl,
    required this.aspect,
  });

  factory Article.fromJson(Map<String, dynamic> json, LifeAspects aspect) {
    return Article(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      imageUrl: json['urlToImage'] ?? '',
      aspect: aspect,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'publishedAt': publishedAt,
      'urlToImage': imageUrl,
      'aspect': aspect.index,
    };
  }

  @override
  String toString() {
    return 'Article{title: $title, description: $description, publishedAt: $publishedAt, urlToImage: $imageUrl, aspect: $aspect}';
  }
}

