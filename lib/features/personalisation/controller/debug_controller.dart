import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:knowyourself/features/learning/model/chapter_model.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import '../../../data/repo/materials/resources/remote/resources_online.dart';
import '../../../data/services/quotes/custom_quote.dart';

class DebugController extends GetxController {
  static DebugController get instance => Get.find();

  // final onlineResources = Get.put(OnlineResources()); // final


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  // RxList<ChapterModel> myResources = <ChapterModel>[].obs;

  //load resources from json
  // Future<void> loadResources() async {
  //   final String resourcesJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
  //   final Map<String, dynamic> resourcesJson = json.decode(resourcesJsonString);
  //   final List<dynamic> resourcesJsonList = resourcesJson['chapters'];
  //
  //   final List<ChapterModel> resourcesList = resourcesJsonList
  //       .map((resource) => ChapterModel.fromMap(resource))
  //       .toList();
  //
  //   myResources.assignAll(resourcesList);
  // }

  // CustomQuoteService service = CustomQuoteService();
  var quote = Quote(text: '', author: '').obs;
  // RxBool isLoading = false.obs;
  var errorMessage = ''.obs;

  final CustomQuoteService quoteService = Get.put(CustomQuoteService());

  // QuoteController({required this.quoteService});

  Future<Quote> fetchQuote(String author) async {
    // isLoading.value=true;
    errorMessage('');
    try {
      var fetchedQuote = await quoteService.fetchQuoteByAuthor(author);
      quote.value = fetchedQuote;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      // isLoading(false);
    }
    return quote.value;
  }

  Future<void> onPressed() async {
    // loadResources();
    // await onlineResources.saveResourcesToFirestore(myResources);

    await fetchQuote('Dan Miller');
    print(quote.value.author + " " + quote.value.text);


  }
  
}