import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../common/widgets/custom_container.dart';
import '../../../../../utils/constants/colors.dart';
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
    return CustomContainer(
      color: kApp1Light,
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
              ProgressLabel(progress: '12%', label: 'Daily', color: kApp1),
              const SizedBox(height: KSizes.sm),
              ProgressLabel(progress: '68%', label: 'Monthly', color: kApp2),
              const SizedBox(height: KSizes.sm),
              ProgressLabel(progress: '46%', label: 'Yearly', color: kApp3),
            ],
          ),
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ProgressPainter(progress: _animations.map((e) => e.value).toList()),
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Center(
                      child: Text(
                        'G',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
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

  Widget ProgressLabel({required String progress, required String label, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: KSizes.xl,
          height: KSizes.xl,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child:Center(
            child: Text(
              progress,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )
            ),
          ),
        ),
        const SizedBox(width: KSizes.sm),
        Text(label),
      ],
    );
  }
}