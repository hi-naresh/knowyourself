import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Main%20Screen/main_screen.dart';
import 'package:knowyourself/utils/ui_colors.dart';
import 'package:knowyourself/utils/pref.dart';

import '../../auth/local_auth/local_authentication.dart';

class AffirmationScreen extends StatelessWidget {
  const AffirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle(
      statusBarColor: kSecondaryColor,
      systemNavigationBarColor: getBottomNavBarColorbyTheme(context),
      systemNavigationBarIconBrightness: getSystemNavBarBrightness(context),
    );
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "We are here to talk with you,",
              style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.w600),
            ),
            SvgPicture.asset(
              "assets/illustrations/lets_dig_in.svg",
              height: 400.h,
              width: 250.w,
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Text(
            //   "\""
            //   "${affirmations[Random().nextInt(affirmations.length)]}"
            //   "\"",
            //   textAlign: TextAlign.center,
            //   style: const TextStyle(fontSize: 14, color: kSecondaryTextColor),
            // ),
            SizedBox(
              height: 10.h,
            ),
            GestureDetector(
              onTap: () async {
                NavigatorState navigator = Navigator.of(context);
                await _authenticate();
                navigator.pushAndRemoveUntil(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const MainScreen();
                  },
                ), (Route<dynamic> route) => false);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                width: 250.w,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E5FD),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    "Let's Go",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _authenticate() async {
    if (SharedPreferencesHelper.getAuthPermission() == true) {
      await LocalAuthApi.authenticate();
    }
  }
}
