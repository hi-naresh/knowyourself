import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/milestones/screens/widget/milestones_list_view.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

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
                  color: KColors.kApp4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Text(
          KTexts.milestoneSubtitle,
          style: Theme.of(context).textTheme.bodySmall,
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