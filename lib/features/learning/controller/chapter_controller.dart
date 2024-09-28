// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:knowyourself/data/repo/materials/learning/local/chapters_local.dart';
// import 'package:knowyourself/data/repo/materials/learning/remote/chapters_remote.dart';
// import 'package:knowyourself/utils/constants/enums.dart';
// import 'package:knowyourself/utils/helpers/helper_functions.dart';
//
// import '../../../data/repo/materials/learning/learn_repo.dart';
// import '../model/chapter_model.dart';
// import '../screens/chapters/chapter_screens.dart';
//
// class LearningController extends GetxController {
//   final RxList<ChapterModel> chaptersList = <ChapterModel>[].obs;
//   final PageController pageController = PageController();
//   Map<int, Map<int, int>> userAnswers = {};
//   // final learnRepo = Get.put(LearnRepo());
//   final localRepo = Get.put(ChaptersRepo());
//   final onlineRepo = Get.put(ChaptersOnline());
//   // final RxList<ChapterModel> chaptersList = <ChapterModel>[].obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     // loadMaterialsFromJson("mental");
//     // loadMaterialsForAspect("aspect"); // Load initial material
//   }
//
//   // load materials from asset , json file
//   Future<void> loadMaterialsFromJson(String aspect) async {
//     final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
//     final Map<String, dynamic> chaptersJson = json.decode(chaptersJsonString);
//     final List<dynamic> chaptersJsonList = chaptersJson['chapters'];
//
//     final List<ChapterModel> chaptersListRaw = chaptersJsonList
//         .map((chapter) => ChapterModel.fromJson(chapter))
//         .where((chapter) => chapter.aspect.split('.').last == aspect)
//         .toList();
//
//     // print(chaptersList)
//
//     chaptersList.assignAll(chaptersListRaw);
//
//   }
//
//   // Future<void> loadFromOnline() async {
//   //   var resources = await onlineRepo.fetchResourcesFromFirestore();
//   //   await localRepo.saveExternalResources(resources);
//   // }
//
//   // Future<void> fetchMaterials( String type) async {
//   //   List<ChapterModel> fetchedMaterials = await localRepo.getExternalResources();
//   //   print(fetchedMaterials);
//   //   if (fetchedMaterials.isEmpty) {
//   //     // await localRepo.loadFromOnline();
//   //     await loadFromOnline();
//   //     KHelper.showSnackBar("Fetching Latest Chapters", "Please wait while we fetch the latest chapters");
//   //   } else {
//   //     // print("reached : $fetchedMaterials" );
//   //     List<ChapterModel> filteredMaterials = fetchedMaterials.where(
//   //             (element) => element.aspect.split(".").last == type).toList();
//   //     // print(filteredMaterials);
//   //     chaptersList.assignAll(filteredMaterials);
//   //     // print(chaptersList);
//   //   }
//   //   // List<ChapterModel> filteredMaterials = fetchedMaterials.where(
//   //   //         (element) => element.aspect.toString() == type.toString().split(".").last ).toList();
//   //   // chaptersList.assignAll(filteredMaterials);
//   // }
//
//   // void answerQuizQuestion(int chapterIndex, int questionIndex, int selectedAnswerIndex) {
//   //   userAnswers[chapterIndex] ??= {};
//   //   userAnswers[chapterIndex]![questionIndex] = selectedAnswerIndex;
//   //
//   //   var isCorrect = chaptersList[chapterIndex].quizQuestions![questionIndex].correctAnswerIndex == selectedAnswerIndex;
//   //   Get.snackbar(
//   //     'Answer ${isCorrect ? 'Correct' : 'Incorrect'}',
//   //     isCorrect ? 'Great job!' : 'Try again!',
//   //     backgroundColor: isCorrect ? Colors.green : Colors.red,
//   //   );
//   //
//   //   if (isCorrect) {
//   //     updateProgress(chapterIndex, ((questionIndex + 1) / chaptersList[chapterIndex].quizQuestions!.length));
//   //     if (questionIndex == chaptersList[chapterIndex].quizQuestions!.length - 1) {
//   //       chapterCompleted(chapterIndex);
//   //     }
//   //   }
//   // }
//
//   void chapterCompleted(int index) {
//     updateProgress(index, 1, completed: true);
//     Get.to(() => const CongratulationsScreen());
//   }
//
//   void updateProgress(int index, double progress, {bool completed = false}) {
//     var chapter = chaptersList[index];
//     // chaptersList[index] = chapter.copyWith(progress: progress, completed: completed);
//     //save progress to my learning repo
//   }
//
//   void jumpToNextPage(int index) {
//     pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
//   }
//
//   void navigateToChapterContent(int index) {
//     Get.to(() => ChapterContentView(index: index));
//   }
//
//   void closeChapterContent() {
//     Get.back();
//   }
//
//   getSelectedOptionForQuestion(int chapterIndex, int questionIndex) {
//     return userAnswers[chapterIndex]?[questionIndex];
//   }
//
//   ChapterModel getMaterialAtIndex(int index) {
//     return chaptersList[index];
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/repo/materials/learning/local/chapters_local.dart';
import 'package:knowyourself/data/repo/materials/learning/remote/chapters_remote.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../data/repo/materials/learning/learn_repo.dart';
import '../model/chapter_model.dart';
import '../screens/chapters/chapter_screens.dart';
import '../screens/chapters/congratulations_screen.dart';

class LearningController extends GetxController {
  final RxList<ChapterModel> chaptersList = <ChapterModel>[].obs;
  final PageController pageController = PageController();
  Map<int, Map<int, int>> userAnswers = {};
  final localRepo = Get.put(ChaptersRepo());
  final onlineRepo = Get.put(ChaptersOnline());

  final AudioPlayer audioPlayer = AudioPlayer();
  RxBool isPlaying = false.obs;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  Duration? _duration;
  Duration? _position;


  Future<void> playAudio() async {
    await audioPlayer.play(AssetSource('audio/audio.mp3'));
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  @override
  void onInit() {
    super.onInit();
    _initStreams();
  }

  @override
  void onClose() {
    _disposeStreams();
    audioPlayer.dispose();
    super.onClose();
  }

  Future<void> loadMaterialsFromJson(String aspect) async {
    final String chaptersJsonString = await rootBundle.loadString('assets/chapters/chapters.json');
    final Map<String, dynamic> chaptersJson = json.decode(chaptersJsonString);
    final List<dynamic> chaptersJsonList = chaptersJson['chapters'];

    final List<ChapterModel> chaptersListRaw = chaptersJsonList
        .map((chapter) => ChapterModel.fromJson(chapter))
        .where((chapter) => chapter.aspect.split('.').last == aspect)
        .toList();

    chaptersList.assignAll(chaptersListRaw);
  }

  // Future<void> playAudio(String url) async {
  //   await audioPlayer.play(UrlSource(url));
  //   isPlaying.value = true;
  // }
  //
  // Future<void> pauseAudio() async {
  //   await audioPlayer.pause();
  //   isPlaying.value = false;
  // }

  void toggleAudio() {
    if (isPlaying.value) {
      pauseAudio();
    } else {
      playAudio();
    }
  }

  void _initStreams() {
    _durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      _duration = duration;
    });

    _positionSubscription = audioPlayer.onPositionChanged.listen((position) {
      _position = position;
    });

    _playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      _position = Duration.zero;
    });

    _playerStateChangeSubscription = audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
  }

  void _disposeStreams() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
  }

  void chapterCompleted(int index) {
    updateProgress(index, 1, completed: true);
    Get.to(() => const CongratulationsScreen());
  }

  void updateProgress(int index, double progress, {bool completed = false}) {
    var chapter = chaptersList[index];
    // Save progress to your learning repo
  }

  void jumpToNextPage(int index) {
    pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void navigateToChapterContent(int index) {
    Get.to(() => ChapterContentView(index: index));
  }

  void closeChapterContent() {
    Get.back();
  }

  int? getSelectedOptionForQuestion(int chapterIndex, int questionIndex) {
    return userAnswers[chapterIndex]?[questionIndex];
  }

  ChapterModel getMaterialAtIndex(int index) {
    return chaptersList[index];
  }
}
