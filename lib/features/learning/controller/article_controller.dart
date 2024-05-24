
import 'package:get/get.dart';

import '../../../data/services/articles/article_service.dart';
import '../../../data/services/articles/article_cache.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/text_strings.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/article_model.dart';

class ArticleController extends GetxController {

  static ArticleController get instance => Get.find();
  final ArticleApiClient apiClient = ArticleApiClient();
  final RxList<Article> articles = <Article>[].obs;
  final Rx<LifeAspects> selectedAspect = LifeAspects.all.obs;
  final ArticleCacheService _cacheManager = ArticleCacheService(); // Create an instance of CacheManager

  @override
  void onInit() {
    super.onInit();
    selectedAspect.listen((_) => fetchAndSetArticles(selectedAspect.value)); // Fetch articles when aspect changes
    fetchAndSetArticles(selectedAspect.value); // Fetch articles initially
  }

  void deleteCache() {
    _cacheManager.deleteCache();
    KHelper.showSnackBar(KTexts.cacheDeletedSnackBarTitle, KTexts.deleteCacheSnackBarMessage);
  }

  void fetchAndSetArticles(LifeAspects aspect) async {
    // get cached articles
    final List<Article>? cachedArticles = _cacheManager.getArticles(aspect);
    if (cachedArticles != null) {
      articles.value = cachedArticles;
      return;
    }

    // If no valid cache for today, fetch from the API
    try {
      final fetchedArticles = await apiClient.fetchArticles(aspect);
      if (fetchedArticles.isNotEmpty) {
        articles.value = fetchedArticles;
        //fetch request times
        print("fetch request times ${apiClient.fetchRequestTimes}");
        _cacheManager.storeArticles(fetchedArticles, aspect); // Cache the fetched articles
      } else {
        // Handle empty response
        KHelper.showSnackBar(KTexts.noArticlesFoundSnackBarTitle, KTexts.noArticlesFoundSnackBarMessage);
      }
    } catch (e) {
      // Handle error
      KHelper.showSnackBar(KTexts.error, "${KTexts.fetchArticlesError} $e");
    }
  }

  void changeAspect(LifeAspects aspect) {
    selectedAspect.value = aspect;
    fetchAndSetArticles(aspect);
  }

  List<Article> get filteredArticles {
    if (selectedAspect.value == LifeAspects.all) {
      return articles.toList();
    } else {
      return articles.where((article) => article.aspect == selectedAspect.value).toList();
    }
  }

  openArticle(String s) {
    //convert string into uri
    KHelper.launchUrl( s);
  }
}