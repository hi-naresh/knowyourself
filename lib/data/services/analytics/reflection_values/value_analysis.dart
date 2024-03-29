
import '../../../../utils/constants/enums.dart';

class ValueAnalysis {
  Map<CoreValues, int> valueOccurrences = CoreValues.values.asMap().map((_, value) => MapEntry(value, 0));

  Map performAnalysis(String content) {
    final tokens = tokenizeContent(content);
    final percentage = analyzeValues(tokens);
    return percentage;
  }

  List<String> tokenizeContent(String content) {
    // Convert content to lowercase and remove punctuation
    String processedContent = content.toLowerCase().replaceAll(RegExp(r'[^\w\s]'), '');
    // Split content into words
    List<String> tokens = processedContent.split(' ');
    // Remove empty strings that might result from split
    tokens.removeWhere((token) => token.isEmpty);
    return tokens;
  }

  Map analyzeValues(tokens) {
    for (var word in tokens) {
      for (var value in CoreValues.values) {
        if (coreValueKeywords[value]!.contains(word)) {
          valueOccurrences[value] = valueOccurrences[value]! + 1;
        }
      }
    }
    int totalOccurrences = valueOccurrences.values.reduce((a, b) => a + b);
    Map<CoreValues, double> valuePercentages = valueOccurrences.map((value, count) =>
        MapEntry(value, (count / totalOccurrences) * 100));
    return valuePercentages;
  }

}

void main(){
  String textToAnalyze = '''When it comes to books, I didn’t understand the appeal. I’d read one after another for each assignment not understanding what all the fuss was about. However, the moment I read Pride and Prejudice, it was like my literary eyes opened for the first time. It stirred love within me for classics I didn’t realize could exist.
When I was first given the assignment of reading Pride and Prejudice, like many of my friends, I scoffed. With an eye roll, I internally calculated how much time I would have to read the book and write a report. I sighed at the loss of time with my friends for a stupid classic.''';
  ValueAnalysis analysis = ValueAnalysis();
  final result = analysis.performAnalysis(textToAnalyze);
  print(result);

}
