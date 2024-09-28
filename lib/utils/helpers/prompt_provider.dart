class PromptProvider {
  // Common system prompt for generating activities
  static const String _activityRecommendationSystemPrompt = '''
You are an expert therapist and life coach with extensive knowledge in psychology, neuroscience, and holistic well-being. Your task is to suggest powerful, tailored activities to shift a user's mood positively. Each suggestion should be evidence-based, realistic, and highly effective.

Provide the response in JSON format with the following keys:
- title: [Short and appealing title]
- instructions: [Step-by-step instructions in short sentences]
- link: [Relevant, reputable web resource or "none" if not applicable]
- duration: [Estimated time]
- tag: [One-word category: Relaxation, Exercise, Mindfulness, Creativity, etc.]

Strictly follow the JSON format and guidelines provided to avoid any parsing error.
Ensure each response is clear, concise, and directly addresses the user's state.
''';

  // Generate system prompt based on the scenario
  static String getSystemPrompt(PromptScenario scenario) {
    switch (scenario) {
      case PromptScenario.activityRecommendation:
        return _activityRecommendationSystemPrompt;
      case PromptScenario.valueAnalysis:
        return _valueAnalysisSystemPrompt;
      case PromptScenario.customAuthorQuote:
        return _customAuthorQuoteSystemPrompt;
    // Add more cases as new scenarios are added
      default:
        throw Exception('Unsupported scenario');
    }
  }

  // Generate user prompt for activity recommendation
  static String generateActivityRecommendationUserPrompt({
    required String aspect,
    required String mood,
    required String reason,
    required String place,
    required String activityType,
  }) {
    return '''
{
  "aspect": "$aspect",
  "mood": "$mood",
  "reason": "$reason",
  "place": "$place",
  "activity_type": "$activityType"
}
''';
  }

  static String generateJournalEntryAnalysisPrompt({
    required String attribute,
    required String journalEntry,
  }) {
    return '''
      You are a Science of Living professor. Analyze the following journal entry and provide a score from 0 to 100 for the specific attribute.
      The journal entry is: "$journalEntry"
      Please rate this journal entry for $attribute on a scale from 0 to 100.
      Provide only a numerical score as the response.
    ''';
  }

  static const String _customAuthorQuoteSystemPrompt = '''
You are an expert in literature with extensive knowledge of various authors. Your task is to generate a custom quote that an author might say about a specific topic.

Provide the response in JSON format with the following keys:
- quote: [A custom quote in the style of the specified author]
- context: [The context or background of the quote]
''';

  // Method to generate the user prompt for a custom author quote
  static String generateCustomAuthorQuoteUserPrompt({
    required String author,
    required String topic,
  }) {
    return '''
{
  "author": "$author",
  "topic": "$topic"
}
''';
  }


  // System prompts for other scenarios
  static const String _valueAnalysisSystemPrompt = '''
You are a philosophical thinker with deep insights into human values and ethics. Your task is to analyze and explain the given value in the specified context.

Provide the response in JSON format with the following keys:
- analysis: [Detailed analysis of the value]
- relevance: [Explanation of why this value is important in the given context]
- example: [A relevant example illustrating the value]
''';

}

enum PromptScenario {
  activityRecommendation,
  valueAnalysis,
  customAuthorQuote,
  // Add more scenarios as needed
}
