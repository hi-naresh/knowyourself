import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JournalEntryTextWidget extends StatelessWidget {
  const JournalEntryTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 120.h,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/gradients/gradient.png"),
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(0, 4),
                      blurRadius: 59)
                ],
                // gradient: const LinearGradient(
                //   colors: [
                //     Color(0xFFFFFFFF),
                //     Color(0xFF695FFF),
                //   ],
                // ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Start creating your entries",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white, size: 30.r)
                ],
              ),
            ),
            Positioned(
              top: -20,
              left: 80.w,
              child: Opacity(
                opacity: 0.4,
                child: Transform.rotate(
                  angle: 3.14 / 20,
                  child: SvgPicture.asset(
                    "assets/emojis/happy.svg",
                    height: 60.h,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -20,
              right: 80.w,
              child: Opacity(
                opacity: 0.4,
                child: Transform.rotate(
                  angle: 3.14 / 20,
                  child: SvgPicture.asset(
                    "assets/emojis/joyfull.svg",
                    height: 60.h,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
