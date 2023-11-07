import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class CustomShape extends CustomPainter {
  final Color strokeColor;
  final Color fillColor;

  CustomShape({required this.strokeColor, required this.fillColor});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.003030303, size.height * 0.1483254);
    path_0.cubicTo(
        size.width * 0.003030303,
        size.height * 0.06905024,
        size.width * 0.04373182,
        size.height * 0.004784689,
        size.width * 0.09393939,
        size.height * 0.004784689);
    path_0.lineTo(size.width * 0.9060606, size.height * 0.004784689);
    path_0.cubicTo(
        size.width * 0.9562697,
        size.height * 0.004784689,
        size.width * 0.9969697,
        size.height * 0.06905024,
        size.width * 0.9969697,
        size.height * 0.1483254);
    path_0.lineTo(size.width * 0.9969697, size.height * 0.7942488);
    path_0.cubicTo(
        size.width * 0.9969697,
        size.height * 0.8686316,
        size.width * 0.9609848,
        size.height * 0.9306890,
        size.width * 0.9140606,
        size.height * 0.9372344);
    path_0.lineTo(size.width * 0.5063970, size.height * 0.9940957);
    path_0.cubicTo(
        size.width * 0.5010576,
        size.height * 0.9948421,
        size.width * 0.4956848,
        size.height * 0.9948373,
        size.width * 0.4903455,
        size.height * 0.9940861);
    path_0.lineTo(size.width * 0.08588727, size.height * 0.9373014);
    path_0.cubicTo(
        size.width * 0.03898515,
        size.height * 0.9307177,
        size.width * 0.003030303,
        size.height * 0.8686746,
        size.width * 0.003030303,
        size.height * 0.7943254);
    path_0.lineTo(size.width * 0.003030303, size.height * 0.1483254);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xffD9D9D9).withOpacity(0.08);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9060606, size.height * 0.002392344);
    path_1.lineTo(size.width * 0.09393939, size.height * 0.002392344);
    path_1.cubicTo(
        size.width * 0.04289485,
        size.height * 0.002392344,
        size.width * 0.001515152,
        size.height * 0.06772871,
        size.width * 0.001515152,
        size.height * 0.1483254);
    path_1.lineTo(size.width * 0.001515152, size.height * 0.7943254);
    path_1.cubicTo(
        size.width * 0.001515152,
        size.height * 0.8699139,
        size.width * 0.03806939,
        size.height * 0.9329904,
        size.width * 0.08575333,
        size.height * 0.9396842);
    path_1.lineTo(size.width * 0.4902121, size.height * 0.9964737);
    path_1.cubicTo(
        size.width * 0.4956394,
        size.height * 0.9972344,
        size.width * 0.5011000,
        size.height * 0.9972344,
        size.width * 0.5065303,
        size.height * 0.9964785);
    path_1.lineTo(size.width * 0.9141939, size.height * 0.9396172);
    path_1.cubicTo(
        size.width * 0.9619000,
        size.height * 0.9329617,
        size.width * 0.9984848,
        size.height * 0.8698708,
        size.width * 0.9984848,
        size.height * 0.7942488);
    path_1.lineTo(size.width * 0.9984848, size.height * 0.1483254);
    path_1.cubicTo(
        size.width * 0.9984848,
        size.height * 0.06772871,
        size.width * 0.9571061,
        size.height * 0.002392344,
        size.width * 0.9060606,
        size.height * 0.002392344);
    path_1.close();

    Paint paint_1_stroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    paint_1_stroke.color = strokeColor;
    canvas.drawPath(path_1, paint_1_stroke);

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = fillColor;
    canvas.drawPath(path_1, paint_1_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
