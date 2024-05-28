import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../utils/helpers/shadow_disabler.dart';

class MyCard extends StatelessWidget {
  final String title;
  final Color color;
  final String? imageUrl;
  final double? width;
  final double? height;
  final double? left;
  final double? top;
  final double? right;
  final double? bottom;
  final double? fontSize;
  final double? opacity;
  final bool? isRight;
  final Function()? onTap;

  const MyCard({super.key,
    required this.title, required this.color, this.imageUrl,
    this.isRight=false,
    this.right, this.bottom,
    this.width, this.height, this.onTap, this.left, this.top,this.opacity =1.0,this.fontSize});

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
          borderRadius: BorderRadius.circular(KSizes.borderRadiusLgx),
          boxShadow: CustomShadow.getShadow([
            BoxShadow(
              color: color.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ]),        ),
        child: Stack(
          children: [
            if (imageUrl != null)
            Positioned(
              left: left?? width!/ 4,
              top: top?? height!/20,
              right: right,
              bottom: bottom,
              child: SvgPicture.asset(
                imageUrl!,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(opacity!),
                  BlendMode.modulate,
                ),
                width: width,
                height: height,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                title,
                textAlign: isRight! ? TextAlign.end : TextAlign.start,
                style: TextStyle(
                  // overflow: TextOverflow.ellipsis,
                  color: Colors.white,
                  fontSize: fontSize??18,
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
