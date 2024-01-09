import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/widgets/AnimationChart.dart';

import '../../models/CoreValue.dart';

class PlaneScreen extends StatelessWidget {
  const PlaneScreen({super.key});

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Value Reflection',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 20.h),
            //this is the core value widget that will be animated
            AnimatedPieChart(coreValues: coreValues,),
          ],
        )
      ),
    );
  }
}
