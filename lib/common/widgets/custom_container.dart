import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  final double width;
  // final double height;
  final Color color;
  final BorderRadius borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<BoxShadow> boxShadow;
  final Alignment alignment;
  final Function()? onTap;

  const CustomContainer({super.key,
    required this.child,
    this.width = double.infinity,
    // this.height = double.maxFinite,
    this.color = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(25)),
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.boxShadow = const [

    ],
    this.alignment = Alignment.center,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        // height: height,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(
            color: color,
            width: 1,
          ),
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.7),
              offset: const Offset(0, 5),
              blurRadius: 15,
            )
          ],
        ),
        padding: padding,
        margin: margin,
        alignment: alignment,
        child: child,
      ),
    );
  }
}