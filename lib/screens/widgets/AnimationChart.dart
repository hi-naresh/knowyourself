import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/CoreValue.dart';
import 'PieChart.dart';

class AnimatedPieChart extends StatefulWidget {
  final List<CoreValue> coreValues;
  final double strokeWidth;
  final Color strokeColor;

  AnimatedPieChart({
    Key? key,
    required this.coreValues,
    this.strokeWidth = 2.0,
    this.strokeColor = Colors.white,
  }) : super(key: key);

  @override
  _AnimatedPieChartState createState() => _AnimatedPieChartState();
}

class _AnimatedPieChartState extends State<AnimatedPieChart> with TickerProviderStateMixin {
  List<AnimationController> _controllers = []; // Initialize as an empty list
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.coreValues.length; i++) {
      var controller = AnimationController(
        duration: const Duration(milliseconds: 200), // Duration of each segment's animation
        vsync: this,
      );
      _controllers.add(controller);

      var animation = Tween<double>(begin: 0, end: widget.coreValues[i].percentage).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut),
      );
      _animations.add(animation);

      if (i > 0) {
        // Chain the animation so it starts after the previous segment's animation
        _controllers[i - 1].addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            controller.forward();
          }
        });
      }
    }

    // Start the first animation
    if (_controllers.isNotEmpty) {
      _controllers.first.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(_controllers), // Merge all controllers for the AnimatedBuilder
      builder: (context, child) {
        // Create a temporary list of core values with animated percentages
        List<CoreValue> animatedCoreValues = List<CoreValue>.generate(widget.coreValues.length, (index) {
          return CoreValue(
            name: widget.coreValues[index].name,
            percentage: _animations[index].value,
            color: widget.coreValues[index].color,
          );
        });

        return PieChart(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.strokeColor,
          coreValues: animatedCoreValues, // Pass the animated core values
        );
      },
    );
  }
}
