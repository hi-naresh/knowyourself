import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import '../../widgets/global_styles.dart';

class LearningProgressBars extends StatefulWidget {
  final Map<String, double> learningAspectsProgress;
  final List<Color> colors;

  const LearningProgressBars({
    Key? key,
    required this.learningAspectsProgress,
    this.colors = const [kApp1, kApp2, kApp3, kApp4],
  }) : super(key: key);

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
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Stack(
              children: [
                Container(
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                      width: MediaQuery.of(context).size.width * _animations[index].value,
                      decoration: Styles.containerDecoration(widget.colors[index]),
                      child: Text(
                        entry.key,
                        style: customTitleBold(kWhite, 12.sp, FontWeight.w600),
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      '${(_animations[index].value * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(color: Colors.white),
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