import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/custom_container.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
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
              Text(storyType == StoryType.current ? KTexts.story2 : KTexts.hero,
                  style: Theme.of(context).textTheme.headlineSmall),
              const Spacer(),
              TextButton(
                  style: const ButtonStyle().copyWith(
                      backgroundColor: WidgetStateProperty.all(kApp4),
                      foregroundColor: WidgetStateProperty.all(Colors.white)
                  ),
                  onPressed: () => controller.updateStory(storyType),
                  child: const Text(KTexts.update,)),
              const SizedBox(width: KSizes.sm),
              TextButton(
                  style: const ButtonStyle().copyWith(
                      backgroundColor: WidgetStateProperty.all(kApp4),
                      foregroundColor: WidgetStateProperty.all(Colors.white)
                  ),
                  onPressed: () => controller.deleteStory( storyType),
                  child: const Text(KTexts.delete,))

            ],
          ),
          const SizedBox(height: KSizes.sm),
          Text(storyType == StoryType.current ?
          KTexts.describeOngoingLifeStory : KTexts.imagineNarratingOnTedXStage,
              style: Theme.of(context).textTheme.labelMedium),

          const SizedBox(height: KSizes.defaultSpace),
          if (isEditing) ...[
            _buildTextField(controller.characterCtrl, KTexts.character),
            _buildTextField(controller.aspirationCtrl, KTexts.aspiration),
            _buildTextField(controller.qualitiesCtrl, KTexts.qualities),
            _buildTextField(controller.scenarioCtrl, KTexts.scenario),
            _buildTextField(controller.skillsCtrl, KTexts.skills),
            const SizedBox(height: KSizes.defaultSpace),
            TextButton(
                style: const ButtonStyle().copyWith(
                  minimumSize: WidgetStateProperty.all(const Size(double.infinity, 50)),
                    backgroundColor: WidgetStateProperty.all(kApp4),
                    foregroundColor: WidgetStateProperty.all(Colors.white)
                ),
                onPressed: () => controller.saveOrUpdateStory(storyType),
                child: Text('${KTexts.save} ${KTexts.story}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold

                  ),)
            )
          ] else ...[
            Text("${KTexts.character}: ${story!.character}"),
            Text("${KTexts.aspiration}: ${story?.aspiration}"),
            Text("${KTexts.qualities}: ${story?.qualities}"),
            Text("${KTexts.scenario}: ${story?.scenario}"),
            Text("${KTexts.skills}: ${story?.skills}"),
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
          hintText: '${KTexts.your} $label',
          hintStyle: Get.context!.textTheme.labelMedium,
        ),
      ),
    );
  }
}
