import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../../features/learning/model/articles/article_model.dart';
import '../../../utils/constants/enums.dart';
class ArticleCacheService {
  final GetStorage _box = GetStorage();
  final String _articlesKey = 'articles';
  final String _timestampKey = 'articles_timestamp';

  void storeArticles(List<Article> articles, LifeAspects aspect) {
    final articlesJson = articles.map((article) => article.toJson()).toList();
    final now = DateTime.now();
    _box.write('${_articlesKey}_${aspect.toString()}', json.encode(articlesJson));
    _box.write('${_timestampKey}_${aspect.toString()}', now.toIso8601String());
  }

  void deleteCache() {
    _box.erase();
  }

  List<Article>? getArticles(LifeAspects aspect) {
    final jsonString = _box.read('${_articlesKey}_${aspect.toString()}');
    final timestampString = _box.read('${_timestampKey}_${aspect.toString()}');

    if (jsonString != null && timestampString != null) {
      DateTime? timestamp;
      try {
        timestamp = DateTime.parse(timestampString);
      } catch (e) {
        print("Error parsing date: $e");
        return null; // Early return if the timestamp can't be parsed.
      }

      final now = DateTime.now();

      // Check if the last fetch was within the same day
      if (timestamp.day == now.day && timestamp.month == now.month && timestamp.year == now.year) {
        List<dynamic> jsonList = json.decode(jsonString);
        print("Cache hit for aspect: $aspect");
        return jsonList.map((jsonArticle) => Article.fromJson(jsonArticle as Map<String, dynamic>, aspect)).toList();
      }
    }
    return null;
  }
}

