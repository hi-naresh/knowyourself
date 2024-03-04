import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class FullCircleSlider extends StatefulWidget {
  final double value;
  final Function(double) onChanged;
  final List<Widget> emojis;

  const FullCircleSlider({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.emojis,
  }) : super(key: key);

  @override
  _FullCircleSliderState createState() => _FullCircleSliderState();
}

class _FullCircleSliderState extends State<FullCircleSlider> {
  // Calculate the angle for the current value
  double angleForValue(double value) {
    return value * 2 * math.pi - (math.pi / 2);
  }

  // Update the value of the slider based on the touch position
  void _updateValue(Offset localPosition, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double angle = math.atan2(localPosition.dy - center.dy, localPosition.dx - center.dx) + (math.pi / 2);
    double newValue = angle / (2 * math.pi);
    if (newValue < 0) newValue += 1.0;
    if (newValue > 1) newValue -= 1.0;
    setState(() {
      widget.onChanged(newValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (details) {
        final RenderBox renderBox = context.findRenderObject() as RenderBox;
        final Offset localPosition = renderBox.globalToLocal(details.globalPosition);
        _updateValue(localPosition, renderBox.size);
      },
      child: CustomPaint(
        painter: CircleSliderPainter(value: widget.value, emojis: widget.emojis),
        size: Size(270.h, 270.h), // Define the size of the full circle here
      ),
    );
  }
}

class CircleSliderPainter extends CustomPainter {
  final double value;
  final List<Widget> emojis;

  CircleSliderPainter({required this.value, required this.emojis});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = kBoxLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final handlerPaint = Paint()
      ..color = kApp1
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw full circle
    canvas.drawCircle(center, radius, paint);

    // Calculate the angle for the current value
    final double angle = value * 2 * math.pi - (math.pi / 2);

    // Calculate the position of the handler
    final Offset handlerCenter = Offset(
      radius * math.cos(angle) + center.dx,
      radius * math.sin(angle) + center.dy,
    );

    // Draw the handler as a circle containing an emoji
    int emojiIndex = (value * (emojis.length - 1)).round();
    // This assumes that emojis are square, adjust if not
    final double emojiSize = 30.0; // Size of the emoji inside the handler
    final emojiPainter = emojis[emojiIndex];
    final emojiOffset = handlerCenter - Offset(emojiSize / 2, emojiSize / 2);
    // TODO: Embed the emoji widget into the canvas
    // You'll need to convert the emoji widget to an image and draw it on the canvas,
    // or use an alternative method to draw it.

    // Draw the handler circle
    canvas.drawCircle(handlerCenter, emojiSize/1.5, handlerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
