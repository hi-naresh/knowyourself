import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../common/widgets/custom_container.dart';
import '../../../../../utils/constants/colors.dart';


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
    drawProgressArc(canvas, center, radius - 0, kApp1, progress[0], true);
    drawProgressArc(canvas, center, radius - 30, kApp2,progress[1], true);
    drawProgressArc(canvas, center, radius - 55, kApp3, progress[2], true);
  }

  void drawProgressArc(Canvas canvas, Offset center, double radius, Color color, double percent, bool drawBackground) {
    const startAngle = -pi / 2;
    final sweepAngle = 2 * pi * percent;
    final backgroundSweepAngle = 8 * pi * (1 - percent);

    // Draw the background circle if needed
    if (drawBackground) {
      final backgroundPaint = Paint()
        ..color = kEmptyProgress
        ..style = PaintingStyle.stroke
        ..strokeWidth = 18
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
      ..strokeWidth = 20
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

