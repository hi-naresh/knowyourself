import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';

import '../../../features/insights/model/quote_model.dart';

class QuoteService extends GetxService {

  static QuoteService get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'dailyQuote';

  Future<QuoteModel> fetchDailyQuote() async {
    try {
      var response = await http.get(Uri.parse('https://incarnateword.in/sa/quotes'));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        // The selectors are updated based on the HTML snippet you provided
        var quoteElement = document.querySelector('div.card-content p:first-child');
        var authorElement = document.querySelector('div.card-content p:nth-child(2)');
        var tagElement = document.querySelector('div.card-content p span.badge-self');

        var quote = quoteElement?.text.trim() ?? 'It is only by the touch of the Absolute that we can arrive at our own absolute.';
        var author = authorElement?.text.trim() ?? 'Sri Aurobindo';
        var tag = tagElement?.text.trim()?? 'Absolute';

        print('Quote: $quote');

        // Save to storage
        _storage.write(_storageKey, {
          'title': quote,
          'author': author,
          'tag': tag,
        });

        return QuoteModel(title: quote, author: author, tag: tag);
      } else {
        print('Failed to fetch quote. Status: ${response.statusCode}');
        return QuoteModel(title: 'Failed to fetch quote');
      }
    } catch (e) {
      print(e);
      return QuoteModel(title: 'Error occurred while fetching quote');
    }
  }

  QuoteModel getStoredQuote() {
    var storedQuoteJson = _storage.read(_storageKey);
    if (storedQuoteJson != null) {
      return QuoteModel.fromJson(storedQuoteJson);
    } else {
      return QuoteModel(title: 'No stored quote');
    }
  }

  Future<void> updateQuote() async {
    // Here you can add logic to check if the stored quote is from today
    // If it's not, fetch a new quote
    if (shouldFetchNewQuote()) {
      await fetchDailyQuote();
    }
  }

  bool shouldFetchNewQuote() {
    // Implement logic to decide if we should fetch a new quote
    // For example, check the date stored in GetStorage and compare with current date
    // Assuming we store the date like this: _storage.write('quoteDate', DateTime.now().toIso8601String());
    var storedDate = _storage.read('quoteDate');
    if (storedDate != null) {
      var date = DateTime.parse(storedDate);
      return date.day != DateTime.now().day;
    }
    return true; // If no date is stored, return true
  }
}
