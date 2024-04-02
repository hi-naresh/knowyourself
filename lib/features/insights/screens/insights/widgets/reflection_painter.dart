import 'dart:math';
import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../model/core_values.dart';
class ReflectionPainter extends CustomPainter {
  final double strokeWidth;
  final Color strokeColor;
  final List<CoreValue> coreValues;

  ReflectionPainter({
    required this.strokeWidth,
    required this.strokeColor,
    required this.coreValues,
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
      // final radius = coreValue.percentage > 0 ? maxRadius * (coreValue.percentage / 100) : 0.1;
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
        ..color = KHelper.isDark() ? KColors.scaffoldDark : KColors.scaffoldLight
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

