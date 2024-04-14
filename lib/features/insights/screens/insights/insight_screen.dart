import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/insights/screens/insights/widgets/reflection_chart.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../learning/screens/learn_screen/widgets/progress_bar.dart';
import '../../../mySpace/milestones/controller/milestone_controller.dart';
import '../../controller/insights_controller.dart';
import 'widgets/progress_milestones.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  Widget coreValueWidget(BuildContext context, String name, double percentage) {
    return Padding(
      padding: const EdgeInsets.all(KSizes.sm),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name.capitalize!,
              style: Theme.of(context).textTheme.titleMedium),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: valueColors[CoreValues.values
                  .firstWhere((e) => e.toString().split('.').last == name)],
            ),
            child: Center(
              child: Text(
                '${percentage.toInt()}%',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InsightsController());
    final milesController = MilestoneController.instance;
    return SingleChildScrollView(
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProgressComponent(
              milestonesProgress: {
                'Daily': milesController.getCompletedTasksCount(Period.daily)/milesController.getTotalTasksCount(Period.daily),
                'Weekly': milesController.getCompletedTasksCount(Period.weekly)/milesController.getTotalTasksCount(Period.weekly),
                'Monthly': milesController.getCompletedTasksCount(Period.monthly)/milesController.getTotalTasksCount(Period.monthly),
              },
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Text(
              'Weekly Value Reflection',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: KSizes.spaceBtwItems),
            Text(
              "Start Writing your reflections and get your value insights...",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            const Center(
              child: ReflectionChart()
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Obx(
              () => Column(
                children: controller.analyzedCoreValues
                    .map((e) => coreValueWidget(
                        context, e.name, e.percentage.toPrecision(2)))
                    .toList(),
              ),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Text(
              KTexts.learnHead2,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            const LearningProgressBars(
              learningAspectsProgress: {
                'Mental': 0.65, // 75%
                'Physical': 0.5, // 50%
                'Emotional': 0.7, // 90%
                'Spiritual': 0.6, // 60%
              },
            ),
            const SizedBox(height: KSizes.defaultSpace * 6),
            // CustomPlaceHolder("Consistency Record", 50.h, double.infinity),
            // SizedBox(height: 20.h),
            // CustomPlaceHolder("Activity Suggestion", 80.h, double.infinity),
            // SizedBox(height: 80.h),
          ],
        ),
      )),
    );
  }
}
