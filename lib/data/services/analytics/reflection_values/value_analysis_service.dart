import 'dart:convert';
import 'package:flutter/services.dart';

class CoreValuePredictor {
  static const platform = MethodChannel('core_value_prediction');

  static Future<Map<String, dynamic>> predictCoreValues(List<String> entries) async {
    try {
      // Load SVM model and TfidfVectorizer from assets
      final svmModel = await rootBundle.load('assets/svm_model.joblib');
      final vectorizer = await rootBundle.load('assets/vectorizer.joblib');

      // Convert byte data to Uint8List
      final svmModelBytes = svmModel.buffer.asUint8List();
      final vectorizerBytes = vectorizer.buffer.asUint8List();

      // Prepare entries for prediction
      final List<String> preprocessedEntries = entries.map((entry) => preprocessEntry(entry)).toList();

      // Invoke platform-specific code to make predictions
      final dynamic result = await platform.invokeMethod('predictCoreValues', {
        'svmModel': svmModelBytes,
        'vectorizer': vectorizerBytes,
        'entries': preprocessedEntries,
      });

      // Convert result back to Map<String, dynamic>
      return Map<String, dynamic>.from(jsonDecode(result));
    } catch (e) {
      print('Error predicting core values: $e');
      return {};
    }
  }

  static String preprocessEntry(String entry) {
    // Perform preprocessing (tokenization, lowercasing, removing stopwords, etc.)
    // Implement your preprocessing logic here or use a package like nltk (if available for Dart)
    // For simplicity, this example assumes a basic preprocessing
    final tokens = entry.toLowerCase().split(' '); // Example: Lowercasing and splitting by space
    return tokens.join(' '); // Example: Join tokens back to string
  }
}
