import 'package:animated_emoji/animated_emoji.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/mood/controller/add_mood_controller.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

class MoodBoard extends StatelessWidget {
  const MoodBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return Padding(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '${KTexts.my} ',
                    style: Theme.of(context).textTheme.headlineMedium),
                TextSpan(
                  text: KTexts.moodBoardTitle,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: KColors.kApp4,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: KSizes.sm,),
          Text(
            KTexts.moodSubtitle,
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: KSizes.spaceBtwSections),
          SizedBox(
            height: 400,
            child: Obx(
              () {
                if (controller.moodEntries.isEmpty) {
                  return const Center(
                    child: Text(KTexts.noMoodEntries),
                  );
                }
                return ListView.builder(
                itemCount: controller.moodEntries.length,
                itemBuilder: (context, index) {
                  final mood = controller.moodEntries[index];
                  return CustomContainer(
                    margin: const EdgeInsets.only(bottom: KSizes.defaultSpace),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(mood.entryDate.day.toString(),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium,
                            ),
                            Text(
                              KHelper.getFormattedDateString(
                                  mood.entryDate, format: "MMM"),
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodySmall,
                            )
                          ],
                        ),
                        const SizedBox(
                          width: KSizes.defaultSpace,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mood.mood),
                            Text("${mood.aspect} at ${mood.place} Place",
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .labelMedium,)
                          ],
                        ),
                        const Spacer(),
                        AnimatedEmoji(
                          controller.emotionalEmojis[(controller.sliderValue.value *
                              controller.emotionalEmojis.length).floor() %
                              controller.emotionalEmojis.length].emoji,
                          source: AnimatedEmojiSource.asset,
                          size: 30,
                          repeat: false,
                        ),


                      ],
                    ),
                  );

                },
              );},
            ),
          ),
        ],
      ),
    );
  }
}

