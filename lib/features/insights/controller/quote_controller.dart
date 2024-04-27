import 'package:get/get.dart';
import '../../../data/services/quotes/quote_service.dart';
import '../model/quote_model.dart';

class QuoteController extends GetxController {
  final _quoteService = QuoteService.instance;
  Rxn<QuoteModel> quoteModel = Rxn<QuoteModel>();
  RxBool showFullQuote = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchQuote();
    quoteModel.listen((quote) {
      if (quote != null) {
        _quoteService.getStoredQuote();
      }
    });
  }

  void fetchQuote() async {
    QuoteModel newQuote = _quoteService.getStoredQuote();
    quoteModel.value = newQuote;
  }
}
