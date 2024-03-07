import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/screens/widgets/CustomContaincer.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class RecommendWidget extends StatelessWidget {
  const RecommendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomContainer(
      color: kPieBox1,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommended activities",
                style: h3Bold,
              ),
              Text(
                "Start your day with some motivation.",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF5A4B5C),
                ),
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.slow_motion_video_outlined,
            size: 30,
            color: kDarkText,
          ),
        ],
      ),
    );
  }
}
