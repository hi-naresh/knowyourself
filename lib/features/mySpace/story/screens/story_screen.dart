import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/story/screens/widgets/story_section.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../controller/my_story_controller.dart';


class MyStoryScreen extends StatelessWidget {
  const MyStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final StoryController controller = Get.put(StoryController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
      child: ListView(
        children:[
          Obx(() => StorySection(
            storyType: StoryType.current,
            story: controller.currentStory.value,
          )),
          const Padding(
            padding: EdgeInsets.all(KSizes.md),
            child: Icon(Icons.swap_calls_rounded, size: 60),
          ),
          Obx(() => StorySection(
            storyType: StoryType.desired,
            story: controller.desiredStory.value,
          )),
        ]
      ),
    );
  }
}
