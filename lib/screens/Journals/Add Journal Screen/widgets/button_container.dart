import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ButtonContainer extends StatelessWidget {
  final String label;
  const ButtonContainer({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            color: kPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
