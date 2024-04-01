import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/services/analytics/reflection_values/value_analysis.dart';

import '../../../data/repo/space/journal/journal_repo.dart';
import '../../../utils/constants/enums.dart';
import '../../mySpace/journal/model/journal_model.dart';
import '../model/core_values.dart';

class InsightsController extends GetxController with GetSingleTickerProviderStateMixin{
  static InsightsController get instance => Get.find();
  final RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;
  var analyzedCoreValues = <CoreValue>[].obs;
  late AnimationController animationController; // Manage animation controller here
  List<Animation<double>> animations = []; // Animations for each CoreValue

  @override
  Future<void> onInit() async {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500), // Adjust duration as needed
      vsync: this,
    );
    if (journalEntries.isEmpty) {
      for (var value in CoreValues.values) {
        analyzedCoreValues.add(CoreValue(name: value.toString().split('.').last, percentage: 0.0));
      }
    }
    ever(analyzedCoreValues, setupAnimations);

    // Then call calculateInsights
    calculateInsights();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  void setupAnimations(List<CoreValue> coreValues) {
    animations.clear(); // Clear existing animations
    for (var coreValue in coreValues) {
      var animation = Tween<double>(begin: 0, end: coreValue.percentage).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      );
      animations.add(animation);
    }

    animationController
      ..reset()
      ..forward();
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

    Map<CoreValues, double> averageAnalysisResults = sumAnalysisResults.map((key, value) => MapEntry(key, value / journalEntries.length*2));
    // averageAnalysisResults.forEach((key, value) {
    //   analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value));
    // });

    analyzedCoreValues.clear(); // Clear existing values before adding new ones
    averageAnalysisResults.forEach((key, value) {
      analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value));
    });
    // analyzedCoreValues.sort((a, b) => b.percentage.compareTo(a.percentage));
  }
}
