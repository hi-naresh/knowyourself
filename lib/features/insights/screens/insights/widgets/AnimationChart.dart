import 'package:flutter/material.dart';

import '../../../model/core_values.dart';
import 'PieChart.dart';

class AnimatedPieChart extends StatefulWidget {
  final List<CoreValue> coreValues;
  final double strokeWidth;
  final Color strokeColor;

  const AnimatedPieChart({
    Key? key,
    required this.coreValues,
    this.strokeWidth = 4.0,
    this.strokeColor = Colors.transparent,
  }) : super(key: key);

  @override
  _AnimatedPieChartState createState() => _AnimatedPieChartState();
}

class _AnimatedPieChartState extends State<AnimatedPieChart> with TickerProviderStateMixin {
  late List<AnimationController> _controllers = [];
  late List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(widget.coreValues.length, (index) {
      return AnimationController(
        duration: const Duration(milliseconds: 500), // Making the animation quick
        vsync: this,
      );
    });

    _animations = List.generate(widget.coreValues.length, (index) {
      // First animate to 100% in the first half of the animation

      // Then animate back to the actual percentage in the second half
      var secondHalf = Tween<double>(begin: 100, end: widget.coreValues[index].percentage).animate(
        CurvedAnimation(parent: _controllers[index], curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
      );
      // Using a ProxyAnimation to link both animations
      return ProxyAnimation(secondHalf);
    });

    // Chain the animations so that each segment animates one after the other
    for (int i = 0; i < _controllers.length - 1; i++) {
      _controllers[i].addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controllers[i + 1].forward();
        }
      });
    }

    // Start the animation of the first segment
    if (_controllers.isNotEmpty) {
      _controllers.first.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(_controllers),
      builder: (context, child) {
        return PieChart(
          strokeWidth: widget.strokeWidth,
          strokeColor: widget.strokeColor,
          coreValues: List.generate(widget.coreValues.length, (index) {
            return CoreValue(
              name: widget.coreValues[index].name,
              percentage: _animations[index].value,
            );
          }),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
