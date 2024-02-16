import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/provider/Extras/user_data_provider.dart';
import 'package:knowyourself/provider/ToDo/status_provider.dart';
import 'package:knowyourself/screens/To%20Do%20Screen/Status%20Screen/story_screen.dart';
import 'package:knowyourself/screens/To%20Do%20Screen/widgets/celebrate_yourself_widget.dart';
import 'package:knowyourself/screens/To%20Do%20Screen/widgets/status_view.dart';

import 'package:knowyourself/screens/To%20Do%20Screen/widgets/to_do_widget.dart';
import 'package:knowyourself/utils/pref.dart';
import 'package:knowyourself/utils/ui_colors.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen>
    with AutomaticKeepAliveClientMixin {
  void _resetSavedData() {
    if (SharedPreferencesHelper.getDate() !=
        DateFormat('dd-MM-yyyy').format(DateTime.now())) {
      SharedPreferencesHelper.deleteStatus();
      SharedPreferencesHelper.saveDate(DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    _resetSavedData();
    return Scaffold(
      backgroundColor: kBackground1,
      body: SingleChildScrollView(child: Consumer<AppStateProvider>(
        builder: (BuildContext context, value, Widget? child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, top: 20),
              //   child: Consumer<UserDataProvider>(
              //     builder: (BuildContext context, value, Widget? child) {
              //       return CircleAvatar(
              //         backgroundColor: kTodoPrimaryColor,
              //         radius: 32.r,
              //         child: CircleAvatar(
              //           radius: 30.r,
              //           backgroundColor: const Color(0xFFD9D9D9),
              //           backgroundImage: AssetImage(
              //             "assets/avatars/${value.avatar}.png",
              //           ),
              //         ),
              //       );
              //     },
              //   ),
              // ),

              Consumer2<UserDataProvider, StatusProvider>(
                builder:
                    (BuildContext context, userData, status, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (status.statusList.isEmpty) {
                          return;
                        }
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return StoryScreen(
                            status: status.statusList,
                            user: userData,
                          );
                        }));
                      },
                      child: StatusView(
                          unSeenColor: kTodoPrimaryColor,
                          padding: 0,
                          spacing: 15,
                          indexOfSeenStatus: status.getSeenStatues() - 1,
                          radius: 25.r,
                          numberOfStatus: status.statusList.length,
                          strokeWidth: 5,
                          seenColor: Colors.grey,
                          image: "assets/avatars/${userData.avatar}.png"),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              const ToDoContainerWidget(),
              SizedBox(
                height: 10.h,
              ),
              const CelebrateYourselfWidget(),
              SizedBox(
                height: 80.h,
              ),
            ],
          );
        },
      )),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
