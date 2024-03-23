import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../../utils/helpers/shadow_disabler.dart';
import '../../../controller/add_mood_controller.dart';
import 'helpers/full_circle_slider.dart';
import 'package:get/get.dart';

class MoodSelectPage extends StatelessWidget {
  const MoodSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProgressBar(percent:0.3,steps: "1/3"),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "How Are You Feeling?",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(
                  height: KSizes.defaultSpace,
                ),
                Text(
                  "Emotion: ${(controller.sliderValue.value * 10).round()}",
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: KSizes.defaultSpace,
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
                        ]),                      ),
                      child: Obx(
                            ()=> AnimatedEmoji(
                          AnimatedEmojis.values[(controller.sliderValue.value * 10).round()],
                          size: 216,
                          repeat: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: ()=> controller.nextPage(),
                child: const Text("Next")
            ),
          ],
        ),
      ),
    );
  }
}
