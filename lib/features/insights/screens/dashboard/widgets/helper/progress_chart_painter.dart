import 'dart:ui' as ui;
import 'dart:math';
import 'package:flutter/material.dart';

import '../../../../../../utils/constants/colors.dart';

class ProgressPainter extends CustomPainter {

  final List <double> progress;

  ProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Draw the background circle with inner shadow
    final backgroundPaint = Paint()
      ..color =KColors.transparent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw complete circles for each progress bar with greyed-out remaining percentage
    drawProgressArc(canvas, center, radius - 0, KColors.kApp3, progress[0], true);
    drawProgressArc(canvas, center, radius - 20, KColors.kApp2,progress[1], true);
    drawProgressArc(canvas, center, radius - 40, KColors.kApp1, progress[2], true);
  }

  void drawProgressArc(Canvas canvas, Offset center, double radius, Color color, double percent, bool drawBackground) {
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percent;
    final backgroundSweepAngle = 8 * pi * (1 - percent);

    // Draw the background circle if needed
    if (drawBackground) {
      final backgroundPaint = Paint()
        ..color = KColors.kEmptyProgress
        ..style = PaintingStyle.stroke
        ..strokeWidth = 12
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        backgroundSweepAngle,
        false,
        backgroundPaint,
      );
    }
    // Create a Path that describes the inner shadow.
    // Path path = Path()
    //   ..addOval(Rect.fromCircle(center: center, radius: radius - 30));
    // canvas.drawShadow(path, KColors.grey, 3, false);

    // Draw the progress arc
    final progressPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx, center.dy - radius),
        Offset(center.dx, center.dy + radius),
        [color.withOpacity(0.5), color],
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}