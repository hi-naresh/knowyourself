import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCard extends StatelessWidget {
  final String title;
  final Color color;
  final String imageUrl;
  final double? width;
  final double? height;
  final double? left;
  final double? top;
  final Function()? onTap;
  const MyCard({super.key,
    required this.title, required this.color, required this.imageUrl,
    this.width, this.height, this.onTap, this.left, this.top});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color, color.withOpacity(0.5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: left?? width!/ 4,
              top: top?? height!/20,
              child: Opacity(
                opacity: 1,
                // child: Image.asset(
                //   imageUrl,
                //   width: width,
                //   height: height,
                //   fit: BoxFit.contain,
                // ),
                child: SvgPicture.asset(
                  imageUrl,
                  width: width,
                  height: height,
                  fit: BoxFit.contain,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
