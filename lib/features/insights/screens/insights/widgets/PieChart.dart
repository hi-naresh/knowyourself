import 'dart:math';
import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../model/core_values.dart';

class PieChart extends StatelessWidget {
  final double strokeWidth;
  final Color strokeColor;
  final List<CoreValue> coreValues;

  const PieChart({
    super.key,
    this.strokeWidth = 4.0,
    this.strokeColor = Colors.transparent,
    required this.coreValues, // Update to coreValues
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300), // You can adjust the size as needed
      painter: PieChartPainter(
        strokeWidth: strokeWidth,
        strokeColor: strokeColor,
        coreValues: coreValues, // Update to coreValues
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  final List<CoreValue> coreValues; // Now expects a list of CoreValue

  PieChartPainter({
    required this.strokeWidth,
    required this.strokeColor,
    required this.coreValues, // Update to coreValues
  });

  List<Color> coreValueColors = [
    valueProgress,
    valueReceptivity,
    valueAspiration,
    valuePerseverance,
    valueGratitude,
    valueHumility,
    valueSincerity,
    valuePeace,
    valueEquanimity,
    valueGenerosity,
    valueGoodness,
    valueCourage,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2 - strokeWidth / 2;
    final total = coreValues.length;
    final double arcWidth = 2 * pi / total;

    for (int i = 0; i < total; i++) {
      final startAngle = arcWidth * i - pi / 2;
      final radius = maxRadius * (1); // Scale radius by percentage

      // Create a path for each segment
      Path path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );
      path.arcToPoint(
        Offset(
          center.dx + radius * cos(startAngle + arcWidth),
          center.dy + radius * sin(startAngle + arcWidth),
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );
      path.lineTo(center.dx, center.dy);

      final paint = Paint()
        ..color = KHelper.isDark() ? kEmptyProgressDark : kEmptyProgress
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);

      // Stroke for the path
      final strokePaint = Paint()
        ..color = KHelper.isDark() ? KColors.scaffoldDark : KColors.scaffoldLight // Transparent stroke
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth/2;
      canvas.drawPath(path, strokePaint);
    }

    for (int i = 0; i < total; i++) {
      final CoreValue coreValue = coreValues[i];
      final startAngle = arcWidth * i - pi / 2;
      final radius = maxRadius * (coreValue.percentage / 100); // Scale radius by percentage

      // Create a path for each segment
      Path path = Path();
      path.moveTo(center.dx, center.dy);
      path.lineTo(
        center.dx + radius * cos(startAngle),
        center.dy + radius * sin(startAngle),
      );
      path.arcToPoint(
        Offset(
          center.dx + radius * cos(startAngle + arcWidth),
          center.dy + radius * sin(startAngle + arcWidth),
        ),
        radius: Radius.circular(radius),
        clockwise: true,
      );

      final paint = Paint()
        ..color = coreValueColors[i] // Update to coreValueColors
        ..style = PaintingStyle.fill;
      canvas.drawPath(path, paint);

      // Stroke for the path - internal border
      final strokePaint = Paint()
        ..color = KColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth/3;
      canvas.drawPath(path, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

