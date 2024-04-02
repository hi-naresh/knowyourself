import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/custom_container.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';
import '../../controller/my_story_controller.dart';
import '../../model/story_model.dart';

import '../../../../../utils/constants/enums.dart';

class StorySection extends StatelessWidget {
  final StoryType storyType;
  final StoryModel? story;

  const StorySection({super.key, required this.storyType, this.story});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StoryController>();
    bool isEditing = story == null;

    return CustomContainer(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace,vertical: KSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(storyType == StoryType.current ? 'Current Story' : 'Desired Story',
                  style: Theme.of(context).textTheme.headlineSmall),
              const Spacer(),
              TextButton(
                  style: const ButtonStyle().copyWith(
                      backgroundColor: MaterialStateProperty.all(kApp4),
                      foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  onPressed: () => controller.updateStory(storyType),
                  child: const Text('Update',)),
              const SizedBox(width: KSizes.sm),
              TextButton(
                  style: const ButtonStyle().copyWith(
                      backgroundColor: MaterialStateProperty.all(kApp4),
                      foregroundColor: MaterialStateProperty.all(Colors.white)
                  ),
                  onPressed: () => controller.deleteStory( storyType),
                  child: const Text('Delete',))

            ],
          ),
          const SizedBox(height: KSizes.sm),
          Text(storyType == StoryType.current ?
          'Describe your ongoing life story in brief.' :
          'Imagine you are narrating your story on tedX Stage. What will it be like?',
              style: Theme.of(context).textTheme.labelMedium),

          const SizedBox(height: KSizes.defaultSpace),
          if (isEditing) ...[
            _buildTextField(controller.characterCtrl, 'Character'),
            _buildTextField(controller.aspirationCtrl, 'Aspiration'),
            _buildTextField(controller.qualitiesCtrl, 'Qualities'),
            _buildTextField(controller.scenarioCtrl, 'Scenario'),
            _buildTextField(controller.skillsCtrl, 'Skills'),
            const SizedBox(height: KSizes.defaultSpace),
            TextButton(
                style: const ButtonStyle().copyWith(
                  minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
                    backgroundColor: MaterialStateProperty.all(kApp4),
                    foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () => controller.saveOrUpdateStory(storyType),
                child: Text('Save Story',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold

                  ),)
            )
          ] else ...[
            Text("Character: ${story!.character}"),
            Text("Aspiration: ${story?.aspiration}"),
            Text("Qualities: ${story?.qualities}"),
            Text("Scenario: ${story?.scenario}"),
            Text("Skills: ${story?.skills}"),
          ]
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          // labelText: label,
          // labelStyle: Get.context!.textTheme.labelMedium,
          hintText: 'Your $label',
          hintStyle: Get.context!.textTheme.labelMedium,
        ),
      ),
    );
  }
}
