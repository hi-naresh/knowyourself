import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/master.dart';
import 'package:knowyourself/features/mySpace/milestones/controller/milestone_controller.dart';
import 'package:knowyourself/features/mySpace/space_screen.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../../../../../common/widgets/custom_container.dart';
import '../../../../../utils/constants/enums.dart';
import 'circular_painter.dart';

class DailyMilestoneSection extends StatelessWidget {
  const DailyMilestoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    final milesController = MilestoneController.instance;
    return CustomContainer(
      width: double.infinity,
      color: KColors.kApp4Light,
      onTap: () {
        final controller = MySpaceController.instance;
        final masterController = MasterController.instance;
        masterController.currentIndex.value = 3;
        controller.updateTabIndex(1);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                left: 0,
                child: SvgPicture.asset(
                  colorFilter: const ColorFilter.mode(
                    KColors.white70,
                    BlendMode.modulate,
                  ),
                  KImages.health5,
                  height: KSizes.xxl*2.4,
                  fit: BoxFit.contain,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${KTexts.tasks}: ${milesController.getCompletedTasksCount(Period.daily)}/',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        // color: KColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "${milesController.getTotalTasksCount(Period.daily)}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        // color: KColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: "\n${KTexts.dailyMilestones}",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: KSizes.lg,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomPaint(
            painter: ToDoPainter(
              completedTasks: milesController.getCompletedTasksCount(Period.daily),
              totalTasks: milesController.getTotalTasksCount(Period.daily),
              radius: KSizes.xl*1.2,
              strokeWidth: KSizes.md/1.5,
            ),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Center(
                child: Text(
                  "${milesController.getProgress(Period.daily).toPrecision(2) * 100}%",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
