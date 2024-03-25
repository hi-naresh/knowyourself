
import 'package:get/get.dart';

import '../../../data/services/articles/article_service.dart';
import '../../../data/services/cache_manager/cache_manager.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../model/articles/article_model.dart';

class ArticleController extends GetxController {

  static ArticleController get instance => Get.find();
  final ArticleApiClient apiClient = ArticleApiClient();
  final RxList<Article> articles = <Article>[].obs;
  final Rx<LifeAspects> selectedAspect = LifeAspects.all.obs;
  final CacheManager _cacheManager = CacheManager(); // Create an instance of CacheManager

  @override
  void onInit() {
    super.onInit();
    selectedAspect.listen((_) => fetchAndSetArticles(selectedAspect.value)); // Fetch articles when aspect changes
    fetchAndSetArticles(selectedAspect.value); // Fetch articles initially
  }

  void deleteCache() {
    _cacheManager.deleteCache();
    KHelper.showSnackBar("Cache Deleted", "All cached articles have been deleted.");
  }

  void networkError() {
    KHelper.showSnackBar("Network Error", "Please check your internet connection and try again.");
  }

  void fetchAndSetArticles(LifeAspects aspect) async {
    // get cached articles
    final cachedArticles = _cacheManager.getArticles(aspect);
    if (cachedArticles != null) {
      articles.value = cachedArticles;
      return; // Return early if we have valid cached articles for today
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
        KHelper.showSnackBar("No Articles Found", "We couldn't find articles for the selected aspect.");
      }
    } catch (e) {
      // Handle error
      KHelper.showSnackBar("Error", "Something went wrong while fetching articles: $e");

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
    KHelper.launchUrl( Uri.parse(s));
  }
}