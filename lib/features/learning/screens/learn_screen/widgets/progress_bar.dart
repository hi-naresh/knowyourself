import 'package:flutter/material.dart';
import 'package:knowyourself/common/styles/styles.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';

class LearningProgressBars extends StatefulWidget {
  final Map<String, double> learningAspectsProgress;
  final List<Color> colors;

  const LearningProgressBars({
    super.key,
    required this.learningAspectsProgress,
    this.colors = const [KColors.kApp1, KColors.kApp2, KColors.kApp3, KColors.kApp4],
  });

  @override
  _LearningProgressBarsState createState() => _LearningProgressBarsState();
}

class _LearningProgressBarsState extends State<LearningProgressBars> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // The duration of the animation
    );

    _animations = widget.learningAspectsProgress.keys.map((key) {
      return Tween<double>(begin: 0, end: widget.learningAspectsProgress[key]!).animate(
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: widget.learningAspectsProgress.entries.map((entry) {
        int index = widget.learningAspectsProgress.keys.toList().indexOf(entry.key);
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) => Padding(
            padding: const EdgeInsets.symmetric(vertical: KSizes.sm),
            child: Stack(
              children: [
                Container(
                  height: KSizes.xl,
                  decoration: BoxDecoration(
                    color: KHelper.isDark() ? KColors.kEmptyProgressDark : KColors.kEmptyProgress,
                    borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: KSizes.md, vertical: KSizes.xs+2),
                      width: MediaQuery.of(context).size.width * _animations[index].value,
                      decoration: KStyles.containerDecoration(widget.colors[index]),
                      child: Text(
                        entry.key,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KColors.scaffoldLight,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${(_animations[index].value * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: KColors.scaffoldLight,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}