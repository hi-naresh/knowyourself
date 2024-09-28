import 'dart:async';
import 'package:google_generative_ai/google_generative_ai.dart';

class AIModelService {
  static const String _apiKey = "AIzaSyDl6BjeMRfascBvu9z8_4SrZFdGNMaowb0";
  final GenerativeModel _model;

  AIModelService() : _model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: _apiKey);

  Future<String?> generateContent(String systemPrompt, String userPrompt) async {
    final content = [
      Content.text(systemPrompt),
      Content.text(userPrompt),
    ];

    try {
      final modelResponse = await _model.generateContent(content);
      return modelResponse.text;
    } catch (e) {
      print('Error generating content: $e');
      return null;
    }
  }
}
