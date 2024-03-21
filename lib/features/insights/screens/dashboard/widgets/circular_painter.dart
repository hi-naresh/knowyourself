import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
class ToDoPainter extends CustomPainter {
  final int completedTasks;
  final int totalTasks;
  final double radius;
  final double strokeWidth;

  ToDoPainter(
      {required this.strokeWidth,
      required this.radius,
      required this.completedTasks,
      required this.totalTasks});

  @override
  void paint(Canvas canvas, Size size) {
    const double pi = 3.14;
    final double percent =
        (totalTasks != 0) ? (completedTasks / totalTasks) * 2 * pi : 0;

    Paint paint = Paint();

    paint.color = kProgress;
    paint.strokeCap = StrokeCap.round;
    paint.style = PaintingStyle.stroke;
    //inner shadow
    // paint.maskFilter = const MaskFilter.blur(BlurStyle.inner, 0.5);
    paint.strokeWidth = strokeWidth;
    Offset radialPosition = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(radialPosition, radius, paint);

    Paint radialProgress = Paint();
    radialProgress.color = kApp4Dark;
    radialProgress.strokeCap = StrokeCap.round;
    radialProgress.style = PaintingStyle.stroke;
    radialProgress.strokeWidth = strokeWidth;

    Offset arcPosition = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(Rect.fromCircle(center: arcPosition, radius: radius),
        -pi / 2, percent, false, radialProgress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
