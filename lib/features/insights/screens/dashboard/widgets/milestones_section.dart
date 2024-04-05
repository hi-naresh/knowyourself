import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knowyourself/features/master.dart';
import 'package:knowyourself/features/mySpace/space_screen.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../../../../../common/widgets/custom_container.dart';
import 'circular_painter.dart';

class DailyMilestoneSection extends StatelessWidget {
  const DailyMilestoneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      color: kApp4Light,
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
                  // colorFilter: const ColorFilter.mode(
                  //   Colors.white70,
                  //   BlendMode.modulate,
                  // ),
                  KImages.health5,
                  height: KSizes.xxl*2.4,
                  fit: BoxFit.contain,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Tasks: 2/",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        // color: KColors.dark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "6",
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
              // completedTasks: (value.toDolist.length -
              //     value.getUncompletedTasksCount()),
              // totalTasks: value.toDolist.length,
              //demo
              completedTasks: 2,
              totalTasks: 5,
              radius: KSizes.xl,
              strokeWidth: KSizes.md/1,
            ),
            child: SizedBox(
              height: 80,
              width: 80,
              child: Center(
                child: Text(
                  //demo
                  "45%",
                  // "${value.toDolist.isNotEmpty ? ((value.toDolist.length - value.getUncompletedTasksCount()) * 100 / value.toDolist.length).toStringAsFixed(1) : 0} %",
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
