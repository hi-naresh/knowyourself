import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/shape_paths.dart';
import 'package:knowyourself/utils/constants/colors.dart';

class ShapePainterForces extends CustomPainter {
  final int currentShapeIndex;
  final Animation<double> scaleAnimation;
  final List<String> labels;

  ShapePainterForces({
    required this.currentShapeIndex,
    required this.scaleAnimation,
    required this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 320;
    final double scaleY = size.height / 320;

    final Matrix4 scaleMatrix = Matrix4.identity()
      ..scale(scaleX, scaleY);

    Path path0 = ShapePaths.createPath0().transform(scaleMatrix.storage);
    Path path1 = ShapePaths.createPath1().transform(scaleMatrix.storage);
    Path path2 = ShapePaths.createPath2().transform(scaleMatrix.storage);
    Path path3 = ShapePaths.createPath3().transform(scaleMatrix.storage);

    List<Path> paths = [path0, path1, path2, path3];
    List<Color> colors = [
      KColors.kApp1,
      KColors.kApp2,
      KColors.kApp3,
      KColors.kApp4,
    ];

    for (int i = 0; i < paths.length; i++) {
      Paint paint = Paint()..style = PaintingStyle.fill;
      paint.color = colors[i];

      // Only scale the currently active shape
      if (i == currentShapeIndex) {
        canvas.save();

        // Translate canvas to the center of the shape and apply scaling
        Rect bounds = paths[i].getBounds();
        Offset center = bounds.center;

        // Move canvas to the center of the shape
        canvas.translate(center.dx, center.dy);

        // Scale the canvas
        canvas.scale(scaleAnimation.value);

        // Move canvas back after scaling
        canvas.translate(-center.dx, -center.dy);
      }

      // Draw the shape
      canvas.drawPath(paths[i], paint);

      if (i == currentShapeIndex) {
        canvas.restore(); // Restore canvas after scaling
      }

      // Draw centered text inside the shape
      _drawTextInsideShape(canvas, paths[i], labels[i]);
    }
  }

  // Method to draw centered text inside the shape
  void _drawTextInsideShape(Canvas canvas, Path path, String text) {
    // Calculate the bounding box of the path
    Rect bounds = path.getBounds();

    // Set up the text style
    TextSpan textSpan = TextSpan(
      text: text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );

    // Prepare text painter
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    // Find the center of the shape's bounding box
    Offset center = bounds.center;

    // Draw the text centered inside the bounding box of the shape
    textPainter.paint(
      canvas,
      Offset(
        center.dx - (textPainter.width / 2),
        center.dy - (textPainter.height / 2),
      ),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
