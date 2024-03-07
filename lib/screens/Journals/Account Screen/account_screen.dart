import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Extras/Onboarding%20Screen/onboarding_screen.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/about_screen.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/widgets/account_widget.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/widgets/biometric_switch.dart';

import 'package:knowyourself/screens/Journals/Account%20Screen/widgets/notification_switch.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/widgets/reminder_notification_widget.dart';
import 'package:knowyourself/screens/Journals/Account%20Screen/widgets/theme_switch.dart';
import 'package:knowyourself/screens/Journals/Journals%20Screen/widgets/switch_container.dart';
import 'package:knowyourself/screens/widgets/custom_header.dart';
import 'package:knowyourself/utils/app_info.dart';
import 'package:knowyourself/utils/ui_colors.dart';

import 'package:knowyourself/utils/utils_functions.dart';

import '../../widgets/AppButtons.dart';
import '../../widgets/Constants.dart';

// ignore: must_be_immutable
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin {

  void showLogoutConfirmationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30.0),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height *
                  0.5, // Set desired height here
            ),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(
                    thickness: 6.0,
                    indent: 130.0,
                    endIndent: 130.0,
                  ),
                  const SizedBox(height: 30.0),
                  const Text(
                    'Log Out',
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'SF-Pro-Display',
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  appButtonFunc(
                    context,
                    gradient(context),
                    'Logout',
                        () async {
                      // Perform the logout action
                      FirebaseAuth auth = FirebaseAuth.instance;
                      await auth.signOut();

                      // Close all screens and go back to the login screen
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                              const OnBoardingScreen()),
                              (route) => false
                      );
                    },
                  ),
                  appButtonFunc(
                    margin: const EdgeInsets.only(top: 20.0),
                    context,
                    border(context),
                    'Cancel',
                        () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomHeader(
                title: "Settings",
                  custom: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                        color: kApp1, shape: BoxShape.circle),
                    child: Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 25.r,
                    ),
                  ),
                ),
              )),
              const AccountWidget(),
              SizedBox(
                height: 20.h,
              ),
              SwitchContainer(
                leadingIcon: Icons.dark_mode_outlined,
                title: "Dark Mode",
                description: "Switch between dark and light mode",
                switchWidget: const ThemeSwitch(),
                backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              ),
              SwitchContainer(
                leadingIcon: Icons.fingerprint,
                title: "Biometric Login",
                description: "Login with your face/fingerprint",
                switchWidget: const BiometricSwitch(),
                backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              ),
              ReminderNotificationWidget(),
              SwitchContainer(
                leadingIcon: Icons.notifications_active_outlined,
                title: "Notifications",
                description: "Do you need daily Notifications?",
                switchWidget: const NotificationSwitch(),
                backgroundColor: Theme.of(context).chipTheme.backgroundColor,
              ),
              InkWell(
                onTap: () {
                  openPlayStore();
                },
                child: SwitchContainer(
                  leadingIcon: Icons.reviews_outlined,
                  title: "Rate Us",
                  description:
                  "We would love to know what you think of our app",
                  switchWidget: Icon(
                    Icons.chevron_right,
                    size: 25.r,
                  ),
                  backgroundColor: Theme.of(context).chipTheme.backgroundColor,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const AboutScreen();
                  }));
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.asset(
                            "assets/res/logo.png",
                            height: 25.r,
                            width: 25.r,
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About KYB",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              AppInfo.version,
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 25.r,
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showLogoutConfirmationBottomSheet(context);
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.only(
                      top: 20, bottom: 20, left: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).chipTheme.backgroundColor,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 25.r,
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Logout",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "Logout from your account",
                              maxLines: 1,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 25.r,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20.h,
              ),
              Image.asset(
                "assets/res/sailcc.png",
                height: 40.r,
              ),
              SizedBox(
                height: 15.h,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Made for SAILC",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 80.h,
              ),
            ],
          ),
          // child: Consumer<AppStateProvider>(
          //   builder: (BuildContext context, value, Widget? child) {

          //   },
          // ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
