import 'package:flutter/material.dart';
import 'package:knowyourself/features/insights/screens/insights/widgets/AnimationChart.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';
import '../../../learning/model/core_values/core_values.dart';
import '../../../learning/screens/learn_screen/progress_bar.dart';
import '../dashboard/widgets/progress_milestones.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Value Reflection',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: KSizes.defaultSpace),
                  Center(
                      child: AnimatedPieChart(coreValues: coreValues,)),
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
                  const SizedBox(height: KSizes.defaultSpace),
                  const ProgressComponent(
                    milestonesProgress: {
                      'Daily': 0.35,
                      'Monthly': 0.5,
                      'Yearly': 0.7,
                    },
                  ),
                  const SizedBox(height: KSizes.defaultSpace*6),
                  // CustomPlaceHolder("Consistency Record", 50.h, double.infinity),
                  // SizedBox(height: 20.h),
                  // CustomPlaceHolder("Activity Suggestion", 80.h, double.infinity),
                  // SizedBox(height: 80.h),
                ],
              ),
            )
        ),
      ),
    );
  }
}
