import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../common/widgets/custom_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../mySpace/milestones/controller/milestone_controller.dart';
import '../../dashboard/widgets/helper/progress_chart_painter.dart';


class ProgressComponent extends StatefulWidget {
  final Map<String, double> milestonesProgress;
  final List<Color> colors;

  const ProgressComponent({
    super.key,
    required this.milestonesProgress,
    this.colors = const [kApp1, kApp2, kApp3],
  });

  @override
  State<ProgressComponent> createState() => _ProgressComponentState();
}

class _ProgressComponentState extends State<ProgressComponent> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000), // The duration of the animation
    );

    _animations = widget.milestonesProgress.keys.map((key) {
      return Tween<double>(begin: 0, end: widget.milestonesProgress[key]!).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
      );
    }).toList();

    // Start the animation when the widget is inserted into the tree
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final milesController = MilestoneController.instance;
    return CustomContainer(
      color: kApp1Light,
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.lg),
              ProgressLabel(label: '${milesController.getTotalTasksCount(Period.daily)} Tasks daily', color: kApp3),
              const SizedBox(height: KSizes.sm),
              ProgressLabel( label: '${milesController.getTotalTasksCount(Period.weekly)} Tasks weekly', color: kApp2),
              const SizedBox(height: KSizes.sm),
              ProgressLabel(label: '${milesController.getTotalTasksCount(Period.monthly)} Tasks monthly', color: kApp1),
            ],
          ),
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ProgressPainter(progress: _animations.map((e) => e.value).toList()),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Center(
                      child: Text(
                        'G',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        )
                      ),
                    )
                  ),
                );
              }
          )
        ],
      ),
    );
  }

  Widget ProgressLabel({ required String label, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: KSizes.md,
          height: KSizes.md,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: KSizes.sm),
        Text(label),
      ],
    );
  }
}