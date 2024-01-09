import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:knowyourself/notification%20manager/notification_manager.dart';
import 'package:knowyourself/screens/Main%20Screen/main_screen.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ReminderSreen extends StatelessWidget {
  const ReminderSreen({super.key});

  void _showNotification(Duration notificationTime) {
    NotificationManger.showNotificationDaily(
      title: "Have Something to Write?",
      body: "Add it to your Journal!",
      time: Time(
        notificationTime.inHours,
        notificationTime.inMinutes.remainder(60),
      ),
    );
  }

  Future<void> _confirmNotifications() async {
    final canNotify = await Permission.notification.request();
    if (canNotify.isGranted) {
      final Duration notificationTime =
          SharedPreferencesHelper.getNotificationTime();
      SharedPreferencesHelper.saveNotificationPermission(true);
      SharedPreferencesHelper.saveReminderNotificationPermission(true);
      _showNotification(notificationTime);
    } else {
      SharedPreferencesHelper.saveNotificationPermission(false);
      SharedPreferencesHelper.saveReminderNotificationPermission(false);
    }
  }

  void _navigate(BuildContext context) {
    final navigator = Navigator.of(context);

    navigator.pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) {
      return const MainScreen();
    }), (route) => false);
    SharedPreferencesHelper.saveHasOnboarded(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60),
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Want Us To Keep You on Track with Small ',
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: 'Reminders ',
                      style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.w600,
                          color: kPrimaryColor),
                    ),
                    TextSpan(
                      text: '?',
                      style: TextStyle(
                          fontSize: 30.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
            SvgPicture.asset(
              "assets/illustrations/reminder.svg",
              height: 350.h,
            ),
            GestureDetector(
              onTap: () async {
                await _confirmNotifications();
                // ignore: use_build_context_synchronously
                _navigate(context);
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                height: 50.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E5FD),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Center(
                  child: Text(
                    "Yes, Please",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: const Color(0xFF6A61F1),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _navigate(context);
              },
              child: Text(
                "No, Thanks",
                style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF7A89A3)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
