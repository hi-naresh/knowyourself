import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/widgets/CustomTitles.dart';
import 'package:knowyourself/utils/ui_colors.dart';

import 'package:provider/provider.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/provider/User/points_provider.dart';
import 'package:knowyourself/screens/Extras/Avatar%20Select%20Screen/avatar_select_screen.dart';

import '../../Journals Screen/widgets/data_widget.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20.w,
        ),
        Stack(
          children: [
            Consumer<UserDataProvider>(
              builder: (BuildContext context, value, Widget? child) {
                return Container(
                  height: 90.h,
                  width: 90.h,
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage("assets/avatars/${value.avatar}.png"),
                        fit: BoxFit.contain),
                  ),
                  decoration: BoxDecoration(
                    color: kApp1.withOpacity(0.3),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: kApp1.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 15,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  // child: FittedBox(
                  //   child: Image.asset(
                  //     "assets/avatars/${value.avatar}.png",
                  //     height: 90.h,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                );
              },
            ),
            Positioned(
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const AvatarSelectScreen(
                      isSaved: true,
                    );
                  }));
                },
                child: Container(
                  height: 25.h,
                  width: 25.h,
                  decoration: const BoxDecoration(
                      color: kApp1, shape: BoxShape.circle),
                  child: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 20.r,
                  ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          width: 20.w,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Consumer<UserDataProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Text(
                    value.userName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style:customTitleBold( null,24.sp, FontWeight.w600),
                    textAlign: TextAlign.center,
                  );
                },
              ),
              Consumer<PointsProvider>(
                builder: (context, value, child) {
                  return SvgDataWidget(
                    value: value.getScore,
                    title: "Points",
                    svgPicture: SvgPicture.asset(
                      "assets/icons/points.svg",
                      height: 15.h,
                      width: 15.h,
                      color: kApp1,
                    ),
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
