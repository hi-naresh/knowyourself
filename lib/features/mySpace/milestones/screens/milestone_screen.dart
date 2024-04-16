import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/milestones/screens/widget/milestones_list_view.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class MilestoneScreen extends StatelessWidget {
  const MilestoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      // physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      children:  [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: '${KTexts.my} ',
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
        const MilestoneProgressList(period: Period.daily),
        const SizedBox(height: KSizes.defaultSpace),

        const MilestoneProgressList(period: Period.weekly),
        const SizedBox(height: KSizes.defaultSpace),

        const MilestoneProgressList(period: Period.monthly),
        const SizedBox(height: KSizes.defaultSpace*5),
      ],
    );
  }
}