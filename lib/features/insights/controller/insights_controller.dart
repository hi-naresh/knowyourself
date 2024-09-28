// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/animation.dart';
// import 'package:get/get.dart';
// import 'package:knowyourself/data/services/analytics/reflection_values/value_analysis.dart';
//
// import '../../../data/repo/auth/auth_repo.dart';
// import '../../../data/repo/space/journal/journal_repo.dart';
// import '../../../data/services/analytics/reflection_values/value_analysis_service.dart';
// import '../../../utils/constants/enums.dart';
// import '../../mySpace/journal/model/journal_model.dart';
// import '../model/core_values.dart';
//
// class InsightsController extends GetxController with GetSingleTickerProviderStateMixin{
//   static InsightsController get instance => Get.find();
//   late RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;
//   late RxList<JournalEntry> newJournalEntries = <JournalEntry>[].obs;
//   var analyzedCoreValues = <CoreValue>[].obs;
//   var fullCoreValues = <CoreValue>[].obs;
//   late AnimationController animationController; // Manage animation controller here
//   List<Animation<double>> animations = [];
//
//
//   void fullCoreValuesList() {
//     fullCoreValues.clear();
//     for (var value in CoreValues.values) {
//       fullCoreValues.add(CoreValue(name: value.toString().split('.').last, percentage: 100.0));
//     }
//   }
//
//   var showCoreValues = false.obs;
//
//   final StreamSubscription<User?> _authListener = AuthRepo.instance.authStateChanges.listen((User? user) {
//     if (user != null) {
//       InsightsController.instance.calculateInsights();
//     } else {
//       InsightsController.instance.analyzedCoreValues.clear();
//     }
//   });
//
//
//   @override
//   Future<void> onInit() async {
//     super.onInit();
//     fullCoreValuesList();
//     animationController = AnimationController(
//       duration: const Duration(milliseconds: 500), // Adjust duration as needed
//       vsync: this,
//     );
//     if (journalEntries.isEmpty) {
//       for (var value in CoreValues.values) {
//         analyzedCoreValues.add(CoreValue(name: value.toString().split('.').last, percentage: 0.0));
//       }
//     }
//     await loadJournalEntries().then((_) async {
//       journalEntries.refresh();
//       // await calculateInsights();
//       update();
//     });
//
//     ever(analyzedCoreValues, setupAnimations);
//     // Attach an auth state changes listener
//     _authListener;
//     setupAnimations(analyzedCoreValues);
//   }
//
//
//
//   @override
//   void onClose() {
//     animationController.dispose();
//     _authListener.cancel();
//     super.onClose();
//   }
//
//   void setupAnimations(List<CoreValue> coreValues) {
//     animations.clear(); // Clear existing animations
//     for (var coreValue in coreValues) {
//       var animation = Tween<double>(begin: 0, end: coreValue.percentage).animate(
//         CurvedAnimation(parent: animationController, curve: Curves.easeOut),
//       );
//       animations.add(animation);
//     }
//
//     animationController
//       ..reset()
//       ..forward();
//   }
//
//   Future<void> loadJournalEntries() async {
//     journalEntries.assignAll(await JournalRepo.instance.getJournalEntries());
//   }
//
//   Future<void> calculateInsights() async {
//     // Load only new journal entries that haven't been analyzed yet
//     await loadNewJournalEntries();
//
//     if (journalEntries.isEmpty) {
//       print("No new entries to analyze.");
//       return;
//     }
//
//     final JournalEntryAnalysisService analysisService = Get.put(JournalEntryAnalysisService());
//     Map<CoreValues, double> sumAnalysisResults = CoreValues.values.asMap().map((_, value) => MapEntry(value, 0.0));
//
//     int newEntryCount = 0;
//
//     for (var entry in journalEntries) {
//       if (entry.coreValues == null || entry.coreValues.isEmpty) {
//         // Perform analysis only if the entry hasn't been analyzed yet
//         Map<String, double> result = await analysisService.analyzeJournalEntry(entry.content);
//         newEntryCount++;
//
//         result.forEach((key, value) {
//           sumAnalysisResults[CoreValues.values.firstWhere((e) => e.toString().split('.').last == key)] =
//               (sumAnalysisResults[CoreValues.values.firstWhere((e) => e.toString().split('.').last == key)] ?? 0.0) + value;
//         });
//
//         // Save the analyzed core values to the journal entry
//         entry.coreValues = result;
//
//         // Update the journal entry in the repository
//         await JournalRepo.instance.updateJournalEntry(entry);
//       } else {
//         // Add the existing scores to the sum for accurate averaging later
//         entry.coreValues!.forEach((key, value) {
//           sumAnalysisResults[CoreValues.values.firstWhere((e) => e.toString().split('.').last == key)] =
//               (sumAnalysisResults[CoreValues.values.firstWhere((e) => e.toString().split('.').last == key)] ?? 0.0) + value;
//         });
//       }
//     }
//
//
//     // Calculate average values only for new entries
//     if (newEntryCount > 0) {
//       Map<CoreValues, double> averageAnalysisResults = sumAnalysisResults.map((key, value) {
//         return MapEntry(key, value / newEntryCount);
//       });
//
//       // Clear existing values before adding new ones
//       analyzedCoreValues.clear();
//       averageAnalysisResults.forEach((key, value) {
//         analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value));
//       });
//     } else {
//       print("No new entries analyzed.");
//     }
//   }
//
// // Modify this function to load only new journal entries
//   Future<void> loadNewJournalEntries() async {
//     // Assuming `JournalRepo.instance.getJournalEntries` is a function that fetches entries
//     // Modify this to only get entries that have not yet been analyzed
//     if (newJournalEntries.isEmpty && journalEntries.isEmpty) {
//       print("No new entries to analyze.");
//       return;
//     }
//
//     journalEntries.assignAll(await JournalRepo.instance.getJournalEntries());
//     journalEntries.refresh();
//     //now load new entries only
//     newJournalEntries = journalEntries.where((entry) => entry.analyzed == false).toList().obs;
//     newJournalEntries.refresh();
//
//
//
//     newJournalEntries.remove(newJournalEntries.where((entry) => entry.analyzed == true).toList());
//     newJournalEntries.refresh();
//
//   }
// }

// Future<void> calculateInsights() async {
//   // Ensure we have enough entries
//   await loadJournalEntries();
//   if (journalEntries.length < 7) {
//     print("Not enough journal entries for analysis.");
//     return;
//   }
//
//   final analysis = ValueAnalysis();
//   Map<CoreValues, double> sumAnalysisResults = CoreValues.values.asMap().map((_, value) => MapEntry(value, 0.0));
//
//   for (var entry in journalEntries) {
//     final result = analysis.performAnalysis(entry.content);
//     result.forEach((key, value) {
//       sumAnalysisResults[key] = sumAnalysisResults[key]! + value;
//     });
//     //save the analyzed core values to the journal entry to get storage now
//     entry.coreValues = result.map((key, value) => MapEntry(key.toString().split('.').last, value));
//     //update the journal entry with the analyzed core values in "coreValues" field under "journalEntries" collection
//     await JournalRepo.instance.updateJournalEntry(entry);
//   }
//
//   Map<CoreValues, double> averageAnalysisResults = sumAnalysisResults.map((key, value) => MapEntry(key, value / journalEntries.length*2));
//   // averageAnalysisResults.forEach((key, value) {
//   //   analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value));
//   // });
//
//   analyzedCoreValues.clear(); // Clear existing values before adding new ones
//   averageAnalysisResults.forEach((key, value) {
//     analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value));
//   });
//   // analyzedCoreValues.sort((a, b) => b.percentage.compareTo(a.percentage));
//
// }

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import '../../../data/repo/auth/auth_repo.dart';
import '../../../data/repo/space/insights/insights_repo.dart';
import '../../../data/repo/space/journal/journal_repo.dart';
import '../../../data/services/analytics/reflection_values/value_analysis_service.dart';
import '../../../utils/constants/enums.dart';
import '../../mySpace/journal/model/journal_model.dart';
import '../model/core_values.dart';

class InsightsController extends GetxController with GetSingleTickerProviderStateMixin {
  static InsightsController get instance => Get.find();

  RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;
  var analyzedCoreValues = <CoreValue>[].obs;
  var isLoading = true.obs;

  late AnimationController animationController;
  List<Animation<double>> animations = [];

  var showCoreValues = false.obs;

  final InsightsRepo insightsRepo = Get.put(InsightsRepo());
  final JournalRepo journalRepo = Get.put(JournalRepo());

  final Map<String, CoreValues> _responseKeyToCoreValueMap = {
    "Sincerity": CoreValues.sincerity,
    "Humility": CoreValues.humility,
    "Gratitude": CoreValues.gratitude,
    "Perseverance": CoreValues.perseverance,
    "Aspiration": CoreValues.aspiration,
    "Receptivity": CoreValues.receptivity,
    "Progress": CoreValues.progress,
    "Courage": CoreValues.courage,
    "Goodness": CoreValues.goodness,
    "Generosity": CoreValues.generosity,
    "Equanimity": CoreValues.equanimity,
    "Peace": CoreValues.peace,
  };

  final StreamSubscription<User?> _authListener = AuthRepo.instance.authStateChanges.listen((User? user) {
    if (user != null) {
      InsightsController.instance.loadAndAnalyzeJournalEntries();
    } else {
      InsightsController.instance.analyzedCoreValues.clear();
    }
  });

  @override
  Future<void> onInit() async {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    ever(analyzedCoreValues, setupAnimations);
    _authListener;

    await loadAndAnalyzeJournalEntries();

    setupAnimations(analyzedCoreValues);
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await loadAndAnalyzeJournalEntries();
  }

  @override
  void onClose() {
    animationController.dispose();
    _authListener.cancel();
    super.onClose();
  }

  Future<void> loadAndAnalyzeJournalEntries() async {
    try {
      isLoading.value = true;
      journalEntries.assignAll(await journalRepo.getJournalEntries());
      if (journalEntries.isEmpty) {
        initializeAnalyzedCoreValues();
      } else {
        await updateAnalyzedCoreValues();
      }
    } catch (e) {
      print("Error loading and analyzing journal entries: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAnalyzedCoreValues() async {
    Map<CoreValues, double> coreValuesSum = CoreValues.values.asMap().map((_, value) => MapEntry(value, 0.0));
    int entryCount = 0;

    for (var entry in journalEntries) {
      if (entry.coreValues.isNotEmpty) {
        entryCount++;
        entry.coreValues.forEach((key, value) {
          CoreValues? coreValue = _responseKeyToCoreValueMap[key];
          if (coreValue != null) {
            coreValuesSum[coreValue] = coreValuesSum[coreValue]! + value;
          }
        });
      }
    }

    if (entryCount > 0) {
      analyzedCoreValues.clear();
      coreValuesSum.forEach((key, value) {
        analyzedCoreValues.add(CoreValue(name: key.toString().split('.').last, percentage: value / entryCount));
      });
    } else {
      initializeAnalyzedCoreValues();
    }

    analyzedCoreValues.refresh();
    setupAnimations(analyzedCoreValues);
  }

  void initializeAnalyzedCoreValues() {
    analyzedCoreValues.clear();
    for (var value in CoreValues.values) {
      analyzedCoreValues.add(CoreValue(name: value.toString().split('.').last, percentage: 0.0));
    }
  }

  void setupAnimations(List<CoreValue> coreValues) {
    animations.clear();
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

  Future<void> calculateInsightsForEntry(JournalEntry entry) async {
    final analysisService = Get.put(JournalEntryAnalysisService());
    Map<String, double> result = await analysisService.analyzeJournalEntry(entry.content);

    entry.coreValues = result;
    entry.analyzed = true;

    print('Analyzed Data for Entry ${entry.id}: ${entry.coreValues}');

    await insightsRepo.storeAnalyzedCoreValues(entry.id!, result);

    await journalRepo.updateJournalEntry(entry);

    await updateAnalyzedCoreValues();
  }
}
