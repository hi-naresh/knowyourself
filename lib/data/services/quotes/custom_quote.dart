import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class Quote {
  final String text;
  final String author;

  Quote({required this.text, required this.author});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      text: json['text'],
      author: json['author'],
    );
  }
}

class CustomQuoteService extends GetxService {
  static CustomQuoteService get instance => Get.find();
  Future<Quote> fetchQuoteByAuthor(String author) async {
    // final apiKey = dotenv.env['GOOGLE_API_KEY'];
    final apiKey = "AIzaSyDl6BjeMRfascBvu9z8_4SrZFdGNMaowb0";
    if (apiKey == null) {
      throw Exception('API key is missing. Please set it in .env file.');
    }

    final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
    final prompt = "Generate a quote by $author";
    final content = [Content.text(prompt)];

    try {
      final modelResponse = await model.generateContent(content);
      final response = modelResponse.text;
      if (response!.isNotEmpty) {
        final data = response;
        final quoteJson = {
          'text': data,
          'author': author,
        };

        return Quote.fromJson(quoteJson);
      } else {
        throw Exception('No quote found for the given author.');
      }
    } catch (e) {
      throw Exception('Failed to fetch quote: $e');
    }
  }
}

