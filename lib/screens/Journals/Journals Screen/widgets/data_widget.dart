import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgDataWidget extends StatelessWidget {
  final SvgPicture svgPicture;

  final int value;
  final String title;
  const SvgDataWidget(
      {super.key,
      required this.svgPicture,
      required this.value,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          svgPicture,
          SizedBox(
            width: 5.w,
          ),
          Text(
            value.toString(),
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 5.w,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
