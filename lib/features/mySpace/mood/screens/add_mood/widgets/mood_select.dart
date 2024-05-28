import 'package:flutter/material.dart';
import 'package:animated_emoji/animated_emoji.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/shadow_disabler.dart';
import '../../../controller/add_mood_controller.dart';
import 'helpers/full_circle_slider.dart';
import 'package:get/get.dart';

class MoodSelectPage extends StatelessWidget {
  const MoodSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const ProgressBar(percent: 0.6, steps: "2/3"),
            const SizedBox(height: KSizes.spaceBtwSections),
            AspectSpecificContent(controller: controller),
          ],
        ),
      ),
    );
  }
}

// Widget to display aspect-specific content
class AspectSpecificContent extends StatelessWidget {
  final AddMoodController controller;
  const AspectSpecificContent({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      switch (controller.selectAspect.value) {
        case 0:
          return const MentalPage();
        case 1:
          return const PhysicalPage();
        case 2:
          return const EmotionalPage();
        case 3:
          return const SpiritualPage();
        default:
          return const SizedBox();
      }
    });
  }
}

// Mental, Physical, Emotional, and Spiritual pages are defined below.

// Widget to display the mental aspect page
class MentalPage extends StatelessWidget {
  const MentalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    return Column(
      children: [
        Text(
          'How do you feel Mentally?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(0),
          itemCount: controller.mentalList.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  controller.setSelectedMental(index);
                  controller.nextPage();
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: controller.selectedMental.value ==
                            controller.mentalList[index]
                        ? KColors.primary // Highlight if selected
                        : Colors.transparent,
                    child: Text(
                      controller.mentalList[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                    // child: SvgPicture.asset(
                    //   avatarPath,
                    //   height: 70,
                    // ),
                    ),
              ),
            );
          },
        )
      ],
    );
  }
}

// Widget to display the physical aspect page
class PhysicalPage extends StatelessWidget {
  const PhysicalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    return Column(
      children: [
        Text(
          'How do you feel physically?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(0),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  controller.setSelectedPhysical(index);
                  controller.nextPage();
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: controller.selectedPhysical.value ==
                            controller.physicalList[index]
                        ? KColors.primary // Highlight if selected
                        : Colors.transparent,
                    child: Text(
                      controller.physicalList[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                    // child: SvgPicture.asset(
                    //   avatarPath,
                    //   height: 70,
                    // ),
                    ),
              ),
            );
          },
        )
      ],
    );
  }
}

class EmotionalPage extends StatelessWidget {
  const EmotionalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "How Are You\n Feeling?",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontSize: KSizes.xxl,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(
                  height: KSizes.defaultSpace * 2,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Obx(
                      () => FullCircleSlider(
                        value: controller.sliderValue.value,
                        onChanged: (newValue) =>
                            controller.sliderValue.value = newValue,
                        emojis: controller.emotionalEmojis,
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
                        ]),
                      ),
                      // Slider(
                      //   value: controller.sliderValue.value,
                      //   onChanged: (newValue) {
                      //     controller.sliderValue.value = newValue;
                      //   },
                      //   min: 0.0,
                      //   max: 1.0,
                      // ),
                      child: Obx(
                        () => AnimatedEmoji(
                          controller
                              .emotionalEmojis[(controller.sliderValue.value *
                                          controller.emotionalEmojis.length)
                                      .floor() %
                                  controller.emotionalEmojis.length]
                              .emoji,
                          source: AnimatedEmojiSource.asset,
                          size: 200,
                          repeat: true,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: KSizes.defaultSpace * 2,
                ),
                Obx(() => Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Emotion\n",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          TextSpan(
                            text: controller.userMoodString,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox( height: KSizes.defaultSpace),
          ElevatedButton(
              onPressed: ()=> controller.nextPage(),
              child: const Text('Next')),
        ],
      ),
    );
  }
}

// Widget to display the spiritual aspect page
class SpiritualPage extends StatelessWidget {
  const SpiritualPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    return Column(
      children: [
        Text(
          'How do you feel Spiritually?',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(0),
          itemCount: controller.spiritualList.length,
          itemBuilder: (context, index) {
            return Obx(
              () => GestureDetector(
                onTap: () {
                  controller.setSelectedSpiritual(index);
                  controller.nextPage();
                },
                child: CircleAvatar(
                    radius: 30,
                    backgroundColor: controller.selectedSpiritual.value ==
                            controller.spiritualList[index]
                        ? KColors.primary // Highlight if selected
                        : Colors.transparent,
                    child: Text(
                      controller.spiritualList[index],
                      style: Theme.of(context).textTheme.bodyLarge,
                    )
                    // child: SvgPicture.asset(
                    //   avatarPath,
                    //   height: 70,
                    // ),
                    ),
              ),
            );
          },
        )
      ],
    );
  }
}
