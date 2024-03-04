
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Rss%20Screen/article_screen.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              CustomHeader(title: "Learn"),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomPlaceHolder("Mental", 80, 140),
                  CustomPlaceHolder("Emotional", 80, 140),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomPlaceHolder("Physical", 80, 140),
                  CustomPlaceHolder("Spiritual", 80, 140),
                ],
              ),
              SizedBox(height: 20.h),
              CustomPlaceHolder("Learned So far", 60.h, double.infinity),
              SizedBox(height: 20.h),
              Text(
                'Articles',
                style: customTitleBold(kDarkText, 26, FontWeight.w700),
              ),
              SizedBox(
                height: 300.h,
                child: ArticleScreen(),
              ),
              SizedBox(height: 80.h),

            ],
          ),
        ),
      ),
    );
  }
}
