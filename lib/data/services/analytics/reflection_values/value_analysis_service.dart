// import 'package:get/get.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
//
// class JournalEntryAnalysisService extends GetxService {
//   static JournalEntryAnalysisService get instance => Get.find();
//   final String _apiKey = "AIzaSyDl6BjeMRfascBvu9z8_4SrZFdGNMaowb0";
//
//   final Map<String, String> prompts = {
//     "Sincerity": "As a Science of Living philosopher, rate this journal entry for sincerity or honesty on a scale from 0 to 100.",
//     "Humility": "As a Science of Living philosopher, rate this journal entry for humility or modesty on a scale from 0 to 100.",
//     "Gratitude": "As a Science of Living philosopher, rate this journal entry for gratitude or thankfulness on a scale from 0 to 100.",
//     "Perseverance": "As a Science of Living philosopher, rate this journal entry for perseverance or determination on a scale from 0 to 100.",
//     "Aspiration": "As a Science of Living philosopher, rate this journal entry for aspiration or ambition on a scale from 0 to 100.",
//     "Receptivity": "As a Science of Living philosopher, rate this journal entry for receptivity or openness to new ideas on a scale from 0 to 100.",
//     "Progress": "As a Science of Living philosopher, rate this journal entry for progress or improvement on a scale from 0 to 100.",
//     "Courage": "As a Science of Living philosopher, rate this journal entry for courage or bravery on a scale from 0 to 100.",
//     "Goodness": "As a Science of Living philosopher, rate this journal entry for goodness or moral integrity on a scale from 0 to 100.",
//     "Generosity": "As a Science of Living philosopher, rate this journal entry for generosity or selflessness on a scale from 0 to 100.",
//     "Equanimity": "As a Science of Living philosopher, rate this journal entry for equanimity or calmness in difficult situations on a scale from 0 to 100.",
//     "Peace": "As a Science of Living philosopher, rate this journal entry for peace or tranquility on a scale from 0 to 100."
//   };
//
//   Future<Map<String, double>> analyzeJournalEntry(String journalEntry) async {
//     if (_apiKey.isEmpty) {
//       throw Exception('API key is missing. Please set it in .env file.');
//     }
//
//     final model = GenerativeModel(model: "gemini-pro", apiKey: _apiKey);
//
//     final Map<String, double> scores = {};
//
//     if (journalEntry.trim().isEmpty || journalEntry.trim().toLowerCase() == "i did nothing today") {
//       // Return 0.0 for all core values if the entry is empty or irrelevant
//       prompts.keys.forEach((key) {
//         scores[key] = 0.0;
//       });
//       return scores;
//     }
//
//     for (var label in prompts.keys) {
//       final prompt = "${prompts[label]} Here is the journal entry: \"$journalEntry\". Provide only a numerical score between 0 and 100.";
//       final content = [Content.text(prompt)];
//
//       try {
//         final modelResponse = await model.generateContent(content);
//         final response = modelResponse.text;
//
//         // Log the raw response for debugging
//         print('Gemini Model Response for $label: $response');
//
//         final score = _extractScore(response!);
//         scores[label] = score;
//       } catch (e) {
//         print('Failed to analyze for $label: $e');
//         scores[label] = 0.0;
//       }
//     }
//
//     return scores;
//   }
//
//   double _extractScore(String response) {
//     // Implement logic to extract a score from the response
//     // We expect a number between 0 and 100 in the response text
//     try {
//       // This is a placeholder for extracting the score.
//       // You'll need to parse the response text to extract the numeric score.
//       final regex = RegExp(r'(\d{1,3}(\.\d{1,2})?)');
//       final match = regex.firstMatch(response);
//       if (match != null) {
//         double score = double.parse(match.group(0)!);
//         // Ensure the score is within the 0-100 range
//         if (score >= 0 && score <= 100) {
//           return score;
//         }
//       }
//     } catch (e) {
//       print('Failed to extract score: $e');
//     }
//     return 0.0;
//   }
// }

// import 'package:get/get.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
//
// class JournalEntryAnalysisService extends GetxService {
//   static JournalEntryAnalysisService get instance => Get.find();
//   final String _apiKey = "AIzaSyDl6BjeMRfascBvu9z8_4SrZFdGNMaowb0";
//
//   final Map<String, String> prompts = {
//     "Sincerity": "Please rate this journal entry for sincerity or honesty on a scale from 0 to 100.",
//     "Humility": "Please rate this journal entry for humility or modesty on a scale from 0 to 100.",
//     "Gratitude": "Please rate this journal entry for gratitude or thankfulness on a scale from 0 to 100.",
//     "Perseverance": "Please rate this journal entry for perseverance or determination on a scale from 0 to 100.",
//     "Aspiration": "Please rate this journal entry for aspiration or ambition on a scale from 0 to 100.",
//     "Receptivity": "Please rate this journal entry for receptivity or openness to new ideas on a scale from 0 to 100.",
//     "Progress": "Please rate this journal entry for progress or improvement on a scale from 0 to 100.",
//     "Courage": "Please rate this journal entry for courage or bravery on a scale from 0 to 100.",
//     "Goodness": "Please rate this journal entry for goodness or moral integrity on a scale from 0 to 100.",
//     "Generosity": "Please rate this journal entry for generosity or selflessness on a scale from 0 to 100.",
//     "Equanimity": "Please rate this journal entry for equanimity or calmness in difficult situations on a scale from 0 to 100.",
//     "Peace": "Please rate this journal entry for peace or tranquility on a scale from 0 to 100."
//   };
//
//   Future<Map<String, double>> analyzeJournalEntry(String journalEntry) async {
//     if (_apiKey.isEmpty) {
//       throw Exception('API key is missing. Please set it in .env file.');
//     }
//
//     // If the journal entry is trivial or empty, return zeros
//     if (_isLowContentEntry(journalEntry)) {
//       return _zeroScores();
//     }
//
//     final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: _apiKey);
//
//     final Map<String, double> scores = {};
//
//     for (var label in prompts.keys) {
//       final prompt = _constructPrompt(prompts[label]!, journalEntry);
//       final content = [Content.text(prompt)];
//
//       try {
//         final modelResponse = await model.generateContent(content);
//         final response = modelResponse.text;
//
//         // Log the raw response for debugging
//         print('Gemini Model Response for $label: $response');
//
//         final score = _extractScore(response!);
//         scores[label] = score;
//       } catch (e) {
//         if (e.toString().contains("Resource has been exhausted")) {
//           print('Quota exhausted for $label: $e');
//           scores[label] = 0.0;
//         } else {
//           print('Failed to analyze for $label: $e');
//           scores[label] = 0.0;
//         }
//       }
//     }
//
//     return scores;
//   }
//
//   bool _isLowContentEntry(String entry) {
//     final trimmedEntry = entry.trim().toLowerCase();
//     return trimmedEntry.isEmpty || trimmedEntry == "i did nothing today" || trimmedEntry == "today i did nothing.";
//   }
//
//   Map<String, double> _zeroScores() {
//     return {
//       for (var label in prompts.keys) label: 0.0,
//     };
//   }
//
//   String _constructPrompt(String basePrompt, String journalEntry) {
//     return '''
//       You are a Science of Living professor. Analyze the following journal entry and provide a score from 0 to 100 for the specific attribute.
//       The journal entry is: "$journalEntry"
//       $basePrompt
//       Provide only a numerical score as the response.
//     ''';
//   }
//
//   double _extractScore(String response) {
//     try {
//       final regex = RegExp(r'(\d{1,3}(\.\d{1,2})?)');
//       final match = regex.firstMatch(response);
//       if (match != null) {
//         double score = double.parse(match.group(0)!);
//         if (score >= 0 && score <= 100) {
//           return score;
//         }
//       }
//     } catch (e) {
//       print('Failed to extract score: $e');
//     }
//     return 0.0;
//   }
// }


import 'package:get/get.dart';

import '../../../../bindings/ai_model_binding.dart';
import '../../../../utils/helpers/prompt_provider.dart';

class JournalEntryAnalysisService extends GetxService {
  static JournalEntryAnalysisService get instance => Get.find();
  final AIModelService _aiModelService;

  JournalEntryAnalysisService() : _aiModelService = AIModelService();

  final List<String> attributes = [
    "Sincerity",
    "Humility",
    "Gratitude",
    "Perseverance",
    "Aspiration",
    "Receptivity",
    "Progress",
    "Courage",
    "Goodness",
    "Generosity",
    "Equanimity",
    "Peace"
  ];

  Future<Map<String, double>> analyzeJournalEntry(String journalEntry) async {
    if (_isLowContentEntry(journalEntry)) {
      return _zeroScores();
    }

    final Map<String, double> scores = {};

    for (var attribute in attributes) {
      final prompt = PromptProvider.generateJournalEntryAnalysisPrompt(
        attribute: attribute,
        journalEntry: journalEntry,
      );

      try {
        final response = await _aiModelService.generateContent('', prompt);

        if (response != null) {
          final score = _extractScore(response);
          scores[attribute] = score;
        } else {
          throw Exception('Failed to generate content for $attribute.');
        }
      } catch (e) {
        print('Error analyzing $attribute: $e');
        scores[attribute] = 0.0; // Default to 0.0 in case of failure
      }
    }

    return scores;
  }

  bool _isLowContentEntry(String entry) {
    final trimmedEntry = entry.trim().toLowerCase();
    return trimmedEntry.isEmpty ||
        trimmedEntry == "i did nothing today" ||
        trimmedEntry == "today i did nothing.";
  }

  Map<String, double> _zeroScores() {
    return {for (var attribute in attributes) attribute: 0.0};
  }

  double _extractScore(String response) {
    try {
      final regex = RegExp(r'(\d{1,3}(\.\d{1,2})?)');
      final match = regex.firstMatch(response);
      if (match != null) {
        double score = double.parse(match.group(0)!);
        if (score >= 0 && score <= 100) {
          return score;
        }
      }
    } catch (e) {
      print('Failed to extract score: $e');
    }
    return 0.0; // Default score if extraction fails
  }
}


// class JournalEntryAnalysisService extends GetxService {
//   static JournalEntryAnalysisService get instance => Get.find();
//   final String _apiKey = "AIzaSyDl6BjeMRfascBvu9z8_4SrZFdGNMaowb0";
//
//   final Map<String, String> prompts = {
//     "Sincerity": "Please rate this journal entry for sincerity or honesty on a scale from 0 to 100.",
//     "Humility": "Please rate this journal entry for humility or modesty on a scale from 0 to 100.",
//     "Gratitude": "Please rate this journal entry for gratitude or thankfulness on a scale from 0 to 100.",
//     "Perseverance": "Please rate this journal entry for perseverance or determination on a scale from 0 to 100.",
//     "Aspiration": "Please rate this journal entry for aspiration or ambition on a scale from 0 to 100.",
//     "Receptivity": "Please rate this journal entry for receptivity or openness to new ideas on a scale from 0 to 100.",
//     "Progress": "Please rate this journal entry for progress or improvement on a scale from 0 to 100.",
//     "Courage": "Please rate this journal entry for courage or bravery on a scale from 0 to 100.",
//     "Goodness": "Please rate this journal entry for goodness or moral integrity on a scale from 0 to 100.",
//     "Generosity": "Please rate this journal entry for generosity or selflessness on a scale from 0 to 100.",
//     "Equanimity": "Please rate this journal entry for equanimity or calmness in difficult situations on a scale from 0 to 100.",
//     "Peace": "Please rate this journal entry for peace or tranquility on a scale from 0 to 100."
//   };
//
//   Future<Map<String, double>> analyzeJournalEntry(String journalEntry) async {
//     if (_apiKey.isEmpty) {
//       throw Exception('API key is missing. Please set it in .env file.');
//     }
//
//     // If the journal entry is trivial or empty, return zeros
//     if (_isLowContentEntry(journalEntry)) {
//       return _zeroScores();
//     }
//
//     final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: _apiKey);
//     final Map<String, double> scores = {};
//
//     for (var label in prompts.keys) {
//       final prompt = _constructPrompt(prompts[label]!, journalEntry);
//       final content = [Content.text(prompt)];
//
//       try {
//         final modelResponse = await model.generateContent(content);
//         final response = modelResponse.text;
//
//         // Log the raw response for debugging
//         print('Gemini Model Response for $label: $response');
//
//         final score = _extractScore(response!);
//         scores[label] = score;
//       } catch (e) {
//         if (e.toString().contains("Resource has been exhausted")) {
//           print('Quota exhausted for $label: $e');
//           scores[label] = 0.0;
//         } else {
//           print('Failed to analyze for $label: $e');
//           scores[label] = 0.0;
//         }
//       }
//     }
//
//     return scores;
//   }
//
//   bool _isLowContentEntry(String entry) {
//     final trimmedEntry = entry.trim().toLowerCase();
//     return trimmedEntry.isEmpty || trimmedEntry == "i did nothing today" || trimmedEntry == "today i did nothing.";
//   }
//
//   Map<String, double> _zeroScores() {
//     return {
//       for (var label in prompts.keys) label: 0.0,
//     };
//   }
//
//   String _constructPrompt(String basePrompt, String journalEntry) {
//     return '''
//       You are a Science of Living professor. Analyze the following journal entry and provide a score from 0 to 100 for the specific attribute.
//       The journal entry is: "$journalEntry"
//       $basePrompt
//       Provide only a numerical score as the response.
//     ''';
//   }
//
//   double _extractScore(String response) {
//     try {
//       final regex = RegExp(r'(\d{1,3}(\.\d{1,2})?)');
//       final match = regex.firstMatch(response);
//       if (match != null) {
//         double score = double.parse(match.group(0)!);
//         if (score >= 0 && score <= 100) {
//           return score;
//         }
//       }
//     } catch (e) {
//       print('Failed to extract score: $e');
//     }
//     return 0.0;
//   }
// }

