import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/CustomContaincer.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ProgressComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: kPieBox,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '  Progress',
                style: h3Bold,
              ),
              SizedBox(height: 10.h),
              ProgressLabel(progress: '12%', label: 'Daily', color: kPie),
              SizedBox(height: 10.h),
              ProgressLabel(progress: '68%', label: 'Monthly', color: kPie1),
              SizedBox(height: 10.h),
              ProgressLabel(progress: '46%', label: 'Yearly', color: kPie2),
            ],
          ),
          CustomPaint(
            painter: ProgressPainter(),
            child: Container(
              width: 140.h,
              height: 140.h,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'G',
                      style: customTitleBold(kDarkText, 16, FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ProgressLabel({required String progress, required String label, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
          child:Center(
            child: Text(
              progress,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(label),
      ],
    );
  }
}

class ProgressPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Draw the background circle with inner shadow
    final backgroundPaint = Paint()
      ..color = Colors.transparent
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw complete circles for each progress bar with greyed-out remaining percentage
    drawProgressArc(canvas, center, radius - 10, kPie, 0.12, true);
    drawProgressArc(canvas, center, radius - 40, kPie1, 0.68, true);
    drawProgressArc(canvas, center, radius - 70, kPie2, 0.46, true);
  }

  void drawProgressArc(Canvas canvas, Offset center, double radius, Color color, double percent, bool drawBackground) {
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percent;
    final backgroundSweepAngle = 8 * pi * (1 - percent);

    // Draw the background circle if needed
    if (drawBackground) {
      final backgroundPaint = Paint()
        ..color = kPieBox1
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18.h
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
    // canvas.drawShadow(path, Colors.grey, 3, false);

    // Draw the progress arc
    final progressPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(center.dx, center.dy - radius),
        Offset(center.dx, center.dy + radius),
        [color.withOpacity(0.5), color],
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.h
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

