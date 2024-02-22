import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:knowyourself/notification%20manager/notification_manager.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:knowyourself/utils/ui_colors.dart';

// ignore: must_be_immutable
class ReminderNotificationWidget extends StatelessWidget {
  ReminderNotificationWidget({super.key});
  bool _canNotify = SharedPreferencesHelper.getReminderNotificationPermission();
  Duration _notificationTime = SharedPreferencesHelper.getNotificationTime();

  void _showDialog({
    required Widget child,
    required BuildContext context,
  }) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 260.h,
        padding: const EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 180.h, child: child),
            CupertinoButton(
              child: const Text('Set'),
              onPressed: () {
                _showNotification();
                SharedPreferencesHelper.saveNotificationTime(_notificationTime);
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }

  void _showNotification() {
    NotificationManager.showNotificationDaily(
      title: "Have Something to Write?",
      body: "Add it to your Journal!",
      time: Time(
        _notificationTime.inHours,
        _notificationTime.inMinutes.remainder(60),
      ),
    );
  }

  void requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).chipTheme.backgroundColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm,
                    size: 25.r,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Reminders",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  // Expanded(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [

                  //       Text(
                  //         "description",
                  //         maxLines: 1,
                  //         softWrap: true,
                  //         style: TextStyle(
                  //           fontSize: 9.sp,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  CupertinoSwitch(
                    activeColor: kPrimaryColor,
                    trackColor: Colors.white,
                    thumbColor: !_canNotify ? kPrimaryColor : Colors.white,
                    value: _canNotify,
                    onChanged: ((value) {
                      setState(
                        () {
                          _canNotify = value;

                          if (value == false) {
                            NotificationManager.cancelNotificationDaily();
                            SharedPreferencesHelper
                                .saveReminderNotificationPermission(_canNotify);
                            return;
                          }
                          requestNotificationPermission();
                          SharedPreferencesHelper
                              .saveReminderNotificationPermission(_canNotify);
                        },
                      );
                    }),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.alarm,
                    size: 25.r,
                    color: Colors.transparent,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Set Time",
                    style: TextStyle(
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  // Expanded(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [

                  //       Text(
                  //         "description",
                  //         maxLines: 1,
                  //         softWrap: true,
                  //         style: TextStyle(
                  //           fontSize: 9.sp,
                  //           fontWeight: FontWeight.w400,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  Semantics(
                    label: 'set notification timer',
                    hint: 'Press to set notification timer',
                    child: InkWell(
                      onTap: (() {
                        if (_canNotify) {
                          _showDialog(
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hm,
                                initialTimerDuration: _notificationTime,
                                onTimerDurationChanged: (Duration newDuration) {
                                  setState(
                                      () => _notificationTime = newDuration);
                                },
                              ),
                              context: context);
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          "${_notificationTime.inHours.toString().padLeft(2, '0')}:${_notificationTime.inMinutes.remainder(60).toString().padLeft(2, '0')}",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp,
                              color: _canNotify
                                  ? Theme.of(context).textTheme.bodySmall?.color
                                  : Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
