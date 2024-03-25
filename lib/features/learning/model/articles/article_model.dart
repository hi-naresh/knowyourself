import '../../../../utils/constants/enums.dart';

class Article {
  final String title;
  final String description;
  final String content;
  final String url;
  final String publishedAt;
  final String urlToImage;
  final LifeAspects aspect;

  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.publishedAt,
    required this.urlToImage,
    required this.aspect,
  });

  factory Article.fromJson(Map<String, dynamic> json, LifeAspects aspect) {
    return Article(
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      content: json['content'] as String? ?? '',
      url: json['url'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      urlToImage: json['urlToImage'] ?? '',
      aspect: aspect,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'publishedAt': publishedAt,
      'urlToImage': urlToImage,
      'aspect': aspect.index,
    };
  }

  @override
  String toString() {
    return 'Article{title: $title, description: $description, content: $content, url: $url, publishedAt: $publishedAt, urlToImage: $urlToImage, aspect: $aspect}';
  }
}

