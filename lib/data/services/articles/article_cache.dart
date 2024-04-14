import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import '../../../features/learning/model/article_model.dart';
import '../../../utils/constants/enums.dart';
class ArticleCacheService {
  final GetStorage _box = GetStorage();
  final String _articlesKey = 'articles';

  void storeArticles(List<Article> articles, LifeAspects aspect) {
    final articlesJson = articles.map((article) => article.toJson()).toList();
    _box.write('${_articlesKey}_${aspect.toString()}', json.encode(articlesJson));
  }

  void deleteCache() {
    _box.erase();
  }

  List<Article>? getArticles(LifeAspects aspect) {
    final jsonString = _box.read('${_articlesKey}_${aspect.toString()}');

    if (jsonString != null ) {
      List<dynamic> jsonList = json.decode(jsonString);
      print("Cache hit for aspect: $aspect");
      return jsonList.map((jsonArticle) => Article.fromJson(jsonArticle as Map<String, dynamic>, aspect)).toList();
    }
    return null;
  }
}

