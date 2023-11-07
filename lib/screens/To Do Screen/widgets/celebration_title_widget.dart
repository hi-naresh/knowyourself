import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/To%20Do/celebration_model.dart';
import 'package:knowyourself/provider/ToDo/celebration_provider.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class CelebrateTitleWidget extends StatelessWidget {
  final CelebrationModel celebrationModel;
  const CelebrateTitleWidget({super.key, required this.celebrationModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<CelebrationProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return GestureDetector(
          onTap: () {
            value.updateCelebration(celebrationModel);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!(celebrationModel.title == value.celebrationModel.title))
                  Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9), shape: BoxShape.circle),
                  ),
                if ((celebrationModel.title == value.celebrationModel.title))
                  Container(
                    height: 20.h,
                    width: 20.w,
                    decoration: const BoxDecoration(
                        color: kTodoPrimaryColor, shape: BoxShape.circle),
                    child: Center(
                      child: Container(
                        height: 12.h,
                        width: 12.w,
                        decoration: const BoxDecoration(
                            color: Color(0xFFFFB47E), shape: BoxShape.circle),
                        child: Center(
                          child: Container(
                            height: 4.h,
                            width: 4.w,
                            decoration: const BoxDecoration(
                                color: Colors.white, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ),
                  ),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  celebrationModel.title,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
