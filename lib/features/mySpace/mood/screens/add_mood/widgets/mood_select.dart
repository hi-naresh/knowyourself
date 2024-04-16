import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../../../../utils/helpers/shadow_disabler.dart';
import '../../../controller/add_mood_controller.dart';
import 'helpers/full_circle_slider.dart';
import 'package:get/get.dart';

class MoodSelectPage extends StatelessWidget {
  const MoodSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    final Map<String, AnimatedEmojiData> emotionMap = {
      'Happy': AnimatedEmojis.smileWithBigEyes,
      'Sad': AnimatedEmojis.sad,
      'Anxious': AnimatedEmojis.anxiousWithSweat,
      'Excited': AnimatedEmojis.smilingEyesWithHandOverMouth,
      'Calm': AnimatedEmojis.relieved,
      'Angry': AnimatedEmojis.rage,
      'Grateful': AnimatedEmojis.halo,
      'Stressed': AnimatedEmojis.distraught,
      'Lonely': AnimatedEmojis.cry,
      'Confident': AnimatedEmojis.sunglassesFace,
      'Guilty': AnimatedEmojis.bigFrown,
      'Empathetic': AnimatedEmojis.starStruck,
      'Envious': AnimatedEmojis.triumph,
      'Optimistic': AnimatedEmojis.heartFace,
      'Overwhelmed': AnimatedEmojis.concerned,
    };

    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProgressBar(percent:0.6,steps: "2/3"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  KTexts.howAreYouFeeling,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    fontSize: KSizes.xxl,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: KSizes.defaultSpace*2,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                    ()=> FullCircleSlider(
                        value: controller.sliderValue.value,
                        onChanged: (newValue)=> controller.sliderValue.value = newValue,
                        emojis: controller.emojis,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                        boxShadow: CustomShadow.getShadow([
                          BoxShadow(
                            color: Colors.orange.withOpacity(0.5),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ]
                        ),
                      ),
                      child:  Obx(() {
                        final emojiData = emotionMap.values.elementAt((controller.sliderValue.value * (emotionMap.length - 1)).round());
                        return AnimatedEmoji(
                          emojiData,
                          size: 216,
                          repeat: true,
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(
                  height: KSizes.defaultSpace*2,
                ),
                Obx(
                    ()=> Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: KTexts.emotion,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          TextSpan(
                            // text: controller.moodString,
                            // text: emojiName,
                            text: emotionMap.keys.elementAt((controller.sliderValue.value * (emotionMap.length - 1)).round()),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )
                ),
              ],
            ),
            TextButton(
                style: const ButtonStyle().copyWith(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 60)),
                    backgroundColor: MaterialStateProperty.all(kApp1),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: ()=> controller.nextPage(),
                child: Text(
                  KTexts.next,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
