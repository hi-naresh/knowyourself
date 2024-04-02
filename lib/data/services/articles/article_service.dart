import 'package:get/get.dart';
import '../../../features/learning/model/article_model.dart';
import '../../../utils/constants/api_constants.dart';
import '../../../utils/constants/enums.dart';

class ArticleApiClient extends GetConnect {

  final fetchRequestTimes = 0.obs;
  Future<List<Article>> fetchArticles(LifeAspects aspect) async {
    try {
      final queryParam = aspect == LifeAspects.all
          ? 'wellness'
          : aspect.toString().split('.').last;
      final url =
          '${ApiConstants.baseUrl}/everything?q=$queryParam&apiKey=${ApiConstants.apiKey}&pageSize=20';
      final response = await get(url).timeout(const Duration(seconds: 30));
      if (response.status.hasError) {
        return Future.error(response.statusText!);
      } else {
        List<dynamic> articlesJson = response.body['articles'];
        fetchRequestTimes.value++;
        return articlesJson
            .map((json) => Article.fromJson(json, aspect))
            .where((article) =>
                article.urlToImage.isNotEmpty &&
                !article.urlToImage.contains('[Removed]'))
            .toList();
      }
    } catch (e) {
      return Future.error('Something went wrong while fetching articles: $e');
    }
  }
}