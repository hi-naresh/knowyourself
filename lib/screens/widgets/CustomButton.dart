import 'package:flutter/cupertino.dart';
import 'dart:ui' as ui;

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.onTap}) : super(key: key);
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        size: Size(255, (130 * 0.5833333333333334).toDouble()),
        painter: RPSCustomPainter(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 22),
          child: Text(
            'Get Started',
            style: TextStyle(
              fontFamily: 'SF-Pro-Display',
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xffffffff),
            ),
          ),
        )
      ),

    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.2631579);
    path_0.cubicTo(0,size.height*0.1178199,size.width*0.03539253,0,size.width*0.07905138,0);
    path_0.lineTo(size.width*0.9209486,0);
    path_0.cubicTo(size.width*0.9646087,0,size.width,size.height*0.1178199,size.width,size.height*0.2631579);
    path_0.lineTo(size.width,size.height*0.6491211);
    path_0.cubicTo(size.width,size.height*0.7881697,size.width*0.9675059,size.height*0.9032224,size.width*0.9258142,size.height*0.9117803);
    path_0.lineTo(size.width*0.4960474,size.height);
    path_0.lineTo(size.width*0.07410870,size.height*0.9120066);
    path_0.cubicTo(size.width*0.03245075,size.height*0.9033197,0,size.height*0.7883132,0,size.height*0.6493632);
    path_0.lineTo(0,size.height*0.2631579);
    path_0.close();

    Paint paint_0_fill = Paint()..style=PaintingStyle.fill;
    paint_0_fill.shader = ui.Gradient.linear(Offset(size.width*-2.141486e-9,size.height*0.5520303), Offset(size.width*0.9994150,size.height*0.6357408), [Color(0xff9CA2E8).withOpacity(1),Color(0xff7CABEC).withOpacity(1)], [0.2375,1]);
    canvas.drawPath(path_0,paint_0_fill);

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}