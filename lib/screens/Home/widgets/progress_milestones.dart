import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/CustomContaincer.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ProgressComponent extends StatefulWidget {
  final Map<String, double> milestonesProgress;
  final List<Color> colors;

  const ProgressComponent({
    Key? key,
    required this.milestonesProgress,
    this.colors = const [kApp1, kApp2, kApp3],
  }) : super(key: key);

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
      duration: const Duration(seconds: 1), // The duration of the animation
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
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: ProgressPainter(progress: _animations.map((e) => e.value).toList()),
                  child: SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: Center(
                      child: Text(
                        'G',
                        style: h3Bold,
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

  final List <double> progress;

  ProgressPainter({required this.progress});

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
    drawProgressArc(canvas, center, radius - 0, kPie, progress[0], true);
    drawProgressArc(canvas, center, radius - 30, kPie1,progress[1], true);
    drawProgressArc(canvas, center, radius - 60, kPie2, progress[2], true);
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

