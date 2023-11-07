import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class JournalIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  const JournalIconButton(
      {super.key, required this.onPressed, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50.h,
      height: 50.h,
      child: RawMaterialButton(
        fillColor: kSecondaryColor,
        shape: const CircleBorder(),
        elevation: 0.0,
        onPressed: onPressed,
        child: Icon(
          iconData,
          size: 45.r,
          color: kPrimaryColor,
        ),
      ),
    );
  }
}
