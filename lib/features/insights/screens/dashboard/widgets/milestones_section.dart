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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                top: KSizes.lg,
                child: SvgPicture.asset(
                  KImages.health5,
                  height: 130,
                  fit: BoxFit.contain,
                ),
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      //demo
                        text: "Tasks: 5/",
                        // text: (value.toDolist.length - value.getUncompletedTasksCount()).toString(),
                        style: Theme.of(context).textTheme.labelSmall
                    ),
                    TextSpan(
                      //demo
                        text: "2",
                        // text: '/${value.toDolist.length} task completed',
                        style: Theme.of(context).textTheme.labelSmall
                    ),
                    TextSpan(
                      text: "\n${KTexts.dailyMilestones}",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //value
              CustomPaint(
                painter: ToDoPainter(
                  // completedTasks: (value.toDolist.length -
                  //     value.getUncompletedTasksCount()),
                  // totalTasks: value.toDolist.length,
                  //demo
                  completedTasks: 2,
                  totalTasks: 5,
                  radius: KSizes.xl,
                  strokeWidth: KSizes.md/1.5,
                ),
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: Center(
                    child: Text(
                      //demo
                      "45%",
                      // "${value.toDolist.isNotEmpty ? ((value.toDolist.length - value.getUncompletedTasksCount()) * 100 / value.toDolist.length).toStringAsFixed(1) : 0} %",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: KSizes.sm,
              ),
              ElevatedButton(
                  onPressed: (){
                    final controller = MySpaceController.instance;
                    final masterController = MasterController.instance;
                    masterController.currentIndex.value = 3;
                    controller.updateTabIndex(1);
                  },
                style: const ButtonStyle().copyWith(
                  foregroundColor: MaterialStateProperty.all(Colors.black),
                ),
                  child: const Text("Start"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
