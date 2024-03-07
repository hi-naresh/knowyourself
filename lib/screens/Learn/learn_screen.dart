
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Learn/widgets/progress_bar.dart';
import 'package:knowyourself/screens/Rss%20Screen/article_screen.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
import 'package:knowyourself/screens/widgets/my_card.dart';
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomHeader(title: "Learn"),
              // SizedBox(height: 20.h),
              Text(
                'Learn about aspects',
                style: customTitleBold(kDarkText, 16.sp, FontWeight.w600),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCard(
                      width: 130.h,
                      height: 100.h,
                      title: "Mental",
                      color: kApp1,
                      imageUrl: "assets/illustrations/mental.svg"),
                  MyCard(
                      width: 130.h,
                      height: 100.h,
                      title: "Physical",
                      color: kApp2,
                      imageUrl: "assets/illustrations/physical.svg"),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyCard(
                      width: 130.h,
                      height: 100.h,
                      title: "Emotional",
                      color: kApp3,
                      imageUrl: "assets/illustrations/emotional.svg"),
                  MyCard(
                      width: 130.h,
                      height: 100.h,
                      title: "Spiritual",
                      color: kApp4,
                      imageUrl: "assets/illustrations/spiritual.svg"),
                ],
              ),
              SizedBox(height: 20.h),
              Text(
                'Learned so far',
                style: customTitleBold(kDarkText, 16.sp, FontWeight.w600),
              ),
              SizedBox(height: 5.h),
              const LearningProgressBars(
                learningAspectsProgress: {
                  'Mental': 0.65, // 75%
                  'Physical': 0.5, // 50%
                  'Emotional': 0.7, // 90%
                  'Spiritual': 0.6, // 60%
                },
              ),
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
