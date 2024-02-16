
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Rss%20Screen/article_screen.dart';
import 'package:knowyourself/screens/widgets/Placeholder.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 50.h),
            Text(
              'Learn More',
              style: TextStyle(
                fontSize: 30.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
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
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(
              height: 300.h,
              child: ArticleScreen(),
            ),
            SizedBox(height: 80.h),

          ],
        ),
      ),
    );
  }
}
