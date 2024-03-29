import 'package:get/get.dart';
import 'package:knowyourself/data/services/analytics/reflection_values/value_analysis.dart';

import '../../../data/repo/space/journal/journal_repo.dart';
import '../../../utils/constants/enums.dart';
import '../../mySpace/journal/model/journal_model.dart';
import '../model/core_values.dart';

class InsightsController extends GetxController {
  static InsightsController get instance => Get.find();

  final RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;
  final RxList<CoreValue> analyzedCoreValues = <CoreValue>[].obs;


  @override
  void onInit() {
    super.onInit();
    calculateInsights();
  }

  Future<void> loadJournalEntries() async {
    List<JournalEntry> entries = await JournalRepo.instance.getJournalEntries();
    journalEntries.assignAll(entries);
  }

  Future<void> calculateInsights() async {
    // Ensure we have enough entries
    await loadJournalEntries();
    if (journalEntries.length < 7) {
      print("Not enough journal entries for analysis.");
      print(journalEntries.length);
      return;
    }

    ValueAnalysis analysis = ValueAnalysis();
    Map<CoreValues, double> sumAnalysisResults = CoreValues.values.asMap().map((_, value) => MapEntry(value, 0.0));

    for (var entry in journalEntries) {
      final result = analysis.performAnalysis(entry.content);
      result.forEach((key, value) {
        sumAnalysisResults[key] = sumAnalysisResults[key]! + value;
      });
    }

    Map<CoreValues, double> averageAnalysisResults = sumAnalysisResults.map((key, value) => MapEntry(key, value / journalEntries.length));
    averageAnalysisResults.forEach((key, value) {
      analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value));
    });
  }
}
