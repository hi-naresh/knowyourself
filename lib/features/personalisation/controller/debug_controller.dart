import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:knowyourself/features/learning/model/chapter_model.dart';
import 'package:knowyourself/features/learning/model/resources_model.dart';
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';
import '../../../data/helper_service/background_scheduler/background_service.dart';
import '../../../data/helper_service/notifications/notification_scheduler.dart';
import '../../../data/repo/materials/resources/remote/resources_online.dart';
import '../../../data/services/analytics/reflection_values/value_analysis_service.dart';
import '../../../data/services/mood_shifter/mood_service.dart';
import '../../../data/services/mood_shifter/mood_shift_device.dart';
import '../../../data/services/quotes/custom_quote.dart';

class DebugController extends GetxController {
  static DebugController get instance => Get.find();

  // final onlineResources = Get.put(OnlineResources()); // final


  @override
  Future<void> onInit() async {
    super.onInit();
  }

  // RxList<ChapterModel> myResources = <ChapterModel>[].obs;

  //load resources from json
  // Future<void> loadResources() async {
  //   final String resourcesJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
  //   final Map<String, dynamic> resourcesJson = json.decode(resourcesJsonString);
  //   final List<dynamic> resourcesJsonList = resourcesJson['chapters'];
  //
  //   final List<ChapterModel> resourcesList = resourcesJsonList
  //       .map((resource) => ChapterModel.fromMap(resource))
  //       .toList();
  //
  //   myResources.assignAll(resourcesList);
  // }

  // CustomQuoteService service = CustomQuoteService();
  var quote = Quote(text: '', author: '').obs;
  // RxBool isLoading = false.obs;
  var errorMessage = ''.obs;

  final CustomQuoteService quoteService = Get.put(CustomQuoteService( ));

  // QuoteController({required this.quoteService});

  Future<Quote> fetchQuote(String author) async {
    // isLoading.value=true;
    errorMessage('');
    try {
      var fetchedQuote = await quoteService.fetchQuoteByAuthor(author);
      quote.value = fetchedQuote;
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      // isLoading(false);
    }
    return quote.value;
  }

  // final MoodShiftDeviceService _moodShiftService = MoodShiftDeviceService();

  var activities = <ActivityModel>[].obs;
  var isLoading = false.obs;
  // var errorMessage = ''.obs;

  // void fetchActivities({
  //   required String mood,
  //   required String aspect,
  //   required String reason,
  //   required String place,
  // }) async {
  //   try {
  //     isLoading(true);
  //     errorMessage('Not available');
  //     final result = await _moodShiftService.suggestActivities(
  //       mood: mood,
  //       aspect: aspect,
  //       reason: reason,
  //       place: place,
  //     );
  //     activities(result);
  //     print(activities);
  //   } catch (e) {
  //     errorMessage(e.toString());
  //   } finally {
  //     isLoading(false);
  //   }
  // }


  Future<void> analyzeJournalEntry() async {
    final JournalEntryAnalysisService analysisService = Get.put(JournalEntryAnalysisService());

    String journalEntry = "Today I did nothing, just roam around the city with friends and spent too much money";

    try {
      Map<String, double> scores = await analysisService.analyzeJournalEntry(journalEntry);
      print('Analysis Scores: $scores');

      // You can now use these scores for further processing or display them in the UI
    } catch (e) {
      print('Error analyzing journal entry: $e');
    }
  }

  void initNotificationService() {
     // NotificationScheduler.clearAllScheduledTasks();
    // BackgroundService.cancelAllTasks();
    // BackgroundService.scheduleNotificationTask(
    //   'testNotification',
    //   'Test Notification',
    //   'This is a test notification!',
    //   Duration(minutes: 1),
    // );


  }



  Future<void> onPressed() async {
    // loadResources();
    // await onlineResources.saveResourcesToFirestore(myResources);
    initNotificationService();
    // await fetchQuote('Nelson Mandela');
    // print(quote.value.author + " " + quote.value.text);
    // fetchActivities(
    //   mood: 'Stressed',
    //   aspect: 'Work',
    //   reason: 'Overwhelmed by tasks',
    //   place: 'Office',
    // );


    // await analyzeJournalEntry();



  }
  
}