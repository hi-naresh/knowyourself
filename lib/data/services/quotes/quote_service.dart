import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:knowyourself/utils/theme/widget_themes/text_theme.dart';

import '../../../features/insights/model/quote_model.dart';

class QuoteService extends GetxService {
  static QuoteService get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'dailyQuote';

  @override
  void onInit() {
    super.onInit();
    ensureQuoteForToday();
  }

  Future<void> ensureQuoteForToday() async {
    if (shouldFetchNewQuote()) {
      await fetchDailyQuote();
    }
  }

  // Future<QuoteModel> fetchDailyQuote() async {
  //   try {
  //     var response = await http.get(Uri.parse('https://www.goodreads.com/author/quotes/5867530.Sri_Aurobindo'));
  //     if (response.statusCode == 200) {
  //       var document = parse(response.body);
  //       var content = document.querySelector('.quote');
  //       if (content != null) {
  //         var quoteElement = content.querySelector('.quoteText');
  //         var authorElement = content.querySelector('.authorOrTitle');
  //
  //         var quoteText = quoteElement?.text.split('“').last.split('”').first.trim();
  //         var authorText = authorElement?.text.trim();
  //
  //         if (quoteText != null && authorText != null) {
  //           var today = DateTime.now();
  //           _storage.write(_storageKey, {
  //             'title': quoteText,
  //             'author': authorText,
  //             'date': DateFormat('yyyy-MM-dd').format(today),
  //           });
  //
  //           return QuoteModel(title: quoteText, author: authorText, date: today.toString());
  //         }
  //       }
  //     }
  //     throw Exception('Failed to fetch quote');
  //   } catch (e) {
  //     KHelper.showSnackBar('Failed to fetch quote', 'Please check your internet connection');
  //     // Return a default quote or handle the error as needed
  //     return QuoteModel(
  //         title: 'It is only by the touch of the Absolute that we can arrive at our own absolute.',
  //         author: 'Sri Aurobindo',
  //         date: DateTime.now().toString(),
  //     );
  //   }
  // }

  Future<QuoteModel> fetchDailyQuote() async {
    try {
      var response = await http.get(Uri.parse('https://aurosociety.org/society/index/Questions-And-Answers'));
      if (response.statusCode == 200) {
        var document = parse(response.body);
        var content = document.querySelector('.plan.orange');
        if (content != null) {
          var quoteElement = content.querySelector('p');
          var authorElement = content.querySelector('p:nth-child(2)');

          var quoteText = quoteElement?.text.split('“').last.split('”').first.trim();
          var authorText = authorElement?.text.trim();

          if (quoteText != null && authorText != null) {
            var today = DateTime.now();
            _storage.write(_storageKey, {
              'title': quoteText,
              'author': authorText,
              'date': DateFormat('yyyy-MM-dd').format(today),
            });

            return QuoteModel(title: quoteText, author: authorText, date: today.toString());
          }

        }
      }
      throw Exception(KTexts.fetchQuoteError);
    } catch (e) {
      // Return a default quote or handle the error as needed
      KHelper.showSnackBar(KTexts.fetchQuoteError, KTexts.snackBarMessage);
      return QuoteModel(
        title: 'It is only by the touch of the Absolute that we can arrive at our own absolute.',
        author: 'Sri Aurobindo',
        date: DateTime.now().toString(),
      );
    }
  }


  QuoteModel getStoredQuote() {
    var storedQuoteJson = _storage.read(_storageKey);
    if (storedQuoteJson != null) {
      return QuoteModel.fromJson(storedQuoteJson);
    }
    return QuoteModel(title: '', author: '', date: '');
  }

  bool shouldFetchNewQuote() {
    var storedQuoteJson = _storage.read(_storageKey);
    if (storedQuoteJson != null) {
      var storedDate = DateFormat('yyyy-MM-dd').parse(storedQuoteJson['date']);
      var today = DateTime.now();
      if (storedDate.day == today.day &&
          storedDate.month == today.month &&
          storedDate.year == today.year) {
        return false;
      }
    }
    return true;
  }
}
