import 'package:get/get.dart';
import '../../../data/services/quotes/quote_service.dart';
import '../model/quote_model.dart';

class QuoteController extends GetxController {
  final _quoteService = QuoteService.instance;
  Rxn<QuoteModel> quoteModel = Rxn<QuoteModel>();

  @override
  void onInit() {
    super.onInit();
    // Attempt to load the stored quote when the controller initializes
    fetchQuote();
    // QuoteModel storedQuote = _quoteService.getStoredQuote();
    // if (storedQuote.title.isNotEmpty) {
    //   quoteModel.value = storedQuote;
    // } else {
    //   // If there's no stored quote, fetch a new one
    //   fetchQuote();
    // }
  }

  void fetchQuote() async {
    QuoteModel newQuote = await _quoteService.fetchDailyQuote();
    quoteModel.value = newQuote;
  }
}
