import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/services/analytics/reflection_values/value_analysis.dart';

import '../../../data/repo/auth/auth_repo.dart';
import '../../../data/repo/space/journal/journal_repo.dart';
import '../../../utils/constants/enums.dart';
import '../../mySpace/journal/model/journal_model.dart';
import '../model/core_values.dart';

class InsightsController extends GetxController with GetSingleTickerProviderStateMixin{
  static InsightsController get instance => Get.find();
  final RxList<JournalEntry> journalEntries = <JournalEntry>[].obs;
  var analyzedCoreValues = <CoreValue>[].obs;
  late AnimationController animationController; // Manage animation controller here
  List<Animation<double>> animations = [];

  var showCoreValues = false.obs;

  final StreamSubscription<User?> _authListener = AuthRepo.instance.authStateChanges.listen((User? user) {
    if (user != null) {
      InsightsController.instance.calculateInsights();
    } else {
      InsightsController.instance.analyzedCoreValues.clear();
    }
  });

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
    await loadJournalEntries().then((_) async {
      journalEntries.refresh();
      // await calculateInsights();
      update();
    });

    ever(analyzedCoreValues, setupAnimations);
    // Attach an auth state changes listener
    _authListener;
    setupAnimations(analyzedCoreValues);

  }

  @override
  void onClose() {
    animationController.dispose();
    _authListener.cancel();
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
    journalEntries.assignAll(await JournalRepo.instance.getJournalEntries());
  }

  Future<void> calculateInsights() async {
    // Ensure we have enough entries
    await loadJournalEntries();
    if (journalEntries.length < 7) {
      print("Not enough journal entries for analysis.");
      return;
    }

    ValueAnalysis analysis = ValueAnalysis();
    Map<CoreValues, double> sumAnalysisResults = CoreValues.values.asMap().map((_, value) => MapEntry(value, 0.0));

    for (var entry in journalEntries) {
      final result = analysis.performAnalysis(entry.content);
      result.forEach((key, value) {
        sumAnalysisResults[key] = sumAnalysisResults[key]! + value;
      });
      //save the analyzed core values to the journal entry to get storage now
      entry.coreValues = result.map((key, value) => MapEntry(key.toString().split('.').last, value));
      //update the journal entry with the analyzed core values in "coreValues" field under "journalEntries" collection
      await JournalRepo.instance.updateJournalEntry(entry);
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
