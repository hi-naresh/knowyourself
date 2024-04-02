import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/mood/controller/add_mood_controller.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../../../common/widgets/linear_percent_indicator.dart';
import '../../../../../../../utils/constants/colors.dart';

class ProgressBar extends StatefulWidget {
  final String steps;
  final double percent;

  const ProgressBar({super.key, required this.steps, required this.percent});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    final controller = AddMoodController.instance;
    return Padding(
      padding: const EdgeInsets.only(top: KSizes.defaultSpace),
      child: LinearPercentIndicator(
        alignment: MainAxisAlignment.spaceBetween,
        leading: GestureDetector(
          onTap: () =>controller.previousPage(),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: KSizes.iconMd,
          ),
        ),
        barRadius: const Radius.circular(KSizes.borderRadiusLg),
        lineHeight: KSizes.sm,
        width: 200,
        percent: widget.percent,
        backgroundColor: kBoxLight,
        progressColor: kApp1,
        trailing: Text(
          widget.steps,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
    );
  }
}
