import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/AnimationChart.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';

import '../../models/CoreValue.dart';
import '../../utils/ui_colors.dart';
import '../Home/widgets/progress_milestones.dart';
import '../Learn/widgets/progress_bar.dart';
import '../widgets/CustomTitles.dart';
import '../widgets/Placeholder.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeader(title: "Analysis"),
                  Text(
                    'Learned so far',
                    style: customTitleBold(kDarkText, 16.sp, FontWeight.w600),
                  ),
                  const LearningProgressBars(
                    learningAspectsProgress: {
                      'Mental': 0.65, // 75%
                      'Physical': 0.5, // 50%
                      'Emotional': 0.7, // 90%
                      'Spiritual': 0.6, // 60%
                    },
                  ),
                  const ProgressComponent(
                    milestonesProgress: {
                      'Daily': 0.35,
                      'Monthly': 0.5,
                      'Yearly': 0.7,
                    },
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Value Reflection',
                    style: customTitleBold(kDarkText, 16.sp, FontWeight.w600),
                  ),
                  SizedBox(height: 10.h),
                  Center(child: AnimatedPieChart(coreValues: coreValues,)),
                  SizedBox(height: 20.h),

                  SizedBox(height: 20.h),
                  CustomPlaceHolder("Consistency Record", 50.h, double.infinity),
                  SizedBox(height: 20.h),
                  CustomPlaceHolder("Activity Suggestion", 80.h, double.infinity),
                  SizedBox(height: 80.h),
                ],
              ),
            )
        ),
      ),
    );
  }
}
