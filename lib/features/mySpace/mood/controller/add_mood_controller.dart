import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../data/repo/space/mood/mood_repo.dart';
import '../screens/add_mood/widgets/aspect_select.dart';
import '../screens/add_mood/widgets/express_feelings.dart';
import '../screens/add_mood/widgets/mood_select.dart';

class AddMoodController extends GetxController {

  static AddMoodController get instance => Get.find();

  final _moodRepo = Get.put(MoodRepo());

  final RxInt index = 0.obs;
  final PageController pageController = PageController();

  final RxList<MoodModel> moodEntries = <MoodModel>[].toList().obs;

  final Rx<MoodModel?> moodModel = Rx<MoodModel?>(null);

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

  // - Stressed
  // - Focused
  // - Confused
  // - Creative
  // - Exhausted
  // - Assertive

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

  // - Connected: Feeling a deep sense of connection to oneself, others, nature, or a higher power.
  // - Grounded: Experiencing a sense of stability, inner peace, and being centered in the present moment.
  // - Seeking: Experiencing a desire for spiritual growth, exploration, or understanding.
  // - Surrendered: Feeling a sense of trust, acceptance, and letting go of control to a higher power or divine will.
  // - Aligned: Feeling harmonious and in sync with one's values, beliefs, and actions.
  // - Empowered: Feeling a sense of inner strength, confidence, and agency derived from spiritual beliefs and practices.

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

  final List<AnimatedEmoji> emojis= [
    myEmojis(AnimatedEmojis.slightlyHappy),
    myEmojis(AnimatedEmojis.sad),
    myEmojis(AnimatedEmojis.rage),
    myEmojis(AnimatedEmojis.anxiousWithSweat),
    myEmojis(AnimatedEmojis.surprised),
    myEmojis(AnimatedEmojis.distraught),
    myEmojis(AnimatedEmojis.cry),
    myEmojis(AnimatedEmojis.sunglassesFace),
    myEmojis(AnimatedEmojis.bigFrown),
  ];

  String get moodString=> emojis[(sliderValue.value * emojis.length).round() % emojis.length].emoji.name;

  //set strings for each emoji in this order
  //slightlyHappy -> happy
  //sad -> sad
  //rage -> angry
  //anxiousWithSweat -> anxious
  //surprised -> surprised
  //distraught -> distraught
  //cry -> cry
  //sunglassesFace -> cool
  //bigFrown -> frown

  //use switch case for each emoji to get the moodString above ones

  String get userMoodString => moodString == 'slightlyHappy' ? 'Happy' : moodString == 'sad' ? 'Sad' : moodString == 'rage' ? 'Angry' : moodString == 'anxiousWithSweat' ? 'Anxious' : moodString == 'surprised' ? 'Surprised' : moodString == 'distraught' ? 'Distraught' : moodString == 'cry' ? 'Cry' : moodString == 'sunglassesFace' ? 'Cool' : 'Frown';

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

  final List<Widget> journalPages = [
    const AspectSelectPage(),
    const MoodSelectPage(),
    const ExpressFeelingsPage(),
  ];

  // void updateAspect(LifeAspects aspect) {
  //   selectAspect.value = aspect.index;
  //   // Update emojis or other variables based on the aspect
  //   switch(aspect) {
  //     case LifeAspects.mental:
  //       break;
  //     case LifeAspects.physical:
  //       break;
  //     case LifeAspects.emotional:
  //       break;
  //     case LifeAspects.spiritual:
  //       break;
  //     case LifeAspects.all:
  //       // TODO: Handle this case.
  //   }
  // }


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
      mood: moodString.toString(),
      aspect: aspectString,
      description: reasons.text,
      happenedAt: happenedAtString, id: '',
      entryDate: DateTime.now(),
    ));
    loadMoodEntries();
    moodEntries.refresh();
    Get.back();
    KHelper.showSnackBar("Saved Entry!", "Successfully stored your entry at mood board.");

  }

  void shiftMood() {
    Get.toNamed(KRoutes.getActivitiesRoute());
  }

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
