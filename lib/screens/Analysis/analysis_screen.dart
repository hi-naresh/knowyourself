import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/AnimationChart.dart';

import '../../models/CoreValue.dart';
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
      //this is my space for questions
      // body:MultiProvider(
      //   providers: [
      //     ChangeNotifierProvider(create: (_) => QuestionsProvider()),
      //   ],
      //   child: MaterialApp(
      //     home: MySpaceScreen(),
      //   ),
      // ),
      backgroundColor: const Color(0xffefd6ff),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Text(
                  'Analysis',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20.h),
                //this is the core value widget that will be animated
                AnimatedPieChart(coreValues: coreValues,),
                SizedBox(height: 10.h),
                Text(
                  'Value Reflection',
                  style: TextStyle(
                    fontSize:16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 20.h),
                CustomPlaceHolder("4 Aspects of Life", 140.h, double.infinity),
                SizedBox(height: 20.h),
                CustomPlaceHolder("MileStone Achievement", 140.h, double.infinity),
                SizedBox(height: 20.h),
                CustomPlaceHolder("Consistency Record", 50.h, double.infinity),
                SizedBox(height: 20.h),
                CustomPlaceHolder("Activity Suggestion", 80.h, double.infinity),
                SizedBox(height: 80.h),
              ],
            )
        ),
      ),
    );
  }
}
