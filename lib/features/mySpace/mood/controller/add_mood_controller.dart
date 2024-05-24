import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/data/services/mood_shifter/mood_service.dart';
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../data/repo/space/activity/activity_repo.dart';
import '../../../../data/repo/space/mood/mood_repo.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../screens/add_mood/widgets/aspect_select.dart';
import '../screens/add_mood/widgets/express_feelings.dart';
import '../screens/add_mood/widgets/mood_select.dart';

class AddMoodController extends GetxController {

  static AddMoodController get instance => Get.find();

  final _moodRepo = Get.put(MoodRepo());
  final _activityRepo = Get.put(ActivityRepo());
  

  final RxInt index = 0.obs;
  final PageController pageController = PageController();

  final RxList<MoodModel> moodEntries = <MoodModel>[].toList().obs;

  final Rx<MoodModel?> moodModel = Rx<MoodModel?>(null);

  final RxString humanState = ''.obs;

  //physical
  final List physicalList = [
    'Energetic',
    'Fatigued',
    'Relaxed',
    'Tense',
    'Sore',
    'Alert',
    'Lethargic',
    'Flexible',
    'Achy',
    'Numb',
    'Strong',
    'Weak',
  ];
  final selectedPhysical = ''.obs;
  void setSelectedPhysical(int index) {
    selectedPhysical.value = physicalList[index];
  }

  //mental
  final List mentalList = [
    'Stressed',
    'Focused',
    'Confused',
    'Creative',
    'Exhausted',
    'Assertive',
  ];
  final selectedMental = ''.obs;
  void setSelectedMental(int index) {
    selectedMental.value = mentalList[index];
  }

  //spiritual
  final List spiritualList = [
    'Connected',
    'Grounded',
    'Seeking',
    'Surrendered',
    'Aligned',
    'Empowered',
  ];
  final selectedSpiritual = ''.obs;
  void setSelectedSpiritual(int index) {
    selectedSpiritual.value = spiritualList[index];
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    loadMoodEntries();
    moodEntries.refresh();
  }

  void loadMoodEntries() async{
    final getEntries = await _moodRepo.getMoodEntries();
    if (getEntries.isNotEmpty) {
      moodEntries.assignAll(getEntries);
    }
  }

  //mood
  RxDouble sliderValue = 0.0.obs;

  static myEmojis(emoji) => AnimatedEmoji(emoji, size: 40, repeat: true, source:  AnimatedEmojiSource.asset,);

  final List<AnimatedEmoji> emotionalEmojis= [
    myEmojis(AnimatedEmojis.grin),
    myEmojis(AnimatedEmojis.sad),
    myEmojis(AnimatedEmojis.rage),
    myEmojis(AnimatedEmojis.anxiousWithSweat),
    myEmojis(AnimatedEmojis.surprised),
    myEmojis(AnimatedEmojis.sweat),
    myEmojis(AnimatedEmojis.scared),
    myEmojis(AnimatedEmojis.grinning),
    myEmojis(AnimatedEmojis.pleading),
    myEmojis(AnimatedEmojis.distraught),
    myEmojis(AnimatedEmojis.cry),
  ];

  String get moodString=> emotionalEmojis[(sliderValue.value * emotionalEmojis.length).round() % emotionalEmojis.length].emoji.name;

  //set strings for each emoji in this order
  //sad -> sad
  //rage -> angry
  //anxiousWithSweat -> anxious
  //surprised -> surprised
  //distraught -> distraught
  //cry -> cry
//pleading -> guilty
  //scared -> scared
  //sweat -> stressed
  //grinning -> excited
  //grin -> happy
  String get userMoodString => moodString == 'sad' ? 'Sad' : moodString == 'rage' ? 'Angry' : moodString == 'anxiousWithSweat' ? 'Anxious' : moodString == 'surprised' ? 'Surprised' : moodString == 'distraught' ? 'Distraught' : moodString == 'cry' ? 'Cry' : moodString == 'pleading' ? 'Guilty' : moodString == 'scared' ? 'Scared' : moodString == 'sweat' ? 'Stressed' : moodString == 'grinning' ? 'Excited':moodString=="grin" ? 'Happy' : 'Nothing';
  int get moodIndex => (sliderValue.value * emotionalEmojis.length).round();

  //human state from physical, mental, emotional, spiritual
  String getHumanState() {
    if (selectAspect.value == 0) {
      return selectedMental.value;
    } else if (selectAspect.value == 1) {
      return selectedPhysical.value;
    } else if (selectAspect.value == 2) {
      return userMoodString;
    } else {
      return selectedSpiritual.value;
    }
  }

  RxInt selectAspect = 0.obs;
  // List<String> aspectsList = ['Mentally\n ${KTexts.mentalDescription}', 'Physically\n ${KTexts.physicalDescription}', 'Emotionally\n ${KTexts.vitalDescription}', 'Spiritually\n ${KTexts.spiritualDescription}'];
  List<String> aspectsList = ['Mentally', 'Physically', 'Emotionally', 'Spiritually'];
  List<String> aspectDescriptions = [(KTexts.mentalDescription), (KTexts.physicalDescription), (KTexts.vitalDescription), (KTexts.spiritualDescription)];
  //get aspect from index
  String get aspectString => aspectsList[selectAspect.value];
  RxInt selectHappenedAt = 0.obs; //0 for social, 1 for work, 2 for home, 3 for personal
  final happenedAt = ['Social', 'Work', 'Home', 'Personal'];
  //get happenedAt from index
  String get happenedAtString => happenedAt[selectHappenedAt.value];
  final TextEditingController reasons = TextEditingController();

  final RxList activitiesTitle = [].obs;

  final activities = <ActivityModel>[];


  final List<Widget> journalPages = [
    const AspectSelectPage(),
    const MoodSelectPage(),
    const ExpressFeelingsPage(),
  ];

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void jumpToPage( index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut
    );
  }

  void previousPage() {
    if (pageController.page!.round() > 0) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn);
    } else {
      Get.back();
    }
  }

  Future<void> saveMoodData() async {
    await _moodRepo.saveMoodEntry(MoodModel(
      // consider saving all states physically, mentally, emotionally, spiritually
      mood: getHumanState() ,
      aspect: aspectString,
      reason: reasons.text,
      place: happenedAtString, id: '',
      entryDate: DateTime.now(),
    ));
    loadMoodEntries();
    moodEntries.refresh();
    Get.back();
    KHelper.showSnackBar(KTexts.savedEntryTitle, KTexts.savedEntryMessage);

  }


  Future<void> shiftMood() async {
    
    final moodService = MoodShiftService.instance;
    
    try {
      MoodModel currentMood = MoodModel(
        mood: getHumanState(),
        aspect: aspectString,
        reason: reasons.text,
        place: happenedAtString,
        shift: true,
        id: '',  // Ensure you have a valid ID if necessary
        entryDate: DateTime.now(),
      );

      //save mood before shifting
      await _moodRepo.saveMoodEntry(currentMood);

      // Use the repository to recommend activities based on the current mood
      // List<String> userActivities = await _moodRepo.recommendActivity(currentMood, moodIndex, selectAspect.value, selectHappenedAt.value, 0);
      List<ActivityModel> userActivities = await moodService.fetchActivities(currentMood);
      // print('Recommended activities: $userActivities');
      //save recommended activities


      // List<String> activityTitles = [];
      for (var activity in userActivities) {
        activities.add(ActivityModel(
          id: activity.id,
          userId: '1',
          link: activity.link,
          title: activity.title,
          instructions: activity.instructions,
          imageUrl: KImages.health9,
          color: changeColor(activities.length),
          tag: 'Physical health',
        ));
      }

      // print(activities);
      // await _activityRepo.clearLastActivities();

      await _activityRepo.saveLastActivities(activities);

      // print(activities);


      activitiesTitle.assignAll(activities.map((e) => e.title).toList());
      // print('Recommended activities: $userActivities');
      // print(activitiesTitle);
      // print("Navigating to activities");


      // Optionally, you can handle the navigation or any follow-up actions here
      if (userActivities.isNotEmpty) {
        // Navigate or display activities
        Get.toNamed(KRoutes.getActivitiesRoute());
      } else {
        KHelper.showSnackBar(KTexts.noActivitiesFoundTitle, KTexts.noActivitiesFoundMessage);
      }
    } catch (e) {
      // print('Error in shifting mood: $e');
      KHelper.showSnackBar(KTexts.tryAgainTitle, KTexts.tryAgainMessage);
    }
  }

  //make changeColor function which can be used to change color of activities after every 4 activities
  Color changeColor(int index) {
    if (index % 4 == 0) {
      return KColors.kApp1;
    } else if (index % 4 == 1) {
      return KColors.kApp2;
    } else if (index % 4 == 2) {
      return KColors.kApp3;
    } else {
      return KColors.kApp4;
    }
  }
  //


  deFocusKeyboard(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Future<void> deleteMoodEntry(String entryId) async {
    await _moodRepo.deleteMoodEntry(entryId);
    moodEntries.removeWhere((entry) => entry.id == entryId);
    // KHelper.showSnackBar("Deleted", "Successfully deleted the entry of yours.");
    moodEntries.refresh();
  }

}
