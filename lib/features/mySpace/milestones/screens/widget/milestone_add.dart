import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/milestones/controller/milestone_controller.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class MilestoneAdd extends StatelessWidget {
  const MilestoneAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MilestoneController>();
    return Container(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      height: Get.height * 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: '${KTexts.add} ',
                    style: Theme.of(context).textTheme.headlineMedium),
                TextSpan(
                  text: KTexts.milestones.capitalizeFirst,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: kApp4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          TextField(
            controller: controller.titleController,
            decoration: InputDecoration(
              // labelText: 'Title',
              hintText: KTexts.hintText,
              hintStyle: Theme.of(context).textTheme.labelMedium
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          TextField(
            controller: controller.descriptionController,
            decoration: InputDecoration(
                hintText: KTexts.hintText2,
                hintStyle: Theme.of(context).textTheme.labelMedium

            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          Text( KTexts.reminderText,
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: KSizes.sm),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() => Wrap(
              spacing: 8,
              children: Period.values
                  .map((period) => ChoiceChip(
                backgroundColor: KHelper.isDark()
                    ? kEmptyProgressDark
                    : kEmptyProgress,
                selectedColor: kApp4,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(
                    color: kApp4,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(5),
                disabledColor: kEmptyProgress,
                label: Text(period.name.capitalizeFirst!),
                selected: controller.milestonePeriod.value == period,
                onSelected: (selected) {
                  if (selected) {
                    controller.milestonePeriod.value = period;
                  }
                },
              ))
                  .toList(),
            )),
          ),
          const Spacer(),
          TextButton(
              style: const ButtonStyle().copyWith(
                  minimumSize: MaterialStateProperty.all(
                      const Size(double.infinity, 50)),
                  backgroundColor: MaterialStateProperty.all(kApp4),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: ()=>controller.addMilestone(),
              child: Text(
                '${KTexts.add} ${KTexts.milestones3}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}
